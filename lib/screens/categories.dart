// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:newzapp/widget/fonts.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  AllCategoriesState createState() => AllCategoriesState();
}

class AllCategoriesState extends State<AllCategories> {
  List<dynamic> _news = [];
  String _selectedcategories =
      "business"; // Default source, you can change it to any default source

  Future<void> fetchNews(String categories) async {
    final queryParameters = {
      'q': categories,
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
          data: _selectedcategories.toUpperCase(),
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
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "health";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('Health'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "general";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('General'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "war";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('War'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "bitcoin";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('Bitcoin'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "love";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('Love'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "science";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('Science'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ////
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "entertainment";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('Entertainment'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "technology";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('Technology'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedcategories = "sports";
                      });
                      fetchNews(_selectedcategories);
                    },
                    child: const Text('Sports'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                String date = formatDate(
                  _news[index]['publishedAt'] ?? 'Not Available',
                );

                return InkWell(
                  onTap: () {
                    Future<void> _showAlertDialog(BuildContext context) async {
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

                    _showAlertDialog(context);
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
