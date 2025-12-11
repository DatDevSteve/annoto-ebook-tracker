import 'dart:core';
import 'dart:io';
import 'package:annoto/login_signup/login_page.dart';
import 'package:annoto/ui_elements/main_appBar.dart';
import 'package:annoto/ui_elements/transitions.dart';
import 'package:epubx/epubx.dart' as epubx;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:annoto/ebook_reader.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:text_marquee/text_marquee.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Widget _defaultCover() {
  return Container(
    color: Colors.grey[800],
    alignment: Alignment.center,
    child: Icon(Icons.book, color: Colors.green, size: 40),
  );
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});
  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Map<String, dynamic>> eBooks = [];
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("/// POST FRAME CALLBACK: LOADING LIBRARY");
    });
    eBooks.clear();
    setState(() {});
  }

  Future<void> loadEBook() async {
    /// Uses a file picker to pick the epub file, followed by extracting book title, author, chapters, coverpage bytes and book bytes
    /// A list is created to map on ebook cover cards which are displayed on frontend to select a book and read it 
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["epub"],
      type: FileType.custom,
      dialogTitle: "Select your eBook (.epub file)",
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      // Process the book in bytes to feed it into epubx
      Uint8List? bytes = file.bytes;
      if (bytes == null && file.path != null) {
        bytes = await File(
          file.path!,
        ).readAsBytes(); //read from file path if bytes are null
      }

      if (bytes != null) {
        try {
          final book = await epubx.EpubReader.readBook(bytes);
          final img.Image? bookCover = book.CoverImage;
          final bookTitle = book.Title ?? "Untitled eBook";
          String? author = book.Author ?? "Untitled Author";
          List? chapters = book.Chapters;
          String? bookPath; //Web doesnt support file.path and returns null
          if (!kIsWeb) {
            bookPath = file.path;
          }

          bool bookExists = eBooks.any((item) => item['title'] == bookTitle);

          if (bookExists) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("This book is already added in your library"),
              ),
            );
            return;
          }
          // Since bookCover is not an Image widget, we need to make an image widget:
          Widget coverImage = _defaultCover();
          Uint8List pngbytes = Uint8List(0);

          try {
            if (bookCover != null) {
              pngbytes = Uint8List.fromList(img.encodePng(bookCover));
              coverImage = Image.memory(
                pngbytes,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _defaultCover(),
              );
            }
          } catch (e) {
            //debugPrint('//ERROR ENCODING BOOK COVER: $e');
            coverImage = _defaultCover();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("BCE ERROR: $e")));
          }
          setState(() {
            eBooks.add({
              'title': bookTitle,
              'bookCover': bookCover,
              'bookBytes': bytes,
              'coverWidget': coverImage,
              'path': bookPath,
              'author': author,
              'chapterCount': chapters?.length,
            });
          });

          //debugPrint('/// LOADING BOOK TILE');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Book Loaded Successfully")));
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error Loading File: $e")));
        }
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No Book was selected")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppbar(title: "LIBRARY",firstBtnFunc: (){
        supabase.auth.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You have been Signed Out!"), backgroundColor: Colors.red),
      );
        Navigator.of(context).pushReplacement(transitionPage(() => LoginPage()));
      }),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("LOCAL LIBRARY", style: textTheme.headlineMedium),
              ),
              TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Loading Book. Please Wait.")),
                  );
                  await loadEBook();
                },
                child: Icon(
                  Icons.add_circle,
                  size: 20,
                  color: Color.fromRGBO(7, 113, 55, 1),
                ),
              ),
            ],
          ),
          eBooks.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      "Click on the + button to add your book and get started!",
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 280,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        ...eBooks.map((element) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Color.fromRGBO(16, 19, 24, 1),
                                context: context,
                                builder: (BuildContext context) {
                                  bool isToggled = false;
                                  debugPrint(
                                    "// AUTHOR IS: ${element['author']}",
                                  );
                                  return StatefulBuilder(
                                    builder:
                                        (
                                          BuildContext context,
                                          StateSetter setModalState,
                                        ) {
                                          return Expanded(
                                            child: SizedBox(
                                              height: 250,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                10.0,
                                                              ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    15,
                                                                  ),
                                                                ),
                                                            child: Container(
                                                              height: 230,
                                                              width: 150,
                                                              child:
                                                                  element['coverWidget'],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          //width: 440,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                child: Text(
                                                                  element['title'] ??
                                                                      "Untitled Book",
                                                                  style: GoogleFonts.inriaSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                element['author'] ??
                                                                    "No Author",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.inriaSans(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Total Chapters: ${element['chapterCount'] ?? "Null"}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.inriaSans(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontSize: 16,
                                                                  color: Color.fromRGBO(7, 113, 55, 1),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  ElevatedButton.icon(
                                                                    onPressed: () {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder:
                                                                              (
                                                                                context,
                                                                              ) => EbookReader(
                                                                                bookBytes:
                                                                                    element['bookBytes'] ??
                                                                                    List<
                                                                                      int
                                                                                    >.filled(
                                                                                      0,
                                                                                      0,
                                                                                    ),
                                                                              ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    label: Text(
                                                                      'Read',
                                                                      style: textTheme
                                                                          .bodySmall,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .arrow_circle_right_outlined,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20,
                                                                    ),
                                                                    style: ElevatedButton.styleFrom(
                                                                      padding:
                                                                          EdgeInsets.fromLTRB(
                                                                            10,
                                                                            20,
                                                                            10,
                                                                            20,
                                                                          ),
                                                                      backgroundColor:
                                                                          Color.fromRGBO(
                                                                            7,
                                                                            113,
                                                                            55,
                                                                            1,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  IconButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Color.fromRGBO(
                                                                            7,
                                                                            113,
                                                                            55,
                                                                            1,
                                                                          ),
                                                                    ),
                                                                    onPressed: () {
                                                                      setModalState(() {
                                                                        isToggled =
                                                                            !isToggled;
                                                                      });
                                                                    },
                                                                    icon: Icon(
                                                                      isToggled
                                                                          ? Icons
                                                                                .favorite
                                                                          : Icons
                                                                                .favorite_border,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  IconButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                    onPressed: () {
                                                                      final index =
                                                                          eBooks.indexOf(
                                                                            element,
                                                                          );
                                                                      setState(() {
                                                                        eBooks.removeAt(
                                                                          index,
                                                                        );
                                                                      });
                                                                      ScaffoldMessenger.of(
                                                                        context,
                                                                      ).showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                                "Removed Book: '${element['title']}' from Library",
                                                                              ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                Card(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 230,
                                          width: 150,
                                          child: element['coverWidget'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
