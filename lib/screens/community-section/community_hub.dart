import 'dart:async';
import 'package:faszen/repositories/community_data_provider.dart';
import 'package:faszen/screens/community-section/community_posts.dart';
import 'package:faszen/widgets/section_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CommunityPage extends StatelessWidget {
  final void Function() ongetBack;
  const CommunityPage({super.key, required this.ongetBack});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommunityDataProvider(), 
      child: _CommunityPageContent(ongetBack: ongetBack),
    );
  }
}

class _CommunityPageContent extends StatefulWidget {
  final void Function() ongetBack;

  const _CommunityPageContent({required this.ongetBack});
  
  @override
  __CommunityPageContentState createState() => __CommunityPageContentState();
}

class __CommunityPageContentState extends State<_CommunityPageContent> {
  late Timer _timer;
  bool _showFirstItems = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _showFirstItems = !_showFirstItems;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider = Provider.of<CommunityDataProvider>(context, listen: false);
      dataProvider.fetchData();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); 
    super.dispose();
  }

  Widget _buildGridView(List<String> items, List<String> images, bool isLoading) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 0,
              mainAxisSpacing: 15.0,
            ),
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        if (isLoading || items.isEmpty || images.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.1,
                  backgroundColor: Colors.grey[300],
                ),
              ),
              const Spacer(),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.16,
                  height: 14,
                  color: Colors.grey[300],
                ),
              ),
            ],
          );
        } else {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CommunityPosts(
                    title: items[index],
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.1,
                  foregroundImage : NetworkImage(images[index]),
                  backgroundColor: Colors.grey[300],
                ),
                const Spacer(),
                Text(
                  items[index],
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }
      }, 
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<CommunityDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(icon: Icon(Icons.chevron_left_sharp, size: MediaQuery.of(context).size.height * 0.045),
          onPressed: () {
            widget.ongetBack();
          },
          ),
        ),
        title: Row(
          children: [     
            const Text(
              'Community Hub',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500,
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

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 12.0), 
              child: Text(
                "SUPER SEARCHES",
                style: TextStyle(
                  fontFamily: "Poppins-Black",
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildGridView(dataProvider.sectionItemID['super searches']!, dataProvider.sectionImages['super searches']!,dataProvider.sectionLoadingStates['super searches']!),
            const SizedBox(height: 35),
            const Padding(
              padding: EdgeInsets.only(left: 12.0), 
              child: Text(
                "THE DRESS SHOP",
                style: TextStyle(
                  fontFamily: "Poppins-Black",
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SectionListView(sectionKey: 'the dress shop', dataProvider: dataProvider),
            const SizedBox(height: 35),
            const Padding(
              padding: EdgeInsets.only(left: 12.0), 
              child: Text(
                "STYLE HACKS",
                style: TextStyle(
                  fontFamily: "Poppins-Black",
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SectionListView(sectionKey: 'style hacks', dataProvider: dataProvider),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/liveshows.jpg',
                  width: MediaQuery.of(context).size.width *0.9,
                ),
              ],
            ),          
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 12.0), 
              child: Text(
                "BUDGET BUYS",
                style: TextStyle(
                  fontFamily: "Poppins-Black",
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SectionListView(sectionKey: 'budget buys', dataProvider: dataProvider),
            const SizedBox(height: 35),
            const Padding(
              padding: EdgeInsets.only(left: 12.0), 
              child: Text(
                "ETHNIC LOOKS",
                style: TextStyle(
                  fontFamily: "Poppins-Black",
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SectionListView(sectionKey: 'ethnic looks', dataProvider: dataProvider),
            const SizedBox(height: 45),
            const Padding(
              padding: EdgeInsets.only(left: 12.0), 
              child: Text(
                "POPULAR BRANDS",
                style: TextStyle(
                  fontFamily: "Poppins-Black",
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: GridView.builder(
                  key: UniqueKey(), 
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    final int realIndex = _showFirstItems ? index : index + 6;
                    if (dataProvider.sectionLoadingStates['popular brands']!) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          // borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(dataProvider.sectionImages['popular brands']![realIndex]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),            
          ],
        ),
      ),
    );
  }
}