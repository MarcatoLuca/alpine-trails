import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  final String? alpineEmail = dotenv.env['EMAIL_RECIPIENT'];

  sendEmail(String subject, String body, [String? emailTo]) async {

    final Email email = Email(
      isHTML: false,
      recipients: [emailTo ?? alpineEmail!],
      subject: subject,
      body: body
    );

    await FlutterEmailSender.send(email);
  }
}