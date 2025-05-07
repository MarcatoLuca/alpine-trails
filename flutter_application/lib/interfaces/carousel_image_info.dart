import 'package:flutter_application/enums.dart';

interface class CarouselImageInfo {
  const CarouselImageInfo({required this.title, required this.subtitle, required this.page, required this.imageUrl});
  final String title;
  final String subtitle;
  final PageName page;
  final String imageUrl;
}