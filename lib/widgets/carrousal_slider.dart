import 'dart:async';
import 'package:flutter/material.dart';

class CarouselSlider extends StatefulWidget {
  final List banners;
  const CarouselSlider({super.key, required this.banners});

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;
  final int _totalPages = 6;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _totalPages - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _currentPage = 0;
        _pageController.jumpToPage(_currentPage);
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _totalPages,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (BuildContext context, Widget? child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                      }
                      double boxWidth =
                          MediaQuery.of(context).size.width * 0.98;
                      double boxHeight = boxWidth * (10 / 16);
                      return Center(
                        child: SizedBox(
                          width: Curves.easeOut.transform(value) * boxWidth,
                          height: Curves.easeOut.transform(value) * boxHeight,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                      child:
                          Image.asset(widget.banners[index], fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _totalPages,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentPage
                      ? Colors.black
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
