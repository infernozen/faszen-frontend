// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:faszen/repositories/product_data_provider.dart';
import 'package:faszen/screens/productpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDisplayPage extends StatelessWidget {
  const ProductDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductDataProvider(),
      child: const ProductDisplay(),
    );
  }
}

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({super.key});
  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  List<String> sortcontent = [
        'Relevance',
        'Price(Low to High)',
        'Price(High to Low)',
        'Rating',
      ],
      categorycontent = [
        'Popular',
        'Tops',
        'Bottoms',
        'Inners',
        'Athleisure',
        'Formals',
        'Casuals',
        'Desi-wear',
        'Western-wear',
        'Streat wear',
        'Luxury-wear',
        'Gift-wear',
        'Footwear',
        'Hats and Beanie',
        'Accessories'
      ],
      popularitycontent = [
        'High',
        'Mid',
        'Low',
      ],
      gendercontent = ['Male', 'Female'],
      agecontent = ['Kid', 'Teen', 'Adult'],
      ratingcontent = [
        '2.0 and above',
        '3.0 and above',
        '3.5 and above',
        '4.0 and above',
        '4.5 and above'
      ];
  List<bool> sortbool = [],
      categorybool = [],
      popularitybool = [],
      agebool = [],
      ratingbool = [],
      genderbool = [];
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    sortbool = List.generate(sortcontent.length, (index) => false);
    categorybool = List.generate(categorycontent.length, (index) => false);
    popularitybool = List.generate(popularitycontent.length, (index) => false);
    genderbool = List.generate(gendercontent.length, (index) => false);
    agebool = List.generate(agecontent.length, (index) => false);
    ratingbool = List.generate(ratingcontent.length, (index) => false);
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider =
          Provider.of<ProductDataProvider>(context, listen: false);
      dataProvider.fetchAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ProductDataProvider>(context);
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
                  child: GestureDetector(
                    onTap: () => {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetContent(
                            filtername: "Sort",
                            width: 0.35,
                            content: sortcontent,
                            contentbool: sortbool,
                          );
                        },
                      ),
                    },
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(230, 230, 230, 1)),
                          bottom: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(230, 230, 230, 1)),
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
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () => {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetContent(
                            filtername: "Popularity",
                            width: 0.3,
                            content: popularitycontent,
                            contentbool: popularitybool,
                          );
                        },
                      ),
                    },
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(230, 230, 230, 1)),
                          bottom: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(230, 230, 230, 1)),
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
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () => {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetContent(
                              filtername: "Category",
                              width: 0.5,
                              content: categorycontent,
                              contentbool: categorybool);
                        },
                      ),
                    },
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(230, 230, 230, 1)),
                          bottom: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(230, 230, 230, 1)),
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
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ShowFilters(
                                agecontent: agecontent,
                                filtername: "Filter",
                                ratingcontent: ratingcontent,
                                gendercontent: gendercontent,
                                agebool: agebool,
                                ratingbool: ratingbool,
                                genderbool: genderbool);
                          })
                    },
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(230, 230, 230, 1)),
                          bottom: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(230, 230, 230, 1)),
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
              itemCount: dataProvider.allproducts.length,
              itemBuilder: (BuildContext context, int index) {
                var product = dataProvider.allproducts[index];
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Product(
                                        id: product['id'].toString(),
                                        name: product['name'] ?? '',
                                        title: product['title'] ?? '',
                                        description: product['description'] !=
                                                    null &&
                                                product['description'] is List
                                            ? List<String>.from(
                                                product['description'])
                                            : [],
                                        category: product['category'] ?? '',
                                        price: product['price'] != null
                                            ? double.parse(
                                                product['price'].toString())
                                            : 0.0,
                                        sizes: product['sizes'] != null &&
                                                product['sizes'] is List
                                            ? List<String>.from(
                                                product['sizes'])
                                            : [],
                                        images: product['images'] != null &&
                                                product['images'] is List
                                            ? List<String>.from(
                                                product['images'])
                                            : [],
                                        similarproducts:
                                            product['similarProducts'] !=
                                                        null &&
                                                    product['similarProducts']
                                                        is List
                                                ? List<String>.from(
                                                    product['similarProducts'])
                                                : [],
                                        variants: product['variants'] != null &&
                                                product['variants'] is List
                                            ? List<String>.from(
                                                product['variants'])
                                            : [],
                                        rating: product['rating'] != null
                                            ? double.parse(
                                                product['rating'].toString())
                                            : 0.0,
                                        tags: product['tags'] != null &&
                                                product['tags'] is List
                                            ? List<String>.from(product['tags'])
                                            : [],
                                        isAvailable:
                                            product['isAvailable'] != null &&
                                                product['isAvailable']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'true',
                                        isActive: product['isActive'] != null &&
                                            product['isActive']
                                                    .toString()
                                                    .toLowerCase() ==
                                                'true',
                                        model3D: product['model3D'] ?? '',
                                        isARTryOnAvailable:
                                            product['isARTryOnAvailable'] !=
                                                    null &&
                                                product['isARTryOnAvailable']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'true',
                                        is3Davailable:
                                            product['is3Davailable'] != null &&
                                                product['is3Davailable']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'true',
                                        arLensID: product['arLensID'] ?? '',
                                        organizationImageUrl: product[
                                                        'organisationImageUrl'] !=
                                                    null &&
                                                product['organisationImageUrl']
                                                    is List &&
                                                product['organisationImageUrl']
                                                    .isNotEmpty
                                            ? List<String>.from(product[
                                                    'organisationImageUrl'])
                                                .first
                                            : '',
                                        organizationName: '',
                                        rediretLink: product['redirectLinks'] !=
                                                    null &&
                                                product['redirectLinks']
                                                    is List &&
                                                product['redirectLinks']
                                                    .isNotEmpty
                                            ? List<String>.from(
                                                    product['redirectLinks'])
                                                .first
                                            : '',
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  product['imageurl'],
                                  fit: BoxFit.contain,
                                ),
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
                                  color: double.parse(product['rating']) >= 3
                                      ? double.parse(product['rating']) >= 4
                                          ? const Color.fromARGB(
                                                  255, 2, 155, 45)
                                              .withOpacity(0.6)
                                          : Colors.orange
                                      : Colors.red,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  product['rating'],
                                  style: const TextStyle(
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
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Starts from ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        product['price'],
                                        style: const TextStyle(
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Product(
                                  id: product['id'].toString(),
                                  name: product['name'] ?? '',
                                  title: product['title'] ?? '',
                                  description: product['description'] != null &&
                                          product['description'] is List
                                      ? List<String>.from(
                                          product['description'])
                                      : [],
                                  category: product['category'] ?? '',
                                  price: product['price'] != null
                                      ? double.parse(
                                          product['price'].toString())
                                      : 0.0,
                                  sizes: product['sizes'] != null &&
                                          product['sizes'] is List
                                      ? List<String>.from(product['sizes'])
                                      : [],
                                  images: product['images'] != null &&
                                          product['images'] is List
                                      ? List<String>.from(product['images'])
                                      : [],
                                  similarproducts:
                                      product['similarProducts'] != null &&
                                              product['similarProducts'] is List
                                          ? List<String>.from(
                                              product['similarProducts'])
                                          : [],
                                  variants: product['variants'] != null &&
                                          product['variants'] is List
                                      ? List<String>.from(product['variants'])
                                      : [],
                                  rating: product['rating'] != null
                                      ? double.parse(
                                          product['rating'].toString())
                                      : 0.0,
                                  tags: product['tags'] != null &&
                                          product['tags'] is List
                                      ? List<String>.from(product['tags'])
                                      : [],
                                  isAvailable: product['isAvailable'] != null &&
                                      product['isAvailable']
                                              .toString()
                                              .toLowerCase() ==
                                          'true',
                                  isActive: product['isActive'] != null &&
                                      product['isActive']
                                              .toString()
                                              .toLowerCase() ==
                                          'true',
                                  model3D: product['model3D'] ?? '',
                                  isARTryOnAvailable:
                                      product['isARTryOnAvailable'] != null &&
                                          product['isARTryOnAvailable']
                                                  .toString()
                                                  .toLowerCase() ==
                                              'true',
                                  is3Davailable:
                                      product['is3Davailable'] != null &&
                                          product['is3Davailable']
                                                  .toString()
                                                  .toLowerCase() ==
                                              'true',
                                  arLensID: product['arLensID'] ?? '',
                                  organizationImageUrl: product[
                                                  'organisationImageUrl'] !=
                                              null &&
                                          product['organisationImageUrl']
                                              is List &&
                                          product['organisationImageUrl']
                                              .isNotEmpty
                                      ? List<String>.from(
                                              product['organisationImageUrl'])
                                          .first
                                      : '',
                                  organizationName: '',
                                  rediretLink: product['redirectLinks'] !=
                                              null &&
                                          product['redirectLinks'] is List &&
                                          product['redirectLinks'].isNotEmpty
                                      ? List<String>.from(
                                              product['redirectLinks'])
                                          .first
                                      : '',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            product['title'],
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
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

class ShowFilters extends StatefulWidget {
  final List<String> agecontent, ratingcontent, gendercontent;
  final List<bool> agebool, ratingbool, genderbool;
  final String filtername;
  const ShowFilters({
    super.key,
    required this.agecontent,
    required this.filtername,
    required this.ratingcontent,
    required this.gendercontent,
    required this.agebool,
    required this.ratingbool,
    required this.genderbool,
  });

  @override
  _ShowFiltersState createState() => _ShowFiltersState();
}

class _ShowFiltersState extends State<ShowFilters> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.5 * MediaQuery.of(context).size.height,
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.filtername,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => {
                Navigator.of(context).pop(),
              },
              child: Container(
                height: 20,
                width: 20,
                child: Icon(Icons.close),
              ),
            ),
          ),
          const Divider(
            height: 5,
            color: Colors.grey,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ListTile(
                    title: Text(
                      "GENDER",
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.genderbool.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => {
                          setState(() {
                            for (int i = 0; i < widget.genderbool.length; i++) {
                              if (i == index) {
                                widget.genderbool[index] =
                                    !widget.genderbool[index];
                              } else if (widget.genderbool[i] == true) {
                                widget.genderbool[i] = !widget.genderbool[i];
                              } else {
                                widget.genderbool[i] = widget.genderbool[i];
                              }
                            }
                          }),
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            widget.gendercontent[index],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        trailing: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.genderbool[index]
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: widget.genderbool[index]
                                    ? Colors.purple
                                    : Colors.transparent,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const ListTile(
                    title: Text(
                      "AGE",
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.agebool.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => {
                          setState(() {
                            for (int i = 0; i < widget.agebool.length; i++) {
                              if (i == index) {
                                widget.agebool[index] = !widget.agebool[index];
                              } else if (widget.agebool[i] == true) {
                                widget.agebool[i] = !widget.agebool[i];
                              } else {
                                widget.agebool[i] = widget.agebool[i];
                              }
                            }
                          }),
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            widget.agecontent[index],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        trailing: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.agebool[index]
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: widget.agebool[index]
                                    ? Colors.purple
                                    : Colors.transparent,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const ListTile(
                    title: Text(
                      "RATING",
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.ratingbool.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => {
                          setState(() {
                            for (int i = 0; i < widget.ratingbool.length; i++) {
                              if (i == index) {
                                widget.ratingbool[index] =
                                    !widget.ratingbool[index];
                              } else if (widget.ratingbool[i] == true) {
                                widget.ratingbool[i] = !widget.ratingbool[i];
                              } else {
                                widget.ratingbool[i] = widget.ratingbool[i];
                              }
                            }
                          }),
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            widget.ratingcontent[index],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        trailing: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.ratingbool[index]
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: widget.ratingbool[index]
                                    ? Colors.purple
                                    : Colors.transparent,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  List<String> content;
  List<bool> contentbool;
  String filtername;
  double width;
  BottomSheetContent(
      {super.key,
      required this.width,
      required this.content,
      required this.contentbool,
      required this.filtername});
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.width * MediaQuery.of(context).size.height,
      child: Column(
        children: [
          // const SizedBox(height: 20),
          ListTile(
            title: Text(
              widget.filtername,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => {
                Navigator.of(context).pop(),
              },
              child: Container(
                height: 20,
                width: 20,
                child: Icon(Icons.close),
              ),
            ),
          ),
          const Divider(
            height: 5,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.content.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => {
                      setState(() {
                        for (int i = 0; i < widget.contentbool.length; i++) {
                          if (i == index) {
                            widget.contentbool[index] =
                                !widget.contentbool[index];
                          } else if (widget.contentbool[i] == true) {
                            widget.contentbool[i] = !widget.contentbool[i];
                          } else {
                            widget.contentbool[i] = widget.contentbool[i];
                          }
                        }
                      }),
                    },
                    title: Text(
                      widget.content[index],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.contentbool[index]
                              ? Colors.purple
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: widget.contentbool[index]
                                ? Colors.purple
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}