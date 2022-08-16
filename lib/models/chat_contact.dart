import 'dart:convert';

class ChatContact {
  final String name;
  final String profilePicture;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;
  ChatContact({
    required this.name,
    required this.profilePicture,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });

  ChatContact copyWith({
    String? name,
    String? profilePicture,
    String? contactId,
    DateTime? timeSent,
    String? lastMessage,
  }) {
    return ChatContact(
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      contactId: contactId ?? this.contactId,
      timeSent: timeSent ?? this.timeSent,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'profilePicture': profilePicture});
    result.addAll({'contactId': contactId});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'lastMessage': lastMessage});

    return result;
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatContact.fromJson(String source) =>
      ChatContact.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatContact(name: $name, profilePicture: $profilePicture, contactId: $contactId, timeSent: $timeSent, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatContact &&
        other.name == name &&
        other.profilePicture == profilePicture &&
        other.contactId == contactId &&
        other.timeSent == timeSent &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePicture.hashCode ^
        contactId.hashCode ^
        timeSent.hashCode ^
        lastMessage.hashCode;
  }
}
