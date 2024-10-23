abstract class BaseCryptoraphicService {
  String encrypt(String plainText, String ticket);

  String decrypt(String encryptedText, String ticket);

  String hash(String ticket);
}
