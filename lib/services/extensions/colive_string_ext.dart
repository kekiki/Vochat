import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

extension ColiveStringExt on String {
  static const _aesKey = 'IBojRarkcKW2J525';

  String get aesEncode {
    List<int> source = utf8.encode(this);
    List<int> key = utf8.encode(_aesKey);
    List<int> filled = List.filled(16, 0); // 使用ECB模式，IV值可设置为全0
    final enc =
        AES(Key(Uint8List.fromList(key)), mode: AESMode.ecb, padding: 'PKCS7');
    final encry = enc.encrypt(Uint8List.fromList(source),
        iv: IV(Uint8List.fromList(filled)));
    String encStr = base64.encode(encry.bytes);
    return encStr;
  }

  String get aesDecode {
    List<int> enc = base64.decode(this);
    List<int> key = utf8.encode(_aesKey);
    List<int> fill = List.filled(16, 0); // 使用ECB模式，IV值可设置为全0
    final encry =
        AES(Key(Uint8List.fromList(key)), mode: AESMode.ecb, padding: 'PKCS7');
    final decry = encry.decrypt(Encrypted(Uint8List.fromList(enc)),
        iv: IV(Uint8List.fromList(fill)));
    String decStr = utf8.decode(decry);
    return decStr;
  }
}
