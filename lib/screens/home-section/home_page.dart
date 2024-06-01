import 'package:faszen/screens/home-section/product_display.dart';
import 'package:faszen/screens/home-section/searchpage.dart';
import 'package:faszen/widgets/carrousal_slider.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class HomePage extends StatefulWidget {
  final bool showSearchBarHelp;
  const HomePage({super.key, required this.showSearchBarHelp});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GlobalKey> searchBar = List.generate(3, (_) => GlobalKey());
  TextEditingController searchcontroller = TextEditingController();
  int currentPageIndex = 0;
  int currentChoiceIndex = 0;
  int currentOccasionChoiceIndex = 0;
  int currentWeddimgImageChoice = 0;
  List<String> categoryText = [
    "Categories",
    "Indic Wear",
    "Westernwear",
    "Accessories",
    "Footwear"
  ];

  List<String> banners= [
    "assets/Rectangle 2.jpg",
    "assets/Rectangle 3.jpg",
    "assets/Rectangle 4.jpg",
    "assets/Rectangle 5.jpg",
    "assets/Rectangle 6.jpg",
    "assets/Rectangle 7.jpg"
  ];

  List<String> photos = [
    "assets/photos/photo1.png",
    "assets/photos/photo2.png",
    "assets/photos/photo3.png",
    "assets/photos/photo4.png",
    "assets/photos/photo5.png",
    "assets/photos/photo6.png"
  ];
  List<String> categoryImages = [
     "assets/Categorie.png",
    "assets/Indic Wear.png",
    "assets/Westernwear.png",
    "assets/Accessories.png",
    "assets/Footwear.png"
  ];
  List<String> WeddingImages = [
    "assets/Silk Dhoti.jpg",
    "assets/Wedding Suit.jpg",
    "assets/Sherwani.jpg",
    "assets/Catholic Gown.jpeg",
    "assets/Kurtis.jpg",
    "assets/Salwar Kameez.jpg",
    "assets/Lehanga.jpg",
    "assets/Saree.jpg"
  ];
  List<String> WeddingImagesText = [
    "Silk Dhoti",
    "Wedding Suit",
    "Sherwani",
    "Catholic Gown",
    "Kurtis",
    "Salwar Kameez",
    "Lehanga",
    "Saree"
  ];
  List<String> choices = [
    "All",
    "Winter Fashion",
    "Summer Fashion",
    "Spring Fashion",
    "Fall Fashion"
  ];
  List<String> occasionchoice = [
    "Wedding wear",
    "Party wear",
    "Casual wear",
    "Formal wear",
    "Festive wear",
    "Prom wear",
    "Outdoor wear",
    "School/College wear",
    "Athleisure wear",
    "Holiday wear",
    "Goth wear",
    "Other Special Occasions"
  ];
  List<String> allImages = [
    // Summer
    "assets/Double Denim.jpg",
    "assets/Easy Neutrals.jpg",
    "assets/The Micro Mini.jpg",
    "assets/Summer Corsetry.jpg",
    "assets/The Shirtdress.jpg",
    "assets/Public Pajamas.jpg",
    "assets/Going West.jpg",
    "assets/Nautical or Nice.jpg",
    "assets/Brunch-Ready.jpg",
    "assets/Animal Prints.jpg",
    "assets/Boho Chic.jpg",
    "assets/Pop of Red.jpg",
    
    // Winter
    "assets/Shearling.jpg",
    "assets/Goth Era.jpg",
    "assets/Cropped Jackets.jpg",
    "assets/Business Casual.jpg",
    "assets/Precious Cargo.jpg",
    "assets/Dark Florals.jpg",
    "assets/Back to Basics.jpg",
    "assets/Baggy Jeans.jpg",
    "assets/Anti-Logo.jpg",
    
    // Spring
    "assets/All Things Y2K.jpg",
    "assets/Bold Colors.jpg",
    "assets/Bold Suits.jpg",
    "assets/Colorblocking.jpg",
    "assets/Fanny Packs.jpg",
    "assets/Micro Minis.jpg",
    "assets/More Metallics.jpg",
    "assets/Overalls.jpg",
    "assets/Parachute Pants.jpg",
    "assets/Prairiecore.jpg",
    "assets/Sheer Slips.jpg",
    
    // Fall
    "assets/Pop of Color.jpg",
    "assets/Bare-Leg Fall.jpg",
    "assets/Off-Duty.jpg",
    "assets/Everyday Floral.jpg",
    "assets/Sans-Pants.jpg",
    "assets/Wild Fall.jpg",
    "assets/Streetwear Fall.jpg",
    "assets/Textural.jpg",
    "assets/Rainy Day.jpg",
    "assets/Leather Trench.jpg",
    "assets/Transitional.jpg",
    "assets/Cinched-Waist.jpg",
    "assets/Classic Twist.jpg",
    "assets/Asymmetric.jpg",
    "assets/Ultra-Long Coat.jpg"
];

