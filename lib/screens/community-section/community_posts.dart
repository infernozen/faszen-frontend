import 'package:faszen/repositories/community_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CommunityPosts extends StatelessWidget {
  final String title;
  const CommunityPosts({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommunityDataProvider(),
      child: _CommunityPostsContent(title: title),
    );
  }
}

class _CommunityPostsContent extends StatefulWidget {
  final String title;

  const _CommunityPostsContent({required this.title});
  @override
  __CommunityPostsContentState createState() => __CommunityPostsContentState();
}

class __CommunityPostsContentState extends State<_CommunityPostsContent> {
  String selectedOption = 'All';

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider = Provider.of<CommunityDataProvider>(context, listen: false);
      dataProvider.loadCommunityPosts();
    });
  }

  @override
  void dispose(){
    super.dispose();  
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<CommunityDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            icon: Icon(
              Icons.chevron_left_sharp,
              size: MediaQuery.of(context).size.height * 0.045,
            ),
            onPressed: () {
              Navigator.pop(context); // Navigate back when pressed
            },
          ),
        ),
        title: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/icons/search_appbar.png",
              height: MediaQuery.of(context).size.height * 0.070,
              width:  MediaQuery.of(context).size.width * 0.070,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Image.asset(
              "assets/icons/wardrobe_profile.png",
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
        elevation: 5,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        titleSpacing: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color.fromRGBO(243, 244, 246, 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        EllipticalOption(
                          text: 'All',
                          onPressed: () =>
                              setState(() => selectedOption = 'All'),
                          isSelected: selectedOption == 'All',
                        ),
                        EllipticalOption(
                          text: 'Men',
                          onPressed: () =>
                              setState(() => selectedOption = 'Men'),
                          isSelected: selectedOption == 'Men',
                        ),
                        EllipticalOption(
                          text: 'Kids',
                          onPressed: () =>
                              setState(() => selectedOption = 'Kids'),
                          isSelected: selectedOption == 'Kids',
                        ),
                        EllipticalOption(
                          text: 'Women',
                          onPressed: () =>
                              setState(() => selectedOption = 'Women'),
                          isSelected: selectedOption == 'Women',
                        ),
                        EllipticalOption(
                          text: 'New',
                          onPressed: () =>
                              setState(() => selectedOption = 'New'),
                          isSelected: selectedOption == 'New',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.036,
                    right: MediaQuery.of(context).size.width * 0.036),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: dataProvider.sectionLoadingStates['posts'] == true
                      ? List.generate(8, (index) {
                          return const ShimmerItem();
                        })
                      : List.generate(
                          //dataProvider.sectionItemID['super searches']!.length,
                          8,
                          (index) {
                          return GridItem(
                            title: 'Title ${index + 1} hello world',
                            description: 'Description ${index + 1}',
                            imageUrl: 'assets/profile-pic.jpg', // You need to replace this with actual image URL
                          );
                        }),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class EllipticalOption extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const EllipticalOption({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(240, 223, 231, 1)
              : Colors.white,
          border: Border.all(
              color: isSelected
                  ? const Color.fromRGBO(224, 157, 168, 1)
                  : Colors.black,
              width: isSelected ? 1.5 : 0),
          borderRadius: BorderRadius.circular(25),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.0125),
        padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 0.035,
            vertical:
                MediaQuery.of(context).size.width * 0.02),
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: isSelected
                        ? const Color.fromRGBO(224, 157, 168, 1)
                        : const Color.fromRGBO(101, 104, 107, 1),
                    fontFamily: 'Poppins',
                    fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: Colors.grey, // You can set any background color you want for shimmer effect
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const GridItem({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
      ),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    ),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                      ),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey[300]!, fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '0:30',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
