import 'package:faszen/screens/init_page.dart';
import 'package:faszen/widgets/gradient_border.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../models/calculatewidth.dart';
import 'package:flutter/material.dart';
import 'package:faszen/models/chatmodel.dart';
import '../animated_box.dart';

// ignore: must_be_immutable
class BotWidgetButton extends StatelessWidget {
  BotWidgetButton(
      {super.key,
      this.text,
      required this.index,
      required this.destination,
      required this.list});
  String? text;
  String destination;
  int? index;
  bool showshimmer = false;
  List<ChatModel>? list;

  void naivagator(context) {
    switch (destination) {
      case "search":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowCaseWidget(
                builder: Builder(
                    builder: (context) => InitPage(showSearchBarHelp: true, showProfileEditHelp: false ))),
          ),
        );
        break;
      case "profile_edit":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowCaseWidget(
                builder: Builder(
                    builder: (context) =>
                        InitPage(showProfileEditHelp: true))),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxWidth = constraints.maxWidth * 0.7;
                if (list![index!].isShimmer == false) {
                  list![index!].isShimmer = true;
                  return FutureBuilder<void>(
                    future: Future.delayed(
                        const Duration(seconds: 2)), 
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return AnimatedBox();
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: maxWidth !=
                                      calculateContainerWidth(
                                          context, maxWidth, text!)
                                  ? null
                                  : maxWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF000000),
                                    Color(0xFF575757),
                                  ],
                                ),
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
                              child: Text(
                                text!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                naivagator(context);
                              },
                              child: Container(
                                height: 45, // Height of the button
                                width: MediaQuery.of(context).size.width *
                                    0.35, // Width of the button
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      25), // Button border radius
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.25), // Box shadow color
                                      blurRadius: 4, // Box shadow blur radius
                                      offset: const Offset(
                                          0, 4), // Box shadow offset
                                    ),
                                  ],
                                  border: const GradientBorder(
                                    borderGradient: LinearGradient(
                                      colors: [
                                        Color(0xFFDB71E5),
                                        Color(0xFFB763CB),
                                        Color(0xFF9556B3),
                                        Color(0xFF8D53AD),
                                        Color(0xFF453879),
                                      ],
                                      tileMode: TileMode.repeated,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0, 0.2, 0.4, 0.6, 1],
                                      transform: GradientRotation(0.0),
                                    ),
                                    width: 2.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Guide Spell 🔮',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: maxWidth !=
                                calculateContainerWidth(
                                    context, maxWidth, text!)
                            ? null
                            : maxWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF000000),
                              Color(0xFF575757),
                            ],
                          ),
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
                        child: Text(
                          text!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          naivagator(context);
                        },
                        child: Container(
                          height: 45, // Height of the button
                          width: MediaQuery.of(context).size.width *
                              0.35, // Width of the button
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                25), // Button border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.25), // Box shadow color
                                blurRadius: 4, // Box shadow blur radius
                                offset: const Offset(0, 4), // Box shadow offset
                              ),
                            ],
                            border: const GradientBorder(
                              borderGradient: LinearGradient(
                                colors: [
                                  Color(0xFFDB71E5),
                                  Color(0xFFB763CB),
                                  Color(0xFF9556B3),
                                  Color(0xFF8D53AD),
                                  Color(0xFF453879),
                                ],
                                tileMode: TileMode.repeated,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0, 0.2, 0.4, 0.6, 1],
                                transform: GradientRotation(0.0),
                              ),
                              width: 2.5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Guide Spell 🔮',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
