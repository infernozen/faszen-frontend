import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/productpage.dart';

class SearchDisplayCard extends StatefulWidget {
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
  const SearchDisplayCard(
      {super.key,
      required this.title,
      required this.imageurl,
      required this.rating,
      required this.price,
      required this.id,
      required this.category,
      required this.name,
      required this.description,
      required this.arLensID,
      required this.model3D,
      required this.isAvailable,
      required this.isActive,
      required this.is3Davailable,
      required this.isARTryOnAvailable,
      required this.organizationImageurl,
      required this.sizes,
      required this.redirectLinks,
      required this.images,
      required this.similarproducts,
      required this.variants,
      required this.tags});
  @override
  _SearchDisplayCardState createState() => _SearchDisplayCardState();
}

class _SearchDisplayCardState extends State<SearchDisplayCard> {
  bool _isFavoriteClicked = false;
  bool _isAskFizardPressed = false;
  bool _isAddToWardrobePressed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Stack(
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
                          organizationImageUrl:
                              widget.organizationImageurl.first,
                          organizationName: '',
                          rediretLink: widget.redirectLinks.first,
                        ),
                      ),
                    )
                  },
                  child: Image.network(
                    widget.imageurl,
                    height: 208,
                    width: 180,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: GestureDetector(
                      child: IconButton(
                        icon: _isFavoriteClicked
                            ? const Icon(
                                Icons.favorite,
                              )
                            : const Icon(Icons.favorite_outline),
                        onPressed: () {
                          HapticFeedback.vibrate();
                          final message = _isFavoriteClicked
                              ? 'Removed from favorites'
                              : 'Added to favorites';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                          setState(() {
                            _isFavoriteClicked = !_isFavoriteClicked;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                    organizationName: 'AMAZON SHOPPING',
                    rediretLink: widget.redirectLinks.first,
                  ),
                ),
              )
            },
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: 0.45 * MediaQuery.of(context).size.width,
                    child: DropCapText(
                      dropCap: DropCap(
                        width: 68,
                        height: 25,
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
                                const Spacer(),
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
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      widget.title,
                      style: const TextStyle(
                          height: 1.75,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 12.0),
                    width: 0.5 * MediaQuery.of(context).size.width,
                    child: const Text(
                      "Price Starts from",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 12.0),
                    width: 0.5 * MediaQuery.of(context).size.width,
                    child: Text(
                      "₹${widget.price}",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 12.0),
                    width: 0.5 * MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              _isAskFizardPressed = !_isAskFizardPressed;
                              if (_isAddToWardrobePressed == true) {
                                _isAddToWardrobePressed =
                                    !_isAddToWardrobePressed;
                              }
                            })
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.45,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                color: Colors.black),
                            child: Text(
                              textAlign: TextAlign.center,
                              _isAskFizardPressed ? '🪄 Ask Fizard ?' : '🪄',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              _isAddToWardrobePressed =
                                  !_isAddToWardrobePressed;
                              if (_isAskFizardPressed == true) {
                                _isAskFizardPressed = !_isAskFizardPressed;
                              }
                            })
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.45,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                color: Colors.black),
                            child: Text(
                              textAlign: TextAlign.center,
                              _isAddToWardrobePressed
                                  ? '📦 Add to wardrobe ?'
                                  : '📦',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 0.4 * MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        for (int i = 0;
                            i < widget.organizationImageurl.length;
                            i++)
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
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}