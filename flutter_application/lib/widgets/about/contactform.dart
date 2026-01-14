import 'package:flutter/material.dart';
import 'package:flutter_application/services/email_service.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final requestController = TextEditingController();
  final EmailService emailService = EmailService();

  @override
  void dispose() {
    requestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        spacing: 8,
        children: [
          TextFormField(
            controller: requestController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Come possiamo aiutarti?',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.withValues(alpha: 0.2)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.send_rounded, size: 18),
              label: const Text(
                "INVIA RICHIESTA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String emailBody = requestController.text;
                  final String emailSubject =
                      'Request Information Mobile Alpine Trails';

                  emailService.sendEmail(emailSubject, emailBody);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Thank you for your request!'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
