import 'dart:async';
import 'package:faszen/repositories/product_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:faszen/widgets/searchdisplaycard.dart';

class SearchDisplayPage extends StatelessWidget {
  String keyword;
  SearchDisplayPage({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductDataProvider(),
      child: SearchDisplay(keyword: keyword),
    );
  }
}

class SearchDisplay extends StatefulWidget {
  final String keyword;
  const SearchDisplay({super.key, required this.keyword});

  @override
  _SearchDisplayState createState() => _SearchDisplayState();
}

class _SearchDisplayState extends State<SearchDisplay> {
  List<SearchDisplayCard> SearchDisplayList = [];
  final ScrollController _scrollController = ScrollController();
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
      genderbool = [],
      agebool = [],
      ratingbool = [];
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // decodingJSON(searchdetails);
    sortbool = List.generate(sortcontent.length, (index) => false);
    categorybool = List.generate(categorycontent.length, (index) => false);
    popularitybool = List.generate(popularitycontent.length, (index) => false);
    genderbool = List.generate(gendercontent.length, (index) => false);
    agebool = List.generate(agecontent.length, (index) => false);
    ratingbool = List.generate(ratingcontent.length, (index) => false);
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider =
          Provider.of<ProductDataProvider>(context, listen: false);
      dataProvider.fetchDataWithFuzzySearch(widget.keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ProductDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.keyword,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1), // Set the height of the bottom border
          child: Container(
            color: Colors.grey, // Set the color of the bottom border
            height: 1.75, // Set the thickness of the bottom border
          ),
        ),
        actions: [
          Image.asset(
            'assets/icons/search_appbar.png',
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 15),
          Image.asset(
            'assets/icons/wardrobe_profile.png',
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(children: [
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
                        width: 0.35,
                        content: sortcontent,
                        contentbool: sortbool,
                        filtername: "Sort",
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
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BottomSheetContent(
                        width: 0.3,
                        content: popularitycontent,
                        contentbool: popularitybool,
                        filtername: "Popularity",
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
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BottomSheetContent(
                        width: 0.5,
                        content: categorycontent,
                        contentbool: categorybool,
                        filtername: "Category",
                      );
                    },
                  ),
                  // print(categorybool),
                },
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
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ShowFilters(
                            filtername: "Filter",
                            agecontent: agecontent,
                            ratingcontent: ratingcontent,
                            gendercontent: gendercontent,
                            agebool: agebool,
                            ratingbool: ratingbool,
                            genderbool: genderbool);
                      }),
                },
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
            ),
          ],
        ),
        dataProvider.isLoading
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: 4 * 200,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: 4,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            highlightColor: Colors.grey[100]!,
                            baseColor: Colors.grey[300]!,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: 200,
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.grey[100],
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 15),
                                        Shimmer.fromColors(
                                            highlightColor: Colors.grey[100]!,
                                            baseColor: Colors.grey[300]!,
                                            child: Container(
                                              color: Colors.grey[100],
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                            )),
                                        const SizedBox(height: 10),
                                        Shimmer.fromColors(
                                            highlightColor: Colors.grey[100]!,
                                            baseColor: Colors.grey[300]!,
                                            child: Container(
                                              color: Colors.grey[100],
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              )
            : dataProvider.fuzzysearchedproducts.isNotEmpty
                ? Expanded(
                    child: SizedBox(
                      height: dataProvider.fuzzysearchedproducts.length * 100,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: dataProvider.fuzzysearchedproducts.length,
                        itemBuilder: (context, index) {
                          var product =
                              dataProvider.fuzzysearchedproducts[index];
                          if(index == 0){
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SearchDisplayCard(
                              id: product['id'].toString(),
                              title: product['title'],
                              imageurl: product['imageurl'],
                              category: product['category'],
                              rating: double.parse(product['rating']),
                              price: double.parse(product['price']),
                              organizationImageurl: List<String>.from(
                                  product['organisationImageUrl']),
                              name: product['name'],
                              description: product['description'] != null &&
                                      product['description'] is List
                                  ? List<String>.from(product['description'])
                                  : [],
                              arLensID: product['arLensID'],
                              model3D: product['model3D'],
                              isAvailable: product['isAvailable']
                                      .toString()
                                      .toLowerCase() ==
                                  'true',
                              isActive:
                                  product['isActive'].toString().toLowerCase() ==
                                      'true',
                              is3Davailable: product['is3Davailable']
                                      .toString()
                                      .toLowerCase() ==
                                  'true',
                              isARTryOnAvailable: product['isARTryOnAvailable']
                                      .toString()
                                      .toLowerCase() ==
                                  'true',
                              sizes: product['sizes'] != null &&
                                      product['sizes'] is List
                                  ? List<String>.from(product['sizes'])
                                  : [],
                              redirectLinks: product['redirectLinks'] != null &&
                                      product['redirectLinks'] is List &&
                                      product['redirectLinks'].isNotEmpty
                                  ? List<String>.from(product['redirectLinks'])
                                  : [],
                              images: product['images'] != null &&
                                      product['images'] is List
                                  ? List<String>.from(product['images'])
                                  : [],
                              similarproducts: product['similarProducts'] !=
                                          null &&
                                      product['similarProducts'] is List
                                  ? List<String>.from(product['similarProducts'])
                                  : [],
                              variants: product['variants'] != null &&
                                      product['variants'] is List
                                  ? List<String>.from(product['variants'])
                                  : [],
                              tags: List<String>.from(product['tags']),
                                                        ),
                            );
                          }
                          return SearchDisplayCard(
                            id: product['id'].toString(),
                            title: product['title'],
                            imageurl: product['imageurl'],
                            category: product['category'],
                            rating: double.parse(product['rating']),
                            price: double.parse(product['price']),
                            organizationImageurl: List<String>.from(
                                product['organisationImageUrl']),
                            name: product['name'],
                            description: product['description'] != null &&
                                    product['description'] is List
                                ? List<String>.from(product['description'])
                                : [],
                            arLensID: product['arLensID'],
                            model3D: product['model3D'],
                            isAvailable: product['isAvailable']
                                    .toString()
                                    .toLowerCase() ==
                                'true',
                            isActive:
                                product['isActive'].toString().toLowerCase() ==
                                    'true',
                            is3Davailable: product['is3Davailable']
                                    .toString()
                                    .toLowerCase() ==
                                'true',
                            isARTryOnAvailable: product['isARTryOnAvailable']
                                    .toString()
                                    .toLowerCase() ==
                                'true',
                            sizes: product['sizes'] != null &&
                                    product['sizes'] is List
                                ? List<String>.from(product['sizes'])
                                : [],
                            redirectLinks: product['redirectLinks'] != null &&
                                    product['redirectLinks'] is List &&
                                    product['redirectLinks'].isNotEmpty
                                ? List<String>.from(product['redirectLinks'])
                                : [],
                            images: product['images'] != null &&
                                    product['images'] is List
                                ? List<String>.from(product['images'])
                                : [],
                            similarproducts: product['similarProducts'] !=
                                        null &&
                                    product['similarProducts'] is List
                                ? List<String>.from(product['similarProducts'])
                                : [],
                            variants: product['variants'] != null &&
                                    product['variants'] is List
                                ? List<String>.from(product['variants'])
                                : [],
                            tags: List<String>.from(product['tags']),
                          );
                        },
                      ),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                          height: 0.1 * MediaQuery.of(context).size.height),
                      Lottie.asset(
                        'assets/Animation - 1713787363552.json',
                        repeat: false,
                        // height: 0.4 * MediaQuery.of(context).size.height
                      ),
                      const Text(
                        'Search Not Found!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
      ]),
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
                child: const Icon(Icons.close),
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
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
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
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
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
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
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
                child: const Icon(Icons.close),
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
                      style: const TextStyle(
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
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
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
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
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