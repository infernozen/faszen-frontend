import 'package:faszen/repositories/community_data_provider.dart';
import 'package:faszen/screens/community-section/youtube_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SectionListView extends StatelessWidget {
  final String sectionKey;
  final CommunityDataProvider dataProvider;

  const SectionListView({super.key, 
    required this.sectionKey,
    required this.dataProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: 200,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!dataProvider.sectionLoadingStates[sectionKey]! &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            dataProvider.loadMoreItems(sectionKey);
          }
          return false;
        },
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dataProvider.sectionItemID[sectionKey]!.length >= 8
              ? dataProvider.sectionItemID[sectionKey]!.length + (dataProvider.sectionLoadingStates[sectionKey]! ? 1 : 0)
              : 8,
          itemBuilder: (BuildContext context, int index) {
            if (index < dataProvider.sectionItemID[sectionKey]!.length) {
              // Display existing items
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YouTubePlayerScreen(videoId: dataProvider.sectionItemID[sectionKey]![index]),
                    ),
                  );
                },
                child: Container(
                  width: 130,
                  height: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(dataProvider.sectionImages[sectionKey]![index]),
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill_outlined,
                      size: 50,
                      color: Color.fromARGB(151, 255, 255, 255),
                    ),
                  ),
                ),
              );
            } else if (dataProvider.sectionLoadingStates[sectionKey]!) {
              // Display shimmer effect while loading
              return Container(
                width: 130,
                height: 130,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            } else {
              // End of list, no more items to load
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
