import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer = SmtpServer('smtp.gmail.com',
      username: 'seu email', password: 'sua senha');

  // Cria a mensagem de e-mail
  final message = Message()
    ..from = Address('seu email', 'seu nome')
    ..recipients.add('email do destinatário')
    ..subject = 'assunto'
    ..text = 'texto';

  try {
    // Envia o e-mail
    await send(message, smtpServer);
    print('E-mail enviado com sucesso!');
  } on MailerException catch (e) {
    // Exibe o erro caso o envio falhe
    print('Erro ao enviar o e-mail: ${e.toString()}');
  }
}
