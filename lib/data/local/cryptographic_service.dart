import 'package:forget_password/data/local/base_cryptographic_service.dart';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class CryptographicService extends BaseCryptoraphicService {
  @override
  String encrypt(String plainText, String ticket) {
    try {
      final key = Key.fromUtf8("${ticket}MadeInIndiaLagdiHaiBrand");
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encrypt(plainText, iv: iv);

      String encryptedText = String.fromCharCodes(encrypted.bytes);

      return encryptedText;
    } catch (e) {
      rethrow;
    }
  }

  @override
  String decrypt(String encryptedText, String ticket) {
    try {
      Encrypted encryptedObject = Encrypted(
        Uint8List.fromList(encryptedText.codeUnits),
      );

      final key = Key.fromUtf8("${ticket}MadeInIndiaLagdiHaiBrand");
      final iv = IV.fromLength(16);
      final encryptor = Encrypter(AES(key));
      final plainText = encryptor.decrypt(encryptedObject, iv: iv);

      return plainText;
    } catch (e) {
      rethrow;
    }
  }

  @override
  String hash(String ticket) {
    try {
      List<int> ticketBytes = utf8.encode(ticket);
      Digest hashedTicket = sha512.convert(ticketBytes);
      String hashedTicketAsString = "$hashedTicket";

      return hashedTicketAsString;
    } catch (e) {
      rethrow;
    }
  }
}
