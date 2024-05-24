import 'package:faszen/screens/productpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductCard extends StatefulWidget {
  final String imageurl, title, id, name, arLensID, model3D, category;
  final double rating, price;
  final bool isAvailable, isActive, is3Davailable, isARTryOnAvailable;
  final List<String> organizationImageurl,
      sizes,
      redirectLinks,
      images,
      similarproducts,
      variants,
      tags,
      description;

  const ProductCard(
      {super.key, required this.title,
      required this.id,
      required this.name,
      required this.arLensID,
      required this.model3D,
      required this.category,
      required this.imageurl,
      required this.rating,
      required this.price,
      required this.isActive,
      required this.isAvailable,
      required this.is3Davailable,
      required this.isARTryOnAvailable,
      required this.images,
      required this.redirectLinks,
      required this.sizes,
      required this.organizationImageurl,
      required this.similarproducts,
      required this.variants,
      required this.tags,
      required this.description});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isfavoriteclicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Product(
                        id: widget.id,
                        name: widget.name,
                        title: widget.title,
                        description: widget.description,
                        category: widget.category,
                        price: widget.price,
                        sizes: widget.sizes,
                        images: widget.images,
                        similarproducts: widget.similarproducts,
                        variants: widget.variants,
                        rating: widget.rating,
                        tags: widget.tags,
                        isAvailable: widget.isAvailable,
                        isActive: widget.isActive,
                        model3D: widget.model3D,
                        isARTryOnAvailable: widget.isARTryOnAvailable,
                        is3Davailable: widget.is3Davailable,
                        arLensID: widget.arLensID,
                        organizationImageUrl: widget.organizationImageurl.first,
                        organizationName: 'Amazon',
                        rediretLink: widget.redirectLinks.first,
                      ),
                    ),
                  )
                },
                child: SizedBox(
                  height: 200,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      widget.imageurl,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 3,
                right: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: GestureDetector(
                    child: IconButton(
                      icon: _isfavoriteclicked
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_outline),
                      onPressed: () {
                        HapticFeedback.vibrate();
                        final message = _isfavoriteclicked
                            ? 'Removed from favorites'
                            : 'Added to favorites';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                        setState(() {
                          _isfavoriteclicked = !_isfavoriteclicked;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 3,
                left: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(40),
                      color: widget.rating > 3
                          ? widget.rating > 4
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
              )
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Product(
                    id: widget.id,
                    name: widget.name,
                    title: widget.title,
                    description: widget.description,
                    category: widget.category,
                    price: widget.price,
                    sizes: widget.sizes,
                    images: widget.images,
                    similarproducts: widget.similarproducts,
                    variants: widget.variants,
                    rating: widget.rating,
                    tags: widget.tags,
                    isAvailable: widget.isAvailable,
                    isActive: widget.isActive,
                    model3D: widget.model3D,
                    isARTryOnAvailable: widget.isARTryOnAvailable,
                    is3Davailable: widget.is3Davailable,
                    arLensID: widget.arLensID,
                    organizationImageUrl: widget.organizationImageurl.first,
                    organizationName: 'AMAZON SHOPPING',
                    rediretLink: widget.redirectLinks.first,
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 165,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      "Starts from",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      "₹${widget.price}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(width: 70),
            Container(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  for (int i = 0; i < widget.organizationImageurl.length; i++)
                    Align(
                      widthFactor: 0.5,
                      child: SizedBox(
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                            widget.organizationImageurl[i],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }
}