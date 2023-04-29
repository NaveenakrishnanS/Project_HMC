import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? senderId;
  String? receiverId;
  String? message;
  String? nonce;
  String? aesKey;
  DateTime? timestamp;

  ChatModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.nonce,
    required this.aesKey,
    required this.timestamp,
  });

  ChatModel copyWith({
    String? senderId,
    String? receiverId,
    String? message,
    String? aesKey,
    String? nonce,
    DateTime? timestamp,
  }) {
    return ChatModel(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        message: message ?? this.message,
        aesKey: aesKey ?? this.aesKey,
        nonce: nonce ?? this.nonce,
        timestamp: timestamp ?? this.timestamp);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'aesKey': aesKey,
      'nonce': nonce,
      'timestamp': timestamp,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      aesKey: map['aesKey'] as String,
      nonce: map['nonce'] as String,
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(senderId: $senderId, receiverId: $receiverId, message: $message, aesKey: $aesKey, nonce: $nonce, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.message == message &&
        other.aesKey == aesKey &&
        other.nonce == nonce &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        receiverId.hashCode ^
        message.hashCode ^
        aesKey.hashCode ^
        nonce.hashCode ^
        timestamp.hashCode;
  }
}
