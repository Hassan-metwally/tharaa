enum ChatMessageType {
  text("text"),
  unKnown("");

  final String jsonValue;

  const ChatMessageType(this.jsonValue);

  factory ChatMessageType.fromJson(String? json) {
    return ChatMessageType.values.firstWhere(
      (type) => type.jsonValue.toLowerCase() == json?.toLowerCase(),
      orElse: () => ChatMessageType.text,
    );
  }
}
