import 'package:flutter/material.dart';

class DetailsOperatorCardWidget extends StatelessWidget {
  const DetailsOperatorCardWidget({
    super.key,
    required this.title,
    this.image,
    this.rate,
    this.ratings,
    this.availability,
    this.subtitle,
    this.phone,
    this.email,
    this.website,
  });

  final String title;
  final String? subtitle;
  final String? phone;
  final String? email;
  final String? website;
  final String? image;
  final double? rate;
  final int? ratings;
  final String? availability;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Card(
      color: Colors.white,
      semanticContainer: true,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                spacing: 20,
                children: [
                  if (image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.network(
                        image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall!.copyWith(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if(rate != null && ratings != null)
                          Row(
                            children: [
                              Icon(
                                Icons.star_border,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '$rate ($ratings reviews)',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
