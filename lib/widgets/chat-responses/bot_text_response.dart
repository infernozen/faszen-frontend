import 'package:faszen/widgets/gradient_border.dart';
import 'package:flutter/material.dart';
import '../../models/calculatewidth.dart';
import 'package:faszen/models/chatmodel.dart';
import '../animated_box.dart';

// ignore: must_be_immutable
class BotWidget extends StatelessWidget {
  BotWidget({
    super.key,
    required this.text,
    required this.index,
    required this.list,
  });
  String? text;
  bool showshimmer = false;
  int? index;
  List<ChatModel>? list;


  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    return Container(
                      width: maxWidth !=
                              calculateContainerWidth(context, maxWidth, text!)
                          ? null
                          : maxWidth,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF000000),
                            Color(0xFF575757),
                          ],
                        ),

                        borderRadius: BorderRadius.circular(10),
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
                          fontFamily: 'Poppins',
                          //wordSpacing: 2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return Container(
                width:
                    maxWidth != calculateContainerWidth(context, maxWidth, text!)
                        ? null
                        : maxWidth,
                decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF000000),
                            Color(0xFF575757),
                          ],
                        ),

                        borderRadius: BorderRadius.circular(10),
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
                    fontFamily: 'Poppins',
                    //wordSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


