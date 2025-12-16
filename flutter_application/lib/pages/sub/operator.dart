import 'package:flutter/material.dart';
import 'package:flutter_application/enums.dart';
import 'package:flutter_application/models/operator.dart';
import 'package:flutter_application/services/domain/operator.service.dart';
import 'package:flutter_application/widgets/contact/detailsoperatorcard.dart';
import 'package:flutter_application/widgets/contact/operatorgallery.dart';
import 'package:logger/logger.dart';
import 'dart:math' as math;

class OperatorDetails extends StatefulWidget {
  const OperatorDetails({super.key, required this.id});

  final int id;

  @override
  State<OperatorDetails> createState() => _OperatorDetailsState();
}

class _OperatorDetailsState extends State<OperatorDetails> {
  bool _isFavorite = false;
  final _operatorService = OperatorService();
  final Logger logger = Logger();
  late final ScrollController _scrollController;
  final List<String> _galleryImages = [
    'https://picsum.photos/200',
    'https://picsum.photos/200',
    'https://picsum.photos/200',
    'https://picsum.photos/200',
    'https://picsum.photos/200',
    'https://picsum.photos/200',
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _openGallery(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return GalleryDialog(images: _galleryImages);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        spacing: 8,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Operator Details",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.copyWith(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () => _toggleFavorite(),
                    icon: Icon(
                      Icons.favorite_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    isSelected: _isFavorite,
                    selectedIcon: Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _operatorService.getOperatorById(widget.id),
              builder: (
                BuildContext context,
                AsyncSnapshot<Operator?> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  logger.e('Error loading map markers: ${snapshot.error}');
                  return const Center(child: Text('Error loading data'));
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24,
                        children: [
                          DetailsOperatorCardWidget(
                            title: snapshot.data!.name,
                            subtitle: snapshot.data!.description,
                            phone: snapshot.data!.phone,
                            email: snapshot.data!.email,
                            website: snapshot.data!.website,
                            image: 'https://picsum.photos/200',
                            rate: 4.5,
                            ratings: 128,
                            availability: OperatorAvailability.busy,
                          ),
                          if (snapshot.data!.activities != null)
                            Column(
                              spacing: 12,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Activities',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Wrap(
                                  children: [
                                    ...snapshot.data!.activities!.map((
                                      activity,
                                    ) {
                                      // Genera un colore di background pastello chiaro
                                      final hue =
                                          math.Random().nextDouble() * 360;
                                      final backgroundColor =
                                          HSLColor.fromAHSL(
                                            1.0,
                                            hue,
                                            0.5,
                                            0.85,
                                          ).toColor();

                                      final textColor =
                                          HSLColor.fromColor(backgroundColor)
                                              .withLightness(
                                                (HSLColor.fromColor(
                                                          backgroundColor,
                                                        ).lightness *
                                                        0.5)
                                                    .clamp(0.0, 1.0),
                                              )
                                              .toColor();

                                      return Container(
                                        margin: const EdgeInsets.all(6.0),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 14.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Text(
                                          activity.name,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.copyWith(
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),

                          if (snapshot.data!.zones != null)
                            Column(
                              spacing: 12,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Zones Covered',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Wrap(
                                  children: [
                                    ...snapshot.data!.zones!.map((zone) {
                                      // Genera un colore di background pastello chiaro
                                      final backgroundColor =
                                          const Color.fromARGB(
                                            255,
                                            235,
                                            235,
                                            235,
                                          );

                                      final textColor = const Color.fromARGB(
                                        255,
                                        79,
                                        79,
                                        79,
                                      );

                                      return Container(
                                        margin: const EdgeInsets.all(6.0),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 14.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Text(
                                          zone.name,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.copyWith(
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),

                          Column(
                            spacing: 12,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gallery',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Builder(
                                builder: (context) {
                                  if (_galleryImages.isEmpty) {
                                    return const SizedBox.shrink();
                                  }

                                  final int displayCount = math.min(
                                    _galleryImages.length,
                                    4,
                                  );

                                  return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 1.3,
                                        ),
                                    itemCount: displayCount,
                                    itemBuilder: (context, index) {
                                      final String imageUrl =
                                          _galleryImages[index];

                                      final bool isOverflowCell =
                                          index == 3 &&
                                          _galleryImages.length > 4;
                                      final int remainingCount =
                                          _galleryImages.length - 4;

                                      return GestureDetector(
                                        onTap:
                                            () => {
                                              if (isOverflowCell)
                                                _openGallery(context),
                                            },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16.0,
                                          ),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Image.network(
                                                imageUrl,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (_, __, ___) =>
                                                        const Center(
                                                          child: Icon(
                                                            Icons.error,
                                                          ),
                                                        ),
                                              ),

                                              if (isOverflowCell)
                                                Container(
                                                  color: Colors.black
                                                      .withValues(alpha: .4),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '+$remainingCount',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              spacing: 6,
                              children: [
                                SizedBox(
                                  width: width,
                                  child: FilledButton.icon(
                                    onPressed: () => {},
                                    label: Text(
                                      'Book an Excursion',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                    icon: const Icon(Icons.calendar_month_outlined),
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 24,
                                        horizontal: 32,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text('Free cancellation up to 24h before',
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey[600]),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: Text('No data available.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
