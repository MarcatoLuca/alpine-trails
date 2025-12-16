import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/activity.dart';
import 'package:flutter_application/models/zone.dart';
import 'package:flutter_application/services/email_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class GeneralOperatorCardWidget extends StatelessWidget {
  GeneralOperatorCardWidget({
    super.key,
    required this.title,
    required this.onClick,
    this.subtitle,
    this.phone,
    this.email,
    this.website,
    this.activities,
    this.zones,
  });

  final String title;
  final Function onClick;
  final String? subtitle;
  final String? phone;
  final String? email;
  final String? website;
  final List<Activity>? activities;
  final List<Zone>? zones;

  final EmailService emailService = EmailService();

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
              // Title
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Subtitle
              if (subtitle != null && subtitle!.trim() != '') Text(subtitle!),

              // Body
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
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
                                            () => launchUrl(
                                              Uri.parse("tel://$phone"),
                                            ),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap =
                                            () =>
                                                launchUrl(Uri.parse(website!)),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),

                    if (activities != null && activities!.isNotEmpty)
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Activities:',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Wrap(
                            children: [
                              ...activities!.map((activity) {
                                // Genera un colore di background pastello chiaro
                                final hue = math.Random().nextDouble() * 360;
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
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    activity.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall!.copyWith(
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

                    if (zones != null && zones!.isNotEmpty)
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Zones:',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            children: [
                              ...zones!.map((zone) {
                                // Genera un colore di background pastello chiaro
                                final backgroundColor = const Color.fromARGB(
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
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    zone.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall!.copyWith(
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
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Divider(),
              ),

              // Footer
              SizedBox(
                width: width,
                child: FilledButton.icon(
                  onPressed: () => onClick(),
                  label: Text(
                    'Get more information',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                  icon: const Icon(Icons.info),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
