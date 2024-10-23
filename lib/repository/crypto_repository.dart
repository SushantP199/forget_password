import 'package:forget_password/utils/debug_printer.dart';
import 'package:forget_password/data/local/base_cryptographic_service.dart';
import 'package:forget_password/data/local/cryptographic_service.dart';
import 'package:forget_password/model/result_model.dart';
import 'package:forget_password/utils/constants.dart';

class CryptoRepository {
  final BaseCryptoraphicService _baseCryptoService = CryptographicService();

  Result encrypt(String plainText, String ticket) {
    Result result;

    try {
      String encryptedText = _baseCryptoService.encrypt(plainText, ticket);
      result = Result(success: true, data: encryptedText);
    } catch (e) {
      result = Result(success: false, error: KError.TECHERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }

  Result decrypt(String encryptedText, String ticket) {
    Result result;

    try {
      String plainText = _baseCryptoService.decrypt(encryptedText, ticket);
      result = Result(success: true, data: plainText);
    } catch (e) {
      result = Result(success: false, error: KError.TECHERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }

  Result hash(String ticket) {
    Result result;

    try {
      String hashedValue = _baseCryptoService.hash(ticket);
      result = Result(success: true, data: hashedValue);
    } catch (e) {
      result = Result(success: false, error: KError.TECHERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }
}
