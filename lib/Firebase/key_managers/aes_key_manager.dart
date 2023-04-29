import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import "package:pointycastle/export.dart";

class AESKeyManager {
  Uint8List generateRandomAesKey() {
    final sGen = Random.secure();
    final seed =
        Uint8List.fromList(List.generate(32, (n) => sGen.nextInt(255)));
    SecureRandom sec = SecureRandom("Fortuna")..seed(KeyParameter(seed));
    return sec.nextBytes(32);
  }

  String aesKey() {
    // generate random key
    var encryptionKey = generateRandomAesKey();
    var encryptionKeyBase64 = base64Encoding(encryptionKey);
    return encryptionKeyBase64;
  }

  String base64Encoding(Uint8List input) {
    return base64.encode(input);
  }
}
