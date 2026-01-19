import 'package:flutter/material.dart';
import 'package:flutter_application/enums.dart';
import 'package:flutter_application/services/email_service.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final availabilityStyle = _getAvailabilityColors(availability);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(image!, width: 90, height: 90, fit: BoxFit.cover),
                ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown)),
                    const SizedBox(height: 6),
                    _buildRatingRow(context),
                    const SizedBox(height: 10),
                    _buildAvailabilityBadge(availabilityStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (subtitle != null)
            Text(subtitle!, style: TextStyle(color: Colors.grey.shade700, height: 1.5, fontSize: 15)),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          _buildContactItem(Icons.phone_iphone_rounded, phone, "tel:$phone"),
          _buildContactItem(Icons.mail_outline_rounded, email, "mailto:$email"),
          _buildContactItem(Icons.language_rounded, website, website, isLink: true),
        ],
      ),
    );
  }

  Widget _buildRatingRow(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text("$rate", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(" ($ratings recensioni)", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
      ],
    );
  }

  Widget _buildAvailabilityBadge(AvailabilityColors style) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: style.background, borderRadius: BorderRadius.circular(12)),
      child: Text(availability!.displayName.toUpperCase(), 
        style: TextStyle(color: style.text, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
    );
  }

  Widget _buildContactItem(IconData icon, String? value, String? url, {bool isLink = false}) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url!)),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.brown.shade300),
            const SizedBox(width: 12),
            Text(value, style: TextStyle(
              fontSize: 14, 
              color: isLink ? Colors.blue.shade700 : Colors.black87,
              decoration: isLink ? TextDecoration.underline : null
            )),
          ],
        ),
      ),
    );
  }
}