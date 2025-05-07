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
    final double width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        spacing: 8,
        children: [

          TextFormField(
            controller: requestController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your request';
              }
              return null;
            },
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              hintText: 'Enter your request',
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40, minWidth: width),
            child: FilledButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Send'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String emailBody = requestController.text;
                  final String emailSubject = 'Request Information Mobile Alpine Trails';

                  emailService.sendEmail(emailSubject, emailBody);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Thank you for your request!'),
                    ),
                  );
                }
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
