import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import "package:pointycastle/export.dart";
import 'package:project_hmc/firebase/HMC/key_managers/rsa_key_manager.dart';

class Encryptor {
  String aesAlgorithmEncrypt(encryptionKey, Uint8List nonce, String message) {
    // encryption
    encryptionKey = base64Decoding(encryptionKey);
    String ciphertextBase64 =
        aesGcmEncryptionToBase64(encryptionKey, nonce, message);
    return ciphertextBase64;
  }

  String base64Encoding(Uint8List input) {
    return base64.encode(input);
  }

  Uint8List base64Decoding(String input) {
    return base64.decode(input);
  }

  Uint8List generateRandomNonce() {
    final sGen = Random.secure();
    final seed =
        Uint8List.fromList(List.generate(32, (n) => sGen.nextInt(255)));
    SecureRandom sec = SecureRandom("Fortuna")..seed(KeyParameter(seed));
    return sec.nextBytes(12);
  }

  Uint8List stringToUint8List(message) {
    List<int> dataToSign = utf8.encode(message);
    return dataToSign as Uint8List;
  }

  String aesGcmEncryptionToBase64(
      Uint8List key, Uint8List nonce, String plaintext) {
    var plaintextUint8 = createUint8ListFromString(plaintext);
    final cipher = GCMBlockCipher(AESEngine());
    var aeadParameters =
        AEADParameters(KeyParameter(key), 128, nonce, Uint8List(0));
    cipher.init(true, aeadParameters);
    var ciphertextWithTag = cipher.process(plaintextUint8);
    var ciphertextWithTagLength = ciphertextWithTag.lengthInBytes;
    var ciphertextLength =
        ciphertextWithTagLength - 16; // 16 bytes = 128 bit tag length
    var ciphertext =
        Uint8List.sublistView(ciphertextWithTag, 0, ciphertextLength);
    var gcmTag = Uint8List.sublistView(
        ciphertextWithTag, ciphertextLength, ciphertextWithTagLength);
    final ciphertextBase64 = base64.encode(ciphertext);
    final gcmTagBase64 = base64.encode(gcmTag);
    return '$ciphertextBase64:$gcmTagBase64';
  }

  Uint8List createUint8ListFromString(String s) {
    var ret = Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  String rsaEncrypt(RSAPublicKey myPublic, String message) {
    final p = AsymmetricBlockCipher('RSA/OAEP');
    p.init(true, PublicKeyParameter<RSAPublicKey>(myPublic));
    List<int> dataToSign = utf8.encode(message);
    final c = p.process(dataToSign as Uint8List);
    var cipherBase64 = base64Encoding(c);
    return cipherBase64;
  }

  String hmcMessageEncryptor(
      {required String message,
      required String aesKey,
      required String nonce,
      required String rsaPublicKey}) {
    //Aes Multiple Encryption
    final iv = createUint8ListFromString(nonce);
    var aesCipher = "";
    for (var i = 0; i < 5; i++) {
      aesCipher = aesAlgorithmEncrypt(aesKey, iv, message);
      message = aesCipher;
    }
    List<String> chunks = [];
    int chunkSize = 50;
    for (int i = 0; i < aesCipher.length; i += chunkSize) {
      chunks.add(aesCipher.substring(i,
          i + chunkSize > aesCipher.length ? aesCipher.length : i + chunkSize));
    }
    List<String> encryptedChunks = [];
    RSAPublicKey rsaPublic = RSAKeyManager().stringToRsaPuk(rsaPublicKey);
    for (var i in chunks) {
      encryptedChunks.add(rsaEncrypt(rsaPublic, i));
    }
    String encryptedChunksString = "";
    for (var i in encryptedChunks) {
      encryptedChunksString += i;
      encryptedChunksString += ':';
    }
    return encryptedChunksString;
  }

  String hmcAesKeyEncryptor(
      {required String aesKey, required String rsaPublicKey}) {
    RSAPublicKey rsaPublic = RSAKeyManager().stringToRsaPuk(rsaPublicKey);
    String encryptedAesKey = rsaEncrypt(rsaPublic, aesKey);
    return encryptedAesKey;
  }
}
