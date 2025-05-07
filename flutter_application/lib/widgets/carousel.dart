import 'package:flutter/material.dart';
import 'package:flutter_application/interfaces/carousel_image_info.dart';
import 'package:flutter_application/providers/pagenotifier.dart';
import 'package:provider/provider.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key, required this.images});
  final List<CarouselImageInfo> images;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    final notifier = Provider.of<PageNotifier>(context, listen: false);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height / 3, minWidth: width),
      child: CarouselView.weighted(
        onTap: (int imageIndex) {
          notifier.changePage(page: widget.images[imageIndex].page, unknown: false);
        },
        controller: controller,
        itemSnapping: true,
        flexWeights: const <int>[1, 7, 1],
        children:
            widget.images.map((CarouselImageInfo image) {
              return HeroLayoutCard(imageInfo: image);
            }).toList(),
      ),
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.imageInfo});

  final CarouselImageInfo imageInfo;

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.sizeOf(context).width;

    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 7 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(imageInfo.imageUrl),
            ),
          ),
        ),
        Container(
          width: width,
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: .3)),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: <Widget>[
                Text(
                  imageInfo.title,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
                Text(
                  imageInfo.subtitle,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
