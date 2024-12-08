import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/details/checker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../api/api_key.dart';

class SearchBarFunction extends StatefulWidget {
  const SearchBarFunction({super.key});

  @override
  State<SearchBarFunction> createState() => _SearchBarFunctionState();
}

class _SearchBarFunctionState extends State<SearchBarFunction> {
  List<Map<String, dynamic>> searchResult = [];
  final TextEditingController searchText = TextEditingController();
  bool showList = false;
  var val1;

  Future<void> searchListFunction(String val) async {
    var searchUrl =
        'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=$val';

    var searchresponse = await http.get(Uri.parse(searchUrl));
    if (searchresponse.statusCode == 200) {
      var tempdata = jsonDecode(searchresponse.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        //only add value if all are present
        if (searchjson[i]['id'] != null &&
            searchjson[i]['poster_path'] != null &&
            searchjson[i]['vote_average'] != null &&
            searchjson[i]['media_type'] != null) {
          searchResult.add({
            'id': searchjson[i]['id'],
            'poster_path': searchjson[i]['poster_path'],
            'vote_average': searchjson[i]['vote_average'],
            'media_type': searchjson[i]['media_type'],
            'popularity': searchjson[i]['popularity'],
            'overview': searchjson[i]['overview'],
          });

          if (searchResult.length > 20) {
            searchResult.removeRange(20, searchResult.length);
          }
        } else {
          print('null value found');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showList = !showList;
      },
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, top: 30, bottom: 20, right: 10),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  autofocus: false,
                  controller: searchText,
                  cursorColor: Colors.yellow,
                  onSubmitted: (value) {
                    searchResult.clear();
                    setState(() {
                      val1 = value;
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  onChanged: (value) {
                    searchResult.clear();

                    setState(() {
                      val1 = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              webBgColor: "#000000",
                              webPosition: "center",
                              webShowClose: true,
                              msg: "Search Cleared",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor:
                                  const Color.fromRGBO(18, 18, 18, 1),
                              textColor: Colors.white,
                              fontSize: 16.0);

                          setState(() {
                            searchText.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.amber.withOpacity(0.6),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.amber,
                      ),
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.2)),
                      border: InputBorder.none),
                ),
              ),
              //
              //
              const SizedBox(
                height: 5,
              ),

              //if textField has focus and search result is not empty then display search result

              searchText.text.isNotEmpty
                  ? FutureBuilder(
                      future: searchListFunction(val1),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                              height: 400,
                              child: ListView.builder(
                                  itemCount: searchResult.length,
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DescriptionCheckUI(
                                                        newID:
                                                            searchResult[index]
                                                                ['id'],
                                                        newType:
                                                            searchResult[index]
                                                                ['media_type'],
                                                      )));
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 4, bottom: 4),
                                            height: 180,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: const BoxDecoration(
                                                color: Color.fromRGBO(
                                                    20, 20, 20, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(children: [
                                              Expanded(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      image: DecorationImage(
                                                          //color filter
                                                          image: NetworkImage(
                                                              'https://image.tmdb.org/t/p/w500${searchResult[index]['poster_path']}'),
                                                          fit: BoxFit.fill)),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                      ///////////////////////
                                                      //media type
                                                      Container(
                                                        alignment: Alignment
                                                            .topCenter,
                                                        child: Text(
                                                          '${searchResult[index]['media_type']}',
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),

                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            //vote average box
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .amber
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(6))),
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                      size:
                                                                          20,
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                          5,
                                                                    ),
                                                                    Text(
                                                                      (searchResult[index]['vote_average'] as num).toStringAsFixed(1),
                                                                      style: const TextStyle(
                                                                        color: Colors.white,
                                                                      ),)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),

                                                            //popularity
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .amber
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(8))),
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .people_outline_sharp,
                                                                      color: Colors
                                                                          .amber,
                                                                      size:
                                                                          20,
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                          5,
                                                                    ),
                                                                    Text(
                                                                      (searchResult[index]['popularity'] as num).toStringAsFixed(1),
                                                                      style: const TextStyle(
                                                                      color: Colors.white,
                                                                    ),)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            //
                                                          ],
                                                        ),
                                                      ),

                                                      Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          height: 85,
                                                          child: Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              ' ${searchResult[index]['overview']}',
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      12,
                                                                  color: Colors
                                                                      .white)))
                                                    ])),
                                              )
                                            ])));
                                  }));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.amber,
                          ));
                        }
                      })
                  : Container(),
            ],
          )),
    );
  }
}
