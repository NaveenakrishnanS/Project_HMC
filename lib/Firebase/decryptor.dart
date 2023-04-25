import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import "package:pointycastle/export.dart";
import 'package:project_hmc/firebase/key_managers/rsa_key_manager.dart';

class Decryptor {
  String rsaDecrypt(RSAPrivateKey myPrivate, Uint8List c) {
    final p = AsymmetricBlockCipher('RSA/OAEP');
    p.init(false, PrivateKeyParameter<RSAPrivateKey>(myPrivate));
    final m = p.process(c);
    final de = (utf8.decode(m));
    return de;
  }

  String aesAlgorithmDecrypt(
      encryptionKey, Uint8List nonce, String ciphertextBase64) {
    var ciphertextDecryptionBase64 = ciphertextBase64;
    encryptionKey = base64Decoding(encryptionKey);
    var decryptedText = aesGcmDecryptionFromBase64(
        encryptionKey, nonce, ciphertextDecryptionBase64);
    return decryptedText;
  }

  String aesGcmDecryptionFromBase64(
      Uint8List key, Uint8List nonce, String data) {
    var parts = data.split(':');
    var ciphertext = base64.decode(parts[0]);
    var gcmTag = base64.decode(parts[1]);
    var bb = BytesBuilder();
    bb.add(ciphertext);
    bb.add(gcmTag);
    var ciphertextWithTag = bb.toBytes();
    final cipher = GCMBlockCipher(AESEngine());
    var aeadParameters =
        AEADParameters(KeyParameter(key), 128, nonce, Uint8List(0));
    cipher.init(false, aeadParameters);
    return String.fromCharCodes(cipher.process(ciphertextWithTag));
  }

  Uint8List base64Decoding(String input) {
    return base64.decode(input);
  }

  Uint8List createUint8ListFromString(String s) {
    var ret = Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  Future<String> hmcDecryptor(
      {required String encryptedText,
      required String nonce,
      required String encryptedAesKey,
      required String rsaPrivateKey}) async {
    List<String> decodedEC = encryptedText.split(':');
    decodedEC.removeLast();
    List<Uint8List> decodedChunks = [];
    for (var i in decodedEC) {
      decodedChunks.add(base64Decoding(i));
    }
    List<String> decryptedChunks = [];
    RSAPrivateKey rsaPrivate = RSAKeyManager().stringToRsaPrk(rsaPrivateKey);
    for (var i in decodedChunks) {
      decryptedChunks.add(rsaDecrypt(rsaPrivate, i));
    }
    String decryptedText = "";
    for (var i in decryptedChunks) {
      decryptedText += i;
    }
    final decryptedAesKey = hmcAesKeyDecryptor(encryptedAesKey: encryptedAesKey,rsaPrivateKey: rsaPrivateKey);
    //Aes Multiple Decryption
    final iv = createUint8ListFromString(nonce);
    for (var i = 0; i < 5; i++) {
      decryptedText = aesAlgorithmDecrypt(decryptedAesKey, iv, decryptedText);
    }
    return decryptedText;
  }

  Future<String> hmcAesKeyDecryptor({required String encryptedAesKey, required String rsaPrivateKey}) async{
    RSAPrivateKey rsaPrivate = RSAKeyManager().stringToRsaPrk(rsaPrivateKey);
    Uint8List encryptedAesKeyList = createUint8ListFromString(encryptedAesKey);
    String decryptedAesKey = rsaDecrypt(rsaPrivate, encryptedAesKeyList);
    return decryptedAesKey;
  }

}
