import 'package:flutter_application/enums.dart';
import 'package:flutter_application/interfaces/carousel_image_info.dart';

const List<CarouselImageInfo> homeCarouselImages = [
  CarouselImageInfo(
    page: PageName.contact,
    imageUrl: 'images/home-carousel-1.png',
    title: 'Camping',
    subtitle: 'Experience the beauty of nature',
    filters: ['Campeggio'],
  ),
  CarouselImageInfo(
    page: PageName.contact,
    imageUrl: 'images/home-carousel-2.png',
    title: 'Hiking',
    subtitle: 'Discover breathtaking trails and views',
    filters: ['Hiking'],
  ),
  CarouselImageInfo(
    page: PageName.contact,
    imageUrl: 'images/home-carousel-3.png',
    title: 'Mountain Biking',
    subtitle: 'Ride through thrilling mountain paths',
    filters: ['Mountain Biking'],
  ),
  CarouselImageInfo(
    page: PageName.contact,
    imageUrl: 'images/home-carousel-4.png',
    title: 'Trekking',
    subtitle: 'Challenge yourself with scenic treks',
    filters: ['Trekking']
  ),
  CarouselImageInfo(
    page: PageName.contact,
    imageUrl: 'images/home-carousel-5.png',
    title: 'Snowshoeing',
    subtitle: 'Enjoy the serene winter landscapes',
    filters: ['Ciaspole (Snowshoeing)'],
  ),
];

const markerType2IconData = <String, String>{
  'Vetta Iconica/Punto Panoramico': 'images/mountain-icon.png',
  'Passo Alpino': 'images/map-icon.png',
  'Lago Suggestivo': 'images/drop-icon.png',
  'Rifugio Noto': 'images/flag-icon.png',
  'Cittadina/Località': 'images/house-icon.png',
};
