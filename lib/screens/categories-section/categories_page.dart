import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _skipAnimation = false;
  bool showCategory = true;

  final List<String> categories = [
    "Popular",
    "Tops",
    "Bottoms",
    "Inners",
    "Athleisure",
    "Formals",
    "Casuals",
    "Desi-wear",
    "Western-wear",
    "Street-wear",
    "Luxury-wear",
    "Gift-wear",
    "Footwear",
    "Hats & Beanie",
    "Accessories"
  ];

  final List<GlobalKey> _keys = [];
  final ScrollController scrollController = ScrollController();
  int currentSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < categories.length; i++) {
      _keys.add(GlobalKey());
    }
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  int _findIndexFromScrollPosition(double scrollPosition) {
    for (int i = 0; i < _keys.length; i++) {
      final RenderObject? renderObject =
          _keys[i].currentContext?.findRenderObject();
      if (renderObject != null) {
        final RenderAbstractViewport viewport =
            RenderAbstractViewport.of(renderObject);
        final double itemPosition =
            viewport.getOffsetToReveal(renderObject, 0.0).offset;
        if (scrollPosition < itemPosition) {
          return i == 0 ? 0 : i - 1;
        }
      }
    }
    return _keys.length - 1;
  }

  void _onScroll() {
    double currentPosition = scrollController.offset;
    int newIndex = _findIndexFromScrollPosition(currentPosition);
    setState(() {
      currentSectionIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.list, color: Colors.black, size: 34),
          onPressed: () {
            setState(() {
              showCategory = !showCategory;
            });
          },
        ),
        //centerTitle: true,
        elevation: 5,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Text(
              "Category Page",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/icons/search_appbar.png",
              height: MediaQuery.of(context).size.height * 0.075,
              width:  MediaQuery.of(context).size.width * 0.075,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Image.asset(
              "assets/icons/favourites_appbar.png",
              height: MediaQuery.of(context).size.height * 0.070,
              width:  MediaQuery.of(context).size.width * 0.070,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          ],
        ),
      ),
      body: Row(
        children: [
          AnimatedContainer(
            duration: _skipAnimation
                ? Duration.zero
                : const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: showCategory ? 100 : 0,
            child: SingleChildScrollView(
              child: SizedBox(
                width: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(248, 249, 254, 1),
                        border: Border(
                          top: index > 0
                              ? const BorderSide(
                                  color: Color.fromRGBO(219, 219, 227, 1),
                                  width: 1,
                                )
                              : BorderSide.none,
                          bottom: index < categories.length - 1
                              ? const BorderSide(
                                  color: Color.fromRGBO(219, 219, 227, 1),
                                  width: 1,
                                )
                              : BorderSide.none,
                          left: index == currentSectionIndex
                              ? BorderSide(
                                  color: Colors.black.withOpacity(0.6),
                                  width: 10,
                                  style: BorderStyle.solid)
                              : BorderSide.none,
                        ),
                      ),
                      child: InkWell(
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              const Spacer(flex: 2),
                              Image.asset(
                                'assets/icons/${categories[index]}.png',
                                height: 40,
                                width: 40,
                              ),
                              const Spacer(flex: 1),
                              Text(
                                categories[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: index == currentSectionIndex
                                      ? const Color.fromARGB(255, 190, 39, 153)
                                      : Colors.black,
                                ),
                              ),
                              const Spacer(flex: 2)
                            ],
                          ),
                        ),
                        onTap: () {
                          if (!_skipAnimation) {
                            setState(() {
                              _skipAnimation = true;
                              scrollController.removeListener(_onScroll);
                              currentSectionIndex = index;
                              Scrollable.ensureVisible(
                                _keys[index].currentContext!,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );

                              Future.delayed(const Duration(milliseconds: 350),
                                  () {
                                scrollController.addListener(_onScroll);
                                _skipAnimation = false;
                              });
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    (showCategory ? 0.75 : 0.98),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TextDivider(
                              text: categories[index],
                              textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(219, 219, 227, 1)
                              ),
                            ),
                            ListTile(
                              key: _keys[index],
                              title: Text(
                                categories[index],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(
                                8,
                                (productIndex) {
                                  final productName =
                                      'Product ${productIndex + 1}';
                                  return InkWell(
                                    onTap: () {
                                      // navigateToProductPage(context, productName);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Image.asset(
                                            'assets/Denim.png',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                        ),
                                        Text(
                                          productName,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 400),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextDivider extends StatelessWidget {
  final String text;
  final Color dividerColor;
  final TextStyle textStyle;
  final double dividerHeight;
  final double dividerThickness;

  const TextDivider({
    super.key,
    required this.text,
    this.dividerColor = const Color.fromRGBO(219, 219, 227, 1),
    this.textStyle = const TextStyle(),
    this.dividerHeight = 0,
    this.dividerThickness = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Divider(
            height: dividerHeight,
            color: dividerColor,
            thickness: dividerThickness,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
        Expanded(
          flex: 10,
          child: Divider(
            height: dividerHeight,
            color: dividerColor,
            thickness: dividerThickness,
          ),
        ),
      ],
    );
  }
}
