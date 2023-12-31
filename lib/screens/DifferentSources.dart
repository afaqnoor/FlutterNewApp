// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:newzapp/widget/fonts.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  AllState createState() => AllState();
}

class AllState extends State<All> {
  List<dynamic> _news = [];
  String _selectedSource =
      "bbc-news"; // Default source, you can change it to any default source

  Future<void> fetchNews(String source) async {
    final queryParameters = {
      'sources': source,
      'apiKey': '02a212ded5af40528a0d30959c5dadf1',
    };

    final uri = Uri.https('newsapi.org', '/v2/top-headlines', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _news = data["articles"];
      });
    } else {
      throw Exception('Error');
    }
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 241, 255, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(246, 241, 255, 1),
        centerTitle: true,
        title: text(
          0,
          data: _selectedSource.toUpperCase(),
          color: Colors.black,
          size: 30,
          Bold: FontWeight.bold,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              'assets/previous.png',
              height: 15,
              width: 15,
            ),
          ),
        ),
        actions: [
          //created pop menu & setstate to change the data to fetch data
          PopupMenuButton<String>(
            onSelected: (source) {
              setState(() {
                _selectedSource = source;
              });
              fetchNews(_selectedSource);
            }, //popup menu items
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "bbc-news",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'BBC News',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "cnn",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'CNN',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "al-jazeera-english",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'al jazeera English',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "cbc-news",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'CBC News',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "the-wall-street-journal",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'The Wall Street journal',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "bloomberg",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'Bloomberg',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "financial-post",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'Financial Post',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "google-news",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'Google News',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "the-washington-post",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'The Washington Post',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "nbc-news",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'NBC News',
                    size: 15,
                  ),
                ),
                const PopupMenuItem(
                  value: "usa-today",
                  child: text(
                    0,
                    color: Colors.black,
                    data: 'USA Today ',
                    size: 15,
                  ),
                ),
                // Add more sources as needed...
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              fetchNews(_selectedSource);
            },
            child: const Text('Get News'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                String date = formatDate(
                  _news[index]['publishedAt'] ?? 'Not Available',
                );
//create the whole data in inkwell
                return InkWell(
                  //on tap create the alertdialog to show more sppecific data
                  onTap: () {
                    Future<void> showAlertDialog(BuildContext context) async {
                      return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // icon: Icon(
                            //   Icons.abc,
                            //   color: Colors.amber,
                            // ),

                            title: Image.network(
                              _news[index]['urlToImage'] ?? 'loading',
                            ),
                            //contentTextStyle: ,
                            content: text(
                              0,
                              color: Colors.black,
                              size: 15,
                              data: _news[index]['content'] ?? 'Not Available',
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                    showAlertDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2.0,
                            blurRadius: 5.0,
                            offset: const Offset(
                                0, 3), // changes the position of the shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          _news[index]['urlToImage'] ??
                                              'loading',
                                        ),
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      text(0,
                                          data: _news[index]['title'] ??
                                              'Not Available',
                                          color: Colors.black,
                                          size: 15),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                text(
                                                  0,
                                                  data: _news[index]['source']
                                                          ['id'] ??
                                                      'Nill',
                                                  color: Colors.blueAccent,
                                                  size: 15,
                                                  Bold: FontWeight.bold,
                                                ),
                                                const Text('.'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('.'),
                                                text(
                                                  0,
                                                  data: date,
                                                  color: Colors.black,
                                                  size: 15,
                                                  Bold: FontWeight.bold,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
            ),
          ),
        ],
      ),
    );
  }
}
