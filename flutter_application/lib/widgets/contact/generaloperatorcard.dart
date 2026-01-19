import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/activity.dart';
import 'package:flutter_application/models/zone.dart';
import 'package:flutter_application/services/email_service.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final VoidCallback onClick;
  final String? subtitle;
  final String? phone;
  final String? email;
  final String? website;
  final List<Activity>? activities;
  final List<Zone>? zones;

  final EmailService emailService = EmailService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titolo e Sottotitolo
                Text(
                  title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: const TextStyle(color: Colors.black54, fontSize: 14)),
                ],
                const SizedBox(height: 20),

                // Contatti
                _buildContactRow(Icons.phone_outlined, phone, "tel://$phone"),
                _buildContactRow(Icons.email_outlined, email, "mailto:$email"),
                _buildContactRow(Icons.language_outlined, website, website, isLink: true),

                const SizedBox(height: 20),

                // Attività (Chip Alpine Style)
                if (activities != null && activities!.isNotEmpty) ...[
                  const Text("ATTIVITÀ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: activities!.map((a) => _buildChip(a.name, Colors.brown.shade50, Colors.brown)).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Zone
                if (zones != null && zones!.isNotEmpty) ...[
                  const Text("ZONE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: zones!.map((z) => _buildChip(z.name, Colors.grey.shade100, Colors.black87)).toList(),
                  ),
                ],
              ],
            ),
          ),

          // Footer Button
          InkWell(
            onTap: onClick,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.brown.shade800,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text("MAGGIORI INFORMAZIONI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String? value, String? url, {bool isLink = false}) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url!)),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.brown.shade300),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: isLink ? Colors.blue.shade700 : Colors.black87,
                  decoration: isLink ? TextDecoration.underline : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: TextStyle(color: text, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}