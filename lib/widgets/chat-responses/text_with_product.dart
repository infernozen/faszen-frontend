import 'package:faszen/screens/productpage.dart';
import 'package:faszen/widgets/gradient_border.dart';
import 'package:flutter/material.dart';
import 'package:faszen/models/chatmodel.dart';

import '../animated_box.dart';

// ignore: must_be_immutable
class ProductWithText extends StatefulWidget {
  const ProductWithText(
      {super.key,
      required this.imageUrl,
      required this.text,
      required this.index,
      required this.list,
      required this.product});

  final String? text;
  final int? index;
  final List<ChatModel>? list;
  final String? imageUrl;
  final Map<String, dynamic> product;

  @override
  _ProductWithTextState createState() => _ProductWithTextState();
}

class _ProductWithTextState extends State<ProductWithText> {
  bool _isFullScreen = false;
  bool isShimmer = false;

  void checkNULL() {
    widget.product['model3D'] = widget.product['model3D']?.toString() ?? '';
    widget.product['arLensID'] = widget.product['arLensID']?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double maxWidth = constraints.maxWidth * 0.7;
            if (widget.list![widget.index!].isShimmer == false) {
              widget.list![widget.index!].isShimmer = true;
              return FutureBuilder<void>(
                future: Future.delayed(const Duration(seconds: 2)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      isShimmer) {
                    return AnimatedBox();
                  } else {
                    return Stack(
                      children: [
                        Container(
                          width: maxWidth,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF000000),
                                Color(0xFF575757),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: const GradientBorder(
                              borderGradient: LinearGradient(
                                colors: [
                                  Color(0xFFAC4949),
                                  Color(0xFFD95358),
                                  Color(0xFFD35568),
                                  Color(0xFFCA665E),
                                  Color(0xFFDAD767),
                                  Color(0xFF588DD3),
                                  Color(0xFF525CD3),
                                  Color(0xFFBB66CC),
                                ],
                                tileMode: TileMode.repeated,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.0005,
                                  0.0534,
                                  0.2153,
                                  0.4051,
                                  0.5749,
                                  0.7497,
                                  0.8346,
                                  0.9995,
                                ],
                                transform: GradientRotation(0.0),
                              ),
                              width: 2.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(
                                widget.text!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: _isFullScreen
                                      ? Colors.transparent
                                      : Colors.white,
                                  //wordSpacing: 2,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: AspectRatio(
                                      aspectRatio: 16 / 10,
                                      child: !_isFullScreen
                                          ? Image.network(
                                              widget.imageUrl!,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: IconButton(
                                      icon: const Icon(Icons.link_outlined),
                                      onPressed: () {
                                        setState(() {
                                          checkNULL();
                                          Navigator.push(context,MaterialPageRoute ( builder : (context) => Product(
                                            id: widget.product['id'].toString(),
                                            title: widget.product['title'],
                                            category: widget.product['category'],
                                            rating: double.parse(widget.product['rating']),
                                            price: double.parse(widget.product['price']),
                                            organizationImageUrl: List<String>.from(
                                                widget.product['organisationImageUrl'])[0],
                                            name: widget.product['name'],
                                            description: widget.product['description'] != null &&
                                                    widget.product['description'] is List
                                                ? List<String>.from(widget.product['description'])
                                                : [],
                                            arLensID: widget.product['arLensID'],
                                            model3D: widget.product['model3D'],
                                            isAvailable: widget.product['isAvailable']
                                                    .toString()
                                                    .toLowerCase() ==
                                                'true',
                                            isActive:
                                                widget.product['isActive'].toString().toLowerCase() ==
                                                    'true',
                                            is3Davailable: widget.product['is3Davailable']
                                                    .toString()
                                                    .toLowerCase() ==
                                                'true',
                                            isARTryOnAvailable: widget.product['isARTryOnAvailable']
                                                    .toString()
                                                    .toLowerCase() ==
                                                'true',
                                            sizes: widget.product['sizes'] != null &&
                                                    widget.product['sizes'] is List
                                                ? List<String>.from(widget.product['sizes'])
                                                : [],
                                            rediretLink: widget.product['redirectLinks'] != null &&
                                                    widget.product['redirectLinks'] is List &&
                                                    widget.product['redirectLinks'].isNotEmpty
                                                ? List<String>.from(widget.product['redirectLinks'])[0]
                                                : ' ',
                                            images: widget.product['images'] != null &&
                                                    widget.product['images'] is List
                                                ? List<String>.from(widget.product['images'])
                                                : [],
                                            similarproducts: widget.product['similarProducts'] !=
                                                        null &&
                                                    widget.product['similarProducts'] is List
                                                ? List<String>.from(widget.product['similarProducts'])
                                                : [],
                                            variants: widget.product['variants'] != null &&
                                                    widget.product['variants'] is List
                                                ? List<String>.from(widget.product['variants'])
                                                : [],
                                            tags: List<String>.from(widget.product['tags']), organizationName: '',
                                          )));
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            } else {
              return Stack(
                children: [
                  Container(
                    width: maxWidth,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF000000),
                          Color(0xFF575757),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: const GradientBorder(
                        borderGradient: LinearGradient(
                          colors: [
                            Color(0xFFAC4949),
                            Color(0xFFD95358),
                            Color(0xFFD35568),
                            Color(0xFFCA665E),
                            Color(0xFFDAD767),
                            Color(0xFF588DD3),
                            Color(0xFF525CD3),
                            Color(0xFFBB66CC),
                          ],
                          tileMode: TileMode.repeated,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.0005,
                            0.0534,
                            0.2153,
                            0.4051,
                            0.5749,
                            0.7497,
                            0.8346,
                            0.9995,
                          ],
                          transform: GradientRotation(0.0),
                        ),
                        width: 2.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          widget.text!,
                          style: TextStyle(
                            color: _isFullScreen
                                ? Colors.transparent
                                : Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            //wordSpacing: 2,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: AspectRatio(
                                aspectRatio: 16 / 10,
                                child: !_isFullScreen
                                    ? Image.network(
                                        widget.imageUrl!,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                              ),
                            ),
                            if (!_isFullScreen)
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: IconButton(
                                  icon: const Icon(Icons.link_outlined),
                                  onPressed: () {
                                    setState(() {
                                      checkNULL();
                                          Navigator.push(context,MaterialPageRoute ( builder : (context) => Product(
                                            id: widget.product['id'].toString(),
                              title: widget.product['title'],
                              category: widget.product['category'],
                              rating: double.parse(widget.product['rating']),
                              price: double.parse(widget.product['price']),
                              organizationImageUrl: List<String>.from(
                                  widget.product['organisationImageUrl'])[0],
                              name: widget.product['name'],
                              description: widget.product['description'] != null &&
                                      widget.product['description'] is List
                                  ? List<String>.from(widget.product['description'])
                                  : [],
                              arLensID: widget.product['arLensID'],
                              model3D: widget.product['model3D'],
                              isAvailable: widget.product['isAvailable']
                                      .toString()
                                      .toLowerCase() ==
                                  'true',
                              isActive:
                                  widget.product['isActive'].toString().toLowerCase() ==
                                      'true',
                              is3Davailable: widget.product['is3Davailable']
                                      .toString()
                                      .toLowerCase() ==
                                  'true',
                              isARTryOnAvailable: widget.product['isARTryOnAvailable']
                                      .toString()
                                      .toLowerCase() ==
                                  'true',
                              sizes: widget.product['sizes'] != null &&
                                      widget.product['sizes'] is List
                                  ? List<String>.from(widget.product['sizes'])
                                  : [],
                              rediretLink: widget.product['redirectLinks'] != null &&
                                      widget.product['redirectLinks'] is List &&
                                      widget.product['redirectLinks'].isNotEmpty
                                  ? List<String>.from(widget.product['redirectLinks'])[0]
                                  : ' ',
                              images: widget.product['images'] != null &&
                                      widget.product['images'] is List
                                  ? List<String>.from(widget.product['images'])
                                  : [],
                              similarproducts: widget.product['similarProducts'] !=
                                          null &&
                                      widget.product['similarProducts'] is List
                                  ? List<String>.from(widget.product['similarProducts'])
                                  : [],
                              variants: widget.product['variants'] != null &&
                                      widget.product['variants'] is List
                                  ? List<String>.from(widget.product['variants'])
                                  : [],
                              tags: List<String>.from(widget.product['tags']), organizationName: '',
                                          )));
                                    });
                                  },
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