List<String> allImagesText = [
    // Summer
    "Double Denim",
    "Easy Neutrals",
    "The Micro Mini",
    "Summer Corsetry",
    "The Shirtdress",
    "Public Pajamas",
    "Going West",
    "Nautical or Nice",
    "Brunch-Ready",
    "Animal Prints",
    "Boho Chic",
    "Pop of Red",
    
    // Winter
    "Shearling",
    "Goth Era",
    "Cropped Jackets",
    "Business Casual",
    "Precious Cargo",
    "Dark Florals",
    "Back to Basics",
    "Baggy Jeans",
    "Anti-Logo",
    
    // Spring
    "All Things Y2K",
    "Bold Colors",
    "Bold Suits",
    "Colorblocking",
    "Fanny Packs",
    "Micro Minis",
    "More Metallics",
    "Overalls",
    "Parachute Pants",
    "Prairiecore",
    "Sheer Slips",
    
    // Fall
    "Pop of Color",
    "Bare-Leg Fall",
    "Off-Duty",
    "Everyday Floral",
    "Sans-Pants",
    "Wild Fall",
    "Streetwear Fall",
    "Textural",
    "Rainy Day",
    "Leather Trench",
    "Transitional",
    "Cinched-Waist",
    "Classic Twist",
    "Asymmetric",
    "Ultra-Long Coat"
];

  List<String> winterImages = [
    "assets/Shearling.jpg",
    "assets/Goth Era.jpg",
    "assets/Cropped Jackets.jpg",
    "assets/Business Casual.jpg",
    "assets/Precious Cargo.jpg",
    "assets/Dark Florals.jpg",
    "assets/Back to Basics.jpg",
    "assets/Baggy Jeans.jpg",
    "assets/Anti-Logo.jpg"
];

