// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:newzapp/Services/services.dart';
import 'package:newzapp/widget/fonts.dart';
import 'package:shimmer/shimmer.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUsBusinessData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 150,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 180,
                                width: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors
                                      .white, // Background color of the shimmering tile
                                )),
                          ),
                        ],
                      ),
                      // subtitle: Container(
                      //   height: 10,
                      //   width: double.infinity,
                      //   color: Colors.white,
                      // ),
                    );
                  }),
            );
            // Shimmer.fromColors(
            //   baseColor: Colors.grey.shade200,
            //   highlightColor: Colors.grey.shade400,
            //   child: Container(
            //       height: 230,
            //       width: 200,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color:
            //             Colors.white, // Background color of the shimmering tile
            //       )),
            // );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            //final List<dynamic> ratedMovies = snapshot.data!;
            return SizedBox(
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Future<void> showAlertDialog(
                                BuildContext context) async {
                              return showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // icon: Icon(
                                    //   Icons.abc,
                                    //   color: Colors.amber,
                                    // ),

                                    title: Image.network(
                                      snapshot.data![index]['urlToImage'] ??
                                          'loading',
                                      color: Colors.black26,
                                      colorBlendMode: BlendMode.darken,
                                    ),
                                    //contentTextStyle: ,
                                    content: text(
                                      0,
                                      color: Colors.black,
                                      size: 15,
                                      data: snapshot.data![index]['content'] ??
                                          'Not Available',
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
                          child: Stack(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 350,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        snapshot.data![index]['urlToImage'],
                                      ),
                                    )),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 10,
                                child: SizedBox(
                                    //height: 200,
                                    width: 200,
                                    child: text(
                                      0,
                                      data: snapshot.data![index]['title'],
                                      color: Colors.white,
                                      size: 13,
                                      Bold: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }
        });
  }
}
