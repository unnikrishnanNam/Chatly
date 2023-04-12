class Message {
  Message({
    required this.toId,
    required this.sentTime,
    required this.readTime,
    required this.message,
    required this.type,
    required this.fromId,
  });
  late final String toId;
  late final String sentTime;
  late final String readTime;
  late final String message;
  late final Type type;
  late final String fromId;

  Message.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    sentTime = json['sentTime'].toString();
    readTime = json['readTime'].toString();
    message = json['message'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['sentTime'] = sentTime;
    data['readTime'] = readTime;
    data['message'] = message;
    data['type'] = type.name;
    data['fromId'] = fromId;
    return data;
  }
}

enum Type { text, image }