List<String> winterImagesText = [
    "Shearling",
    "Goth Era",
    "Cropped Jackets",
    "Business Casual",
    "Precious Cargo",
    "Dark Florals",
    "Back to Basics",
    "Baggy Jeans",
    "Anti-Logo"
];

  List<String> summerImages = [
    "assets/Double Denim.jpg",
    "assets/Easy Neutrals.jpg",
    "assets/The Micro Mini.jpg",
    "assets/Summer Corsetry.jpg",
    "assets/The Shirtdress.jpg",
    "assets/Public Pajamas.jpg",
    "assets/Going West.jpg",
    "assets/Nautical or Nice.jpg",
    "assets/Brunch-Ready.jpg",
    "assets/Animal Prints.jpg",
    "assets/Boho Chic.jpg",
    "assets/Pop of Red.jpg"
  ];

  List<String> summerImagesText = [
      "Double Denim",
      "Easy Neutrals",
      "The Micro Mini",
      "Summer Corsetry",
      "The Shirtdress",
      "Public Pajamas",
      "Going West",
      "Nautical or Nice",
      "Brunch-Ready",
      "Animal Prints",
      "Boho Chic",
      "Pop of Red"
  ];
  List<String> springImages = [
    "assets/All Things Y2K.jpg",
    "assets/Bold Colors.jpg",
    "assets/Bold Suits.jpg",
    "assets/Colorblocking.jpg",
    "assets/Fanny Packs.jpg",
    "assets/Micro Minis.jpg",
    "assets/More Metallics.jpg",
    "assets/Overalls.jpg",
    "assets/Parachute Pants.jpg",
    "assets/Prairiecore.jpg",
    "assets/Sheer Slips.jpg"
  ];
  List<String> springImagesText = [
    "All Things Y2K",
    "Bold Colors",
    "Bold Suits",
    "Colorblocking",
    "Fanny Packs",
    "Micro Minis",
    "More Metallics",
    "Overalls",
    "Parachute Pants",
    "Prairiecore",
    "Sheer Slips",
  ];
  List<String> fallImages = [
    "assets/Pop of Color.jpg",
    "assets/Bare-Leg Fall.jpg",
    "assets/Off-Duty.jpg",
    "assets/Everyday Floral.jpg",
    "assets/Sans-Pants.jpg",
    "assets/Wild Fall.jpg",
    "assets/Streetwear Fall.jpg",
    "assets/Textural.jpg",
    "assets/Rainy Day.jpg",
    "assets/Leather Trench.jpg",
    "assets/Transitional.jpg",
    "assets/Cinched-Waist.jpg",
    "assets/Classic Twist.jpg",
    "assets/Asymmetric.jpg",
    "assets/Ultra-Long Coat.jpg"
  ];
  List<String> fallImagesText = [
    "Pop of Color",
    "Bare-Leg Fall",
    "Off-Duty",
    "Everyday Floral",
    "Sans-Pants",
    "Wild Fall",
    "Streetwear Fall",
    "Textural",
    "Rainy Day",
    "Leather Trench",
    "Transitional",
    "Cinched-Waist",
    "Classic Twist",
    "Asymmetric",
    "Ultra-Long Coat"
  ];

  List<String> trend = [];
  List<String> trendText = [];
  bool showMore = false;
  
  @override
  void initState(){
    super.initState();
    if(widget.showSearchBarHelp){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([...searchBar]);
      });
    }
    trend = allImages;
    trendText = allImagesText;
  }

  @override
  Widget build(BuildContext context) {
    List<String> initialChoices = occasionchoice.take(2).toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: Image.asset(
                      "assets/summonfizard.png",
                      height: 40,
                      width: 140,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/iconimage1.png",
                    height: 28,
                    width: 28,
                  ),
                  const SizedBox(width: 18),
                  Image.asset(
                    "assets/iconimage2.png",
                    height: 28,
                    width: 28,
                  ),
                  const SizedBox(width: 18),
                  Image.asset(
                    "assets/iconimage3.png",
                    height: 28,
                    width: 28,
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap:() =>{
                Navigator.push(context,MaterialPageRoute(builder: (context) => const SearchBarPage()))
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Stack(
                  children: [
                    Showcase(
                      key: searchBar[0],
                      descTextStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      description:
                          'Discover with precision. Search keywords, product names, or categories to explore trendy fashion, tech gadgets, or exquisite home decor effortlessly.',
                      targetBorderRadius: BorderRadius.circular(20),
                      child: TextFormField(
                        controller: searchcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFFBABABA),
                              )),
                          labelStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFBABABA),
                          ),
                          labelText: "Search by keyword or Product ID",
                          enabled:false,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/search.png',
                                    height: 30, width: 30),
                              ],
                            ),
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 60.0, // Height equal to TextFormField
                                width: 1.0, // Full width
                                color: const Color(
                                    0xFFBABABA), // Color of the lin // Adjust margin as needed
                              ),
                              Showcase(
                                key: searchBar[1],
                                descTextStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                description:
                                    'Simply say what you\'re looking for, and let our microphone search feature find it for you.',
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset('assets/mic.png',
                                      height: 25, width: 25),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Showcase(
                                key: searchBar[2],
                                descTextStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                description:
                                    'Upload an image, and our search feature will find similar items for you. Explore visually and find what you love with ease.',
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset('assets/camera.png',
                                      height: 25, width: 25),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "Welcome, Rosan D",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "What are you looking for?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF797979),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Image.asset(
                          categoryImages[index],
                          height: 80,
                          width: 80,
                        ),
                        Text(categoryText[index],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "Explore by trend",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF797979),
                  fontSize: 21.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: choices.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentChoiceIndex =
                              index;
                          switch(currentChoiceIndex){
                            case 0:
                              trend = allImages;
                              trendText = allImagesText;
                              break;
                            case 1:
                              trend = winterImages;
                              trendText = winterImagesText;
                              break;
                            case 2:
                              trend = summerImages;
                              trendText = summerImagesText;
                              break;
                            case 3:
                              trend = springImages;
                              trendText = springImagesText;
                              break;
                            case 4:
                              trend = fallImages;
                              trendText = fallImagesText;
                              break;
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                          color: index == currentChoiceIndex
                              ? Colors.black
                              : const Color(0xFFD9D9D9),
                        ),
                        child: Center(
                          child: Text(
                            choices[index],
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: index == currentChoiceIndex
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: index == currentChoiceIndex
                                    ? FontWeight.w500
                                    : null),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trend.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 130,
                              child: AspectRatio(
                                aspectRatio: 3 / 4,
                                child: Image.asset(
                                  trend[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                                width: 130,
                                child: Text(
                                  trendText[index],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "Any Occasion on mind?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF797979),
                  fontSize: 21.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (!showMore)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 5,
                  children: [
                    ...initialChoices
                        .asMap()
                        .entries
                        .map((entry) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentOccasionChoiceIndex = entry.key;
                                });
                              },
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                label: Text(
                                  entry.value,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color:
                                        currentOccasionChoiceIndex == entry.key
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                                backgroundColor:
                                    currentOccasionChoiceIndex == entry.key
                                        ? Colors.black
                                        : Colors.white,
                              ),
                            )),
                    if (!showMore)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showMore = true;
                          });
                        },
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: const Text(
                            'Show More',
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            if (showMore)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 2,
                  children: [
                    ...occasionchoice
                        .asMap()
                        .entries
                        .map((entry) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentOccasionChoiceIndex = entry.key;
                                });
                              },
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                label: Text(
                                  entry.value,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color:
                                        currentOccasionChoiceIndex == entry.key
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                                backgroundColor:
                                    currentOccasionChoiceIndex == entry.key
                                        ? Colors.black
                                        : Colors.white,
                              ),
                            )),
                    if (showMore)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showMore = false;
                          });
                        },
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: const Text(
                            'Show less',
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: WeddingImages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 130,
                              child: AspectRatio(
                                aspectRatio: 3 / 4,
                                child: Image.asset(
                                  WeddingImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                                width: 130,
                                child: Text(
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                  WeddingImagesText[index],
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            CarouselSlider(banners: banners),
            const SizedBox(height: 20),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              color: Colors.black,
              child: const Text(
                "Find your best fit ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
            const ProductDisplayPage(),
          ],
        ),
      ),
    );
  }
}
