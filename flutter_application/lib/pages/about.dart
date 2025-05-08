import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/services/email_service.dart';
import 'package:flutter_application/widgets/contactform.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/navbar.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  final EmailService emailService = EmailService();
  final contactFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: 16,
        ),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'About Alpine Trails',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Text(
              'Welcome to Alpine Trails, the ultimate guide for outdoor adventures in the Dolomites!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: FilledButton.icon(
                  onPressed: () {
                    Scrollable.ensureVisible(
                      contactFormKey.currentContext!,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 500),
                    );
                  },
                  label: const Text('Send a request'),
                  icon: const Icon(Icons.arrow_downward),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Emergency Contacts',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Text(
              'In case of emergencies, please reach out to:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Emergency Services:\t',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '112'),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Mountain Rescue:\t',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '+39 987 654 321',
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
                                    () => launchUrl(
                                      Uri.parse("tel://+39 987 654 321"),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'Contact Information',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Text(
              'For general inquiries and support, please contact us at:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Email:\t',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'support@alpinetrails.com',
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
                                ..onTap = () {
                                  final String emailBody = '';
                                  final String emailSubject =
                                      'Emergency request';

                                  emailService.sendEmail(
                                    emailSubject,
                                    emailBody,
                                    'support@alpinetrails.com',
                                  );
                                },
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Phone:\t',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '+39 123 456 789',
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
                                    () => launchUrl(
                                      Uri.parse("tel://+39 123 456 789"),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'Map',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            Card(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                height: 400,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(46.433334, 11.850000),
                    initialZoom: 12,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(46.433334, 11.850000),
                          width: 80,
                          height: 80,
                          child: Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    RichAttributionWidget(
                      attributions: [
                        // Suggested attribution for the OpenStreetMap public tile server
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap:
                              () => launchUrl(
                                Uri.parse(
                                  'https://openstreetmap.org/copyright',
                                ),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'General Information',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Alpine Trails ',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'offers:',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Detailed guides for various outdoor activities',
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Recommendations for equipment and gear',
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(text: 'Real-time weather updates'),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(text: 'Safety tips and best practices'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'Useful Tips',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Always check the weather forecast before heading out',
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Ensure you have the necessary equipment and supplies',
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Familiarise yourself with the emergency procedures and contacts',
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '\u2022 \t\t',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Respect nature and follow Leave No Trace principles',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'Request Information',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Text(
              'Have questions or need more information? Send us your requests directly through the app. Our team is here to assist you with any inquiries you may have.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ContactFormWidget(key: contactFormKey),

            Text(
              'Thank you for choosing Alpine Trails to enhance your adventure in the Dolomites. We hope you have an unforgettable experience!',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(index: 3),
    );
  }
}
