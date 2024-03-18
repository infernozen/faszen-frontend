import 'package:flutter/material.dart';

import 'animated_box.dart';

Widget buildShimmer(double maxWidth, BuildContext context, String text) {
  return FutureBuilder<void>(
    future: Future.delayed(const Duration(seconds: 3)), // Delay for 3 seconds
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return AnimatedBox();
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  width: maxWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Suggestions are",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 50 * 3,
                        child: ListView.builder(
                          itemCount: 3, // Number of suggestions
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.white, // Orange color for button
                                ),
                                child: Text(
                                  "Suggestion ${index + 1}",
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    },
  );
}
