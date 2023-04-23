import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import "package:pointycastle/export.dart";
import 'package:project_hmc/firebase/cloud_database.dart';

import '../auth/firebase_auth.dart';
import '../flutter_secure_storage/secure_storage.dart';

class RSAKeyManager {
  SecureRandom exampleSecureRandom() {
    final secureRandom = FortunaRandom();
    final seedSource = Random.secure();
    final seeds = <int>[];
    for (int i = 0; i < 32; i++) {
      seeds.add(seedSource.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  Future<AsymmetricKeyPair<PublicKey, PrivateKey>> generateRsaKeyPair() async {
    print("RSA Key Generation Starts...");
    final keyGen = KeyGenerator('RSA');
    SecureRandom mySecureRandom = exampleSecureRandom();
    final rsaParams =
        RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 64);
    final paramsWithRnd = ParametersWithRandom(rsaParams, mySecureRandom);
    try {
      keyGen.init(paramsWithRnd);
      final pair = keyGen.generateKeyPair();
      print("RSA Key Generation Ends...");
      return pair;
    } catch (e) {
      print("RSA Key Generation Failed: $e");
      return Future.error("RSA Key Generation Failed");
    }
  }

  String rsaPukToString(RSAPublicKey puk) {
    final mod = puk.modulus;
    final exp = puk.exponent;
    final modString = mod.toString();
    final expString = exp.toString();
    final modStringBase64 = base64.encode(utf8.encode(modString));
    final expStringBase64 = base64.encode(utf8.encode(expString));
    return '$modStringBase64:$expStringBase64';
  }

  String rsaPrkToString(RSAPrivateKey prk) {
    final mod = prk.modulus;
    final pe = prk.privateExponent;
    final p = prk.p;
    final q = prk.q;
    final modString = mod.toString();
    final peString = pe.toString();
    final pString = p.toString();
    final qString = q.toString();
    final modStringBase64 = base64.encode(utf8.encode(modString));
    final peStringBase64 = base64.encode(utf8.encode(peString));
    final pStringBase64 = base64.encode(utf8.encode(pString));
    final qStringBase64 = base64.encode(utf8.encode(qString));
    return '$modStringBase64:$peStringBase64:$pStringBase64:$qStringBase64';
  }

  RSAPublicKey stringToRsaPuk(String puk) {
    var parts = puk.split(':');
    var modString = parts[0];
    var expString = parts[1];
    var modStringBase64 = base64.decode(modString);
    var expStringBase64 = base64.decode(expString);
    var modStringDecoded = utf8.decode(modStringBase64);
    var expStringDecoded = utf8.decode(expStringBase64);
    var mod = BigInt.parse(modStringDecoded);
    var exp = BigInt.parse(expStringDecoded);
    var rsaPuk = RSAPublicKey(mod, exp);
    return rsaPuk;
  }

  RSAPrivateKey stringToRsaPrk(String prk) {
    var parts = prk.split(':');
    var modString = parts[0];
    var peString = parts[1];
    var pString = parts[2];
    var qString = parts[3];
    var modStringBase64 = base64.decode(modString);
    var peStringBase64 = base64.decode(peString);
    var pStringBase64 = base64.decode(pString);
    var qStringBase64 = base64.decode(qString);
    var modStringDecoded = utf8.decode(modStringBase64);
    var peStringDecoded = utf8.decode(peStringBase64);
    var pStringDecoded = utf8.decode(pStringBase64);
    var qStringDecoded = utf8.decode(qStringBase64);
    var mod = BigInt.parse(modStringDecoded);
    var pe = BigInt.parse(peStringDecoded);
    var p = BigInt.parse(pStringDecoded);
    var q = BigInt.parse(qStringDecoded);
    var rsaPrk = RSAPrivateKey(mod, pe, p, q);
    return rsaPrk;
  }

  Future generateKeysAndSave(
      AsymmetricKeyPair<PublicKey, PrivateKey> rsaKeyPair) async {
    final rsaPublicKey = rsaKeyPair.publicKey as RSAPublicKey;
    final rsaPublicKeyString = rsaPukToString(rsaPublicKey);
    final fss = FSS();
    await fss.saveData("RSAPublicKey", rsaPublicKeyString);
    final rsaPrivateKey = rsaKeyPair.privateKey as RSAPrivateKey;
    final rsaPrivateKeyString = rsaPrkToString(rsaPrivateKey);
    await fss.saveData("RSAPrivateKey", rsaPrivateKeyString);
    await CloudDatabase().addPublicKey(
        PublicKey: rsaPublicKeyString, UID: FirebaseAuthentication.getUserUid);
    await CloudDatabase().backupPrivateKey(
        PrivateKey: rsaPrivateKeyString,
        UID: FirebaseAuthentication.getUserUid);
  }
}
