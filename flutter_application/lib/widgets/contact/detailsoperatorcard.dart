import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application/enums.dart';
import 'package:flutter_application/services/email_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsOperatorCardWidget extends StatelessWidget {
  DetailsOperatorCardWidget({
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
  final OperatorAvailability? availability;

  final EmailService emailService = EmailService();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final availabilityStyle = _getAvailabilityColors(availability);

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
            spacing: 16,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  // Image
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        //Title
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall!.copyWith(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Rating
                        if (rate != null && ratings != null && ratings! > 0)
                          Row(
                            children: [
                              Icon(Icons.star_border, color: Colors.amber),
                              SizedBox(width: 4),
                              RichText(
                                text: TextSpan(
                                  text: '$rate',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' ($ratings reviews)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        // Availability
                        if (availability != null)
                          Container(
                            margin: const EdgeInsets.all(6.0),
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: availabilityStyle.background,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              availability!.displayName,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(
                                color: availabilityStyle.text,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              // Subtitle
              if (subtitle != null && subtitle!.trim() != '') Text(subtitle!),

              // Contact Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  if (phone != null && phone!.trim() != '')
                    Row(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Colors.brown),
                        RichText(
                          text: TextSpan(
                            text: phone!,
                            style: Theme.of(context).textTheme.bodyMedium,
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap =
                                      () =>
                                          launchUrl(Uri.parse("tel://$phone")),
                          ),
                        ),
                      ],
                    ),

                  if (email != null && email!.trim() != '')
                    Row(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.email, color: Colors.brown),
                        RichText(
                          text: TextSpan(
                            text: email!,
                            style: Theme.of(context).textTheme.bodyMedium,
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    const emptyString = '';
                                    emailService.sendEmail(
                                      emptyString,
                                      emptyString,
                                      emailTo: email!,
                                    );
                                  },
                          ),
                        ),
                      ],
                    ),

                  if (website != null && website!.trim() != '')
                    Row(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.language, color: Colors.brown),
                        RichText(
                          text: TextSpan(
                            text: website!,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap =
                                      () => launchUrl(Uri.parse(website!)),
                          ),
                        ),
                      ],
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

class AvailabilityColors {
  final Color background;
  final Color text;

  const AvailabilityColors({required this.background, required this.text});
}

AvailabilityColors _getAvailabilityColors(OperatorAvailability? availability) {
  switch (availability) {
    case OperatorAvailability.available:
      return AvailabilityColors(
        background: Colors.green.shade100,
        text: Colors.green.shade800,
      );
    case OperatorAvailability.busy:
      return AvailabilityColors(
        background: Colors.orange.shade100,
        text: Colors.orange.shade800,
      );
    case OperatorAvailability.unavailable:
      return AvailabilityColors(
        background: Colors.red.shade100,
        text: Colors.red.shade800,
      );
    default:
      return AvailabilityColors(
        background: Colors.grey.shade200,
        text: Colors.grey.shade800,
      );
  }
}
