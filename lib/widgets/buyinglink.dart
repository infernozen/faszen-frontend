// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BuyingLinks extends StatefulWidget {
  String organizationImageUrl;
  String organizationName;
  String productLink;
  double rating;
  double currentPrice;
  bool authorizedSeller;
  bool lastelement;

  BuyingLinks({
    super.key,
    required this.organizationImageUrl,
    required this.organizationName,
    required this.productLink,
    required this.rating,
    required this.currentPrice,
    required this.authorizedSeller,
    required this.lastelement,
  });

  @override
  _BuyingLinksState createState() => _BuyingLinksState();
}

class _BuyingLinksState extends State<BuyingLinks> {
  String getOrganizationName() {
    String url = widget.productLink;
    Uri uri = Uri.parse(url);
    String domain = uri.host;
    if (domain == "amzn.in" || domain == "a.co" || domain == "www.amazon.in") {
      widget.organizationName = "AMAZON SHOPPING";
    } else if (domain == "www.malabargoldanddiamonds.com") {
      widget.organizationName = "MALABAR SHOPPING";
    } else if (domain == "www.flipkart.com") {
      widget.organizationName = "FLIPKART SHOPPING";
    } else if (domain == "domanishoes.com") {
      widget.organizationName = "DOMANISHOES";
    }
    return widget.organizationName;
  }

  Future<void> _launchURL(String url) async {
    final Uri openlinkurl = Uri.parse(url);
    // ignore: deprecated_member_use
    if (!await launch(openlinkurl.toString())) {
      throw Exception('Could not launch web URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.network(
            widget.organizationImageUrl,
            height: 45,
            width: 45,
          ),
          const SizedBox(width: 10),
          Text(
            getOrganizationName(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(
            'assets/verified.png',
            height: 15,
            width: 15,
          ),
          const Spacer(),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  _launchURL(widget.productLink);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/viewproduct.png',
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Open Link",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ]),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.only(left: 70.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
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
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Colors.white,
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
                  Row(
                    children: [
                      const Text(
                        "8112",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Image.asset(
                        'assets/Group_fill.png',
                        height: 16,
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Text(
                    "₹${widget.currentPrice}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    "Current Price",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    ]);
  }
}