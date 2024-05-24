import 'dart:async';
import 'package:faszen/repositories/product_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:faszen/widgets/buyinglink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:o3d/o3d.dart';
import 'package:faszen/screens/camerakit/media_result_screen.dart';
import 'package:faszen/screens/camerakit/lens_list_screen.dart';
import 'package:camerakit_flutter/camerakit_flutter.dart';
import 'package:camerakit_flutter/lens_model.dart';
import 'package:faszen/screens/camerakit/constants.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:faszen/widgets/productcard.dart';
import 'package:faszen/widgets/snackbar.dart';

class Product extends StatelessWidget {
  final String id;
  final String name;
  final String title;
  final String category, organizationImageUrl, organizationName, rediretLink;
  final List<String> description;
  final double price;
  final List<String> images;
  final List<String> variants;
  final List<String> sizes;
  final List<String> similarproducts;
  final double rating;
  final List<String> tags;
  final bool isAvailable;
  final bool isActive;
  final String model3D;
  final bool isARTryOnAvailable;
  final bool is3Davailable;
  final String arLensID;
  Product(
      {super.key,
      required this.id,
      required this.name,
      required this.title,
      required this.category,
      required this.organizationImageUrl,
      required this.organizationName,
      required this.rediretLink,
      required this.description,
      required this.price,
      required this.images,
      required this.variants,
      required this.sizes,
      required this.similarproducts,
      required this.rating,
      required this.tags,
      required this.isAvailable,
      required this.isActive,
      required this.model3D,
      required this.isARTryOnAvailable,
      required this.is3Davailable,
      required this.arLensID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductDataProvider(),
      child: ProductPage(
        id: id,
        name: name,
        title: title,
        description: description,
        sizes: sizes,
        similarproducts: similarproducts,
        organizationImageUrl: organizationImageUrl,
        organizationName: organizationName,
        rediretLink: rediretLink,
        price: price,
        images: images,
        variants: variants,
        rating: rating,
        tags: tags,
        isAvailable: isAvailable,
        isActive: isActive,
        isARTryOnAvailable: isARTryOnAvailable,
        is3Davailable: is3Davailable,
        category: category,
        model3D: model3D,
        arLensID: arLensID,
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  final String id;
  final String name;
  final String title;
  final String category, organizationImageUrl, organizationName, rediretLink;
  final List<String> description;
  final double price;
  final List<String> images;
  final List<String> variants;
  final List<String> sizes;
  final List<String> similarproducts;
  final double rating;
  final List<String> tags;
  final bool isAvailable;
  final bool isActive;
  final String model3D;
  final bool isARTryOnAvailable;
  final bool is3Davailable;
  final String arLensID; // Added ARLensID parameter

  const ProductPage({
    super.key,
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.sizes,
    required this.similarproducts,
    required this.organizationImageUrl,
    required this.organizationName,
    required this.rediretLink,
    required this.price,
    required this.images,
    required this.variants,
    required this.rating,
    required this.tags,
    required this.isAvailable,
    required this.isActive,
    required this.model3D,
    required this.isARTryOnAvailable,
    required this.is3Davailable,
    required this.arLensID,
    required this.category, // Initialized ARLensID parameter
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    implements CameraKitFlutterEvents {
  int _selectedIndex = 0;
  int _selectedSizeIndex = 0;
  int _currentPageIndex = 0;
  int _selectedPhotoIndex = 0;
  bool _isfavouriteclicked = false;
  List<String> _displayedDescription = [];
  bool _showMore = true; // Added variable to control "Read More" button
  late CarouselController _carouselController;
  List<BuyingLinks> BuyingLinksList = [];
  List<ProductCard> ProductCardList = [];
  late String _filePath = '';
  late String _fileType = '';
  late List<Lens> lensList = [
    Lens(id: '40369030925', groupId: '2a1c86dc-6557-4bc3-9ac0-fbb87300a941')
  ];
  late final _cameraKitFlutterImpl =
      CameraKitFlutterImpl(cameraKitFlutterEvents: this);
  bool isLensListPressed = false;
  late Timer _timer;
  String modelUrl = '';

  O3DController controller = O3DController();
  @override
  void initState() {
    super.initState();
    // fetchModelUrl();
    _carouselController = CarouselController();
    if (widget.description.length > 4) {
      _displayedDescription = widget.description.sublist(0, 4);
    } else {
      _displayedDescription = widget.description;
    }
    // decodingJSON(jsonData, cardDetails);
    _cameraKitFlutterImpl.setCredentials(apiToken: Constants.cameraKitApiToken);
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider =
          Provider.of<ProductDataProvider>(context, listen: false);
      dataProvider.fetchDataAllAndFilter(widget.similarproducts);
    });
  }

  Future<void> initCameraKit() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      await _cameraKitFlutterImpl.openCameraKitWithSingleLens(
          lensId: widget.arLensID,
          groupId: 'bd021295-d98e-4ca4-b42c-563fdf505e57',
          isHideCloseButton: false);
    } on PlatformException {
      if (kDebugMode) {
        print("Failed to open camera kit");
      }
    }
  }

  Widget _buildOption(String text, int index) {
    final isSelected = _selectedIndex == index;
    final isHovered = _selectedIndex == index;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _selectedIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          _selectedIndex = -1;
        });
      },
      child: GestureDetector(
        onTap: () {
          _carouselController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected || isHovered
                ? const Color(0xFFB4CAEC)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            index == 1 ? "360°" : text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: isSelected || isHovered ? FontWeight.w700 : null,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _copyDescriptionToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.description.join('\n')));
    buildCustomSnackBar(context: context, message: "Product Details is Copied");
  }

  List<Widget> _buildPageIndicator(int count) {
    List<Widget> indicators = [];
    for (int i = 0; i < count; i++) {
      indicators.add(Container(
        width: 8.0,
        height: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPageIndex == i ? Colors.blue : Colors.grey,
        ),
      ));
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ProductDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1), // Set the height of the bottom border
          child: Container(
            color: Colors.grey, // Set the color of the bottom border
            height: 1.75, // Set the thickness of the bottom border
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.width, // Full width
                    aspectRatio: 16 / 9,
                    viewportFraction: 1, // Ensure only one item is visible
                    autoPlay: false, // Disable auto play
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index, _) {
                      if (index == 2) {
                        if (widget.isARTryOnAvailable) {
                          initCameraKit();
                        } else {
                          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          //     content: Text(
                          //         'Try On is not available for this product')));
                        }
                      } else if (index == 1) {
                        if (widget.is3Davailable == false) {
                          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          //     content: Text(
                          //         '3Dmodel is not available for this product')));
                        }
                      }
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    enableInfiniteScroll: false, // Disable infinite scrolling
                  ),
                  items: [
                    Builder(
                      builder: (BuildContext context) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            height:
                                MediaQuery.of(context).size.width, // Full width
                            aspectRatio: 16 / 9,
                            viewportFraction:
                                1, // Ensure only one item is visible
                            autoPlay: false, // Disable auto play
                            onPageChanged:
                                (int index, CarouselPageChangedReason reason) {
                              setState(() {
                                _selectedPhotoIndex = index;
                              });
                            },
                          ),
                          items: widget.images
                              .take(widget.images.length)
                              .map((image) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.network(image);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                    // Second option: 3D model or message if not available
                    Builder(
                      builder: (BuildContext context) {
                        return widget.is3Davailable
                            ? O3D.network(
                                src: widget.model3D,
                                controller: controller,
                              )
                            : Column(
                                children: [
                                  const SizedBox(height: 40),
                                  Image.asset('assets/15@3x.png',
                                      width: 350, fit: BoxFit.contain),
                                  const SizedBox(height: 30),
                                  const Text(
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      "360 view is not currently available for this Product :(",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500)),
                                ],
                              );
                      },
                    ),
                    // Third option: AR Try On feature or message if not available
                    Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: widget.isARTryOnAvailable
                              ? Container() // Replace with AR Try On widget
                              : Column(
                                  children: [
                                    const SizedBox(height: 40),
                                    Image.asset('assets/15@3x.png',
                                        width: 350, fit: BoxFit.contain),
                                    const SizedBox(height: 30),
                                    const Text(
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        "AR Try On is not currently available for this Product :(",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _selectedIndex == 0
                    ? Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 8,
                          alignment: Alignment.center,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.images.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: _selectedPhotoIndex == index ? 30 : 8,
                                  decoration: BoxDecoration(
                                    color: _selectedPhotoIndex == index
                                        ? Colors.black
                                        : Colors.grey,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(
                        height: 10,
                      ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 3, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(
                                0, 3), // Offset position of the shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFD9D9D9)),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          _buildOption("Photo", 0),
                          _buildOption("360°", 1),
                          _buildOption("Try On", 2),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onLongPress: () {
                      HapticFeedback.vibrate();
                      Clipboard.setData(ClipboardData(text: widget.title));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product name copied to clipboard'),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: DropCapText(
                        dropCap: DropCap(
                          width: 68,
                          height: 25,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(40),
                                color: widget.rating >= 3
                                    ? widget.rating >= 4
                                        ? Colors.green
                                        : Colors.orange
                                    : Colors.red,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    " ${widget.rating} ",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: Image.asset(
                                      color: Colors.white,
                                      "assets/star.png",
                                      height: 15,
                                      width: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        widget.title,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Price starts from",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "₹${widget.price}",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(children: [
                  const SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 0.35 * MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Ask Fizard 🪄",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 30,
                    width: 0.5 * MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Colors.black,
                    ),
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Add to wardrobe 📦",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 10),
                widget.sizes.isNotEmpty
                    ? const Divider(
                        color: Color(0xFFE4E6E7),
                        thickness: 10,
                      )
                    : Container(),
                widget.sizes.isNotEmpty
                    ? const SizedBox(height: 10)
                    : Container(),
                widget.sizes.isNotEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Sizes Available",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Container(),
                widget.sizes.isNotEmpty
                    ? const SizedBox(height: 10)
                    : Container(),
                widget.sizes.isNotEmpty
                    ? SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.sizes.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedSizeIndex = index;
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.45,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(40)),
                                          color: index == _selectedSizeIndex
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          widget.sizes[index],
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: index == _selectedSizeIndex
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      )),
                                );
                              }),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 15),
                const Divider(
                  color: Color(0xFFE4E6E7),
                  thickness: 10,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    const Text(
                      "Products Details",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _copyDescriptionToClipboard();
                      },
                      child: const Text(
                        "COPY",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _displayedDescription
                              .map((line) => Text(
                                    line,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    widget.description.length > 4
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  // Toggle the show more/less state
                                  if (_showMore) {
                                    // Show more lines if pressed "Read More"
                                    _displayedDescription = widget.description;
                                  } else {
                                    // Show first four lines if pressed "Read Less"
                                    _displayedDescription = widget.description
                                        .sublist(
                                            0, widget.description.length - 1);
                                  }
                                  _showMore = !_showMore;
                                });
                              },
                              child: Text(
                                _showMore ? "Read More..." : "...Read Less",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF3A90C0),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Color(0xFFE4E6E7),
                  thickness: 10,
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Sold By",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // SizedBox(
                //   height: 125 * BuyingLinksList.length + 0.0,
                //   child: ListView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: BuyingLinksList.length,
                //     itemBuilder: (context, index) {
                //       return BuyingLinksList();
                //     },
                //   ),
                // ),
                SizedBox(
                    height: 125,
                    child: BuyingLinks(
                      organizationImageUrl: widget.organizationImageUrl,
                      organizationName: widget.organizationName,
                      productLink: widget.rediretLink,
                      rating: widget.rating,
                      currentPrice: widget.price,
                      authorizedSeller: true,
                      lastelement: false,
                    )),
                widget.similarproducts.isNotEmpty
                    ? const Divider(
                        color: Color(0xFFE4E6E7),
                        thickness: 10,
                      )
                    : Container(),
                widget.similarproducts.isNotEmpty
                    ? const SizedBox(height: 10)
                    : Container(),
                widget.similarproducts.isNotEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Similar Products",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : Container(),
                const SizedBox(height: 10),
                dataProvider.isLoading
                    ? SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Shimmer.fromColors(
                                  highlightColor: Colors.grey[100]!,
                                  baseColor: Colors.grey[300]!,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                        vertical: BorderSide(
                                          color: Color(0xFFE4E6E7),
                                          width: 2.5,
                                        ),
                                        horizontal: BorderSide(
                                          color: Color(0xFFE4E6E7),
                                          width: 5,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          color: Colors.grey[100],
                                          height: 200,
                                          width: 200,
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          color: Colors.grey[100],
                                          height: 30,
                                          width: 200,
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          color: Colors.grey[100],
                                          height: 20,
                                          width: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                              ],
                            );
                          },
                        ),
                      )
                    : widget.similarproducts.isNotEmpty
                        ? SizedBox(
                            height: 300,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: dataProvider.allproductList.length,
                              itemBuilder: (context, index) {
                                var product =
                                    dataProvider.allproductList[index];
                                return ProductCard(
                                  name: product['name'],
                                  id: product['title'],
                                  imageurl: product['imageurl'],
                                  rating: double.parse(product['rating']),
                                  title: product['title'],
                                  category: product['category'],
                                  price: double.parse(product['price']),
                                  organizationImageurl: List<String>.from(
                                      product['organisationImageUrl']),
                                  sizes: product['sizes'].length > 0
                                      ? List<String>.from(product['sizes'])
                                      : [],
                                  redirectLinks: List<String>.from(
                                      product['redirectLinks']),
                                  images: List<String>.from(product['images']),
                                  similarproducts:
                                      product['similarProducts'].length > 0
                                          ? List<String>.from(
                                              product['similarProducts'])
                                          : [],
                                  variants: product['variants'].length> 0
                                      ? List<String>.from(product['variants'])
                                      : [],
                                  tags: List<String>.from(product['tags']),
                                  description:
                                      List<String>.from(product['description']),
                                  isAvailable:
                                      product['isAvailable'].toString() ==
                                          'true',
                                  isActive:
                                      product['isActive'].toString() == 'true',
                                  is3Davailable:
                                      product['is3Davailable'].toString() ==
                                          'true',
                                  isARTryOnAvailable:
                                      product['isARTryOnAvailable']
                                              .toString() ==
                                          'true',
                                  arLensID: product['arLensID'],
                                  model3D: product['model3D'],
                                );
                              },
                            ),
                          )
                        : Container(),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: GestureDetector(
                      child: IconButton(
                        icon: _isfavouriteclicked
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_outline),
                        onPressed: () {
                          HapticFeedback.vibrate();
                          final message = _isfavouriteclicked
                              ? 'Removed from favorites'
                              : 'Added to favorites';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              duration: const Duration(
                                  seconds: 1), // Adjust the duration as needed
                            ),
                          );
                          setState(() {
                            _isfavouriteclicked = !_isfavouriteclicked;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onCameraKitResult(Map<dynamic, dynamic> result) {
    setState(() {
      _filePath = result["path"] as String;
      _fileType = result["type"] as String;

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MediaResultWidget(
                filePath: _filePath,
                fileType: _fileType,
              )));
    });
  }

  @override
  void receivedLenses(List<Lens> lensList) async {
    isLensListPressed = false;
    setState(() {});
    final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LensListView(lensList: lensList)))
        as Map<String, dynamic>?;
    final lensId = result?['lensId'] as String?;
    final groupId = result?['groupId'] as String?;

    if ((lensId?.isNotEmpty ?? false) && (groupId?.isNotEmpty ?? false)) {
      _cameraKitFlutterImpl.openCameraKitWithSingleLens(
          lensId: lensId!, groupId: groupId!, isHideCloseButton: false);
    }
  }
}