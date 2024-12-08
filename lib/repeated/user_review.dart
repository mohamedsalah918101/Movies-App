import 'package:flutter/material.dart';

class UserReview extends StatefulWidget {
  final dynamic revDetails;

  const UserReview({super.key, required this.revDetails});

  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    List reviewDetails = widget.revDetails;
    if (reviewDetails.isEmpty) {
      return const Center();
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "User Reviews",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAll = !showAll;
                    });
                  },
                  child: Row(
                    children: [
                      showAll == false
                          ? Text(
                        'All Reviews ' + '${reviewDetails.length} ',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          : const Text(
                              "Show Less",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          showAll == true
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: reviewDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                reviewDetails[index]['avatarphoto'],),
                                              fit: BoxFit.cover,),),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                reviewDetails[index]['name'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              reviewDetails[index]['creationdate'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,),
                                            )
                                          ],
                                        )
                                      ],
                                    ),),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            reviewDetails[index]['rating'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      reviewDetails[index]['review'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(reviewDetails[0]
                                                ['avatarphoto']),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            reviewDetails[0]['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          reviewDetails[0]['creationdate'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        reviewDetails[0]['rating'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                reviewDetails[0]['review'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
        ],
      );
    }
  }
}
