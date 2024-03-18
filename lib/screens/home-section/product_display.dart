import 'package:flutter/material.dart';

class ProductDisplay extends StatelessWidget {
  const ProductDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color.fromRGBO(230, 230, 230, 1), // Background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        right: BorderSide(
                            width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
                        bottom: BorderSide(
                            width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(),
                        Icon(Icons.sort_outlined),
                        SizedBox(width: 5),
                        Text(
                          'Sort',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        right: BorderSide(
                            width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
                        bottom: BorderSide(
                            width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          'Popularity',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 3),
                        Icon(Icons.keyboard_arrow_down),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        right: BorderSide(
                            width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
                        bottom: BorderSide(
                            width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 3),
                        Icon(Icons.keyboard_arrow_down),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        right: BorderSide(
                            width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
                        bottom: BorderSide(
                            width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(),
                        Icon(Icons.filter_alt),
                        SizedBox(width: 5),
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GridView.builder(
              padding: const EdgeInsets.only(top: 25),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4.5,
              ),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(3),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 3.5,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/profile-pic.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(217, 217, 217, 0.36),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                    Icons.favorite_outline_rounded,
                                    color: Colors.black),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 2, 155, 45).withOpacity(0.6),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: const Text(
                                  '4.7',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Black',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40)),
                                    // border: Border.(color: Colors.white),
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 5, bottom: 5, right: 5),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Starts from ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '₹1000',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 2,
                          color: const Color.fromRGBO(230, 230, 230, 1)),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 4, right: 8),
                        child: Text(
                          'Product $index bla bla bla bla bla',
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      const SizedBox(height: 4.5),
                      const Row(
                        children: [
                          Spacer(),
                          EllipticalBar(text: 'Ask Fizard 🪄'),
                          Spacer(),
                          EllipticalBar(text: 'Add to Wardrobe'),
                          Spacer()
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EllipticalBar extends StatelessWidget {
  final String text;

  const EllipticalBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20), // Half the height of the container
        color: Colors.black,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 11, fontFamily: 'Poppins', color: Colors.white),
      ),
    );
  }
}
