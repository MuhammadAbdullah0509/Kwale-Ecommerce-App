import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController controller = CarouselController();
  final item = [
    "assets/images/slider_images/13428431_388.jpg",
    "assets/images/slider_images/pair-trainers.jpg",
    "assets/images/slider_images/portrait-handsome-smiling-stylish-young-man.jpg",
    "assets/images/slider_images/stunning-curly-female-model-jumping-purple-indoor-portrait-slim-girl-bright-yellow-dress.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: item.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Container(
          //height:  400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage(item[itemIndex]),
                fit: BoxFit.fill,
                alignment: Alignment.center
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        //viewportFraction: 1,
        //aspectRatio: 2.0,
        initialPage: 1,
        autoPlayInterval: const Duration(seconds: 4),
      ),
    );
  }
}
