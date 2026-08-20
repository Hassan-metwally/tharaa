enum ChatUserTypeEnum {
  student("client"),
  teacher("provider"),
  unKnown("");

  final String jsonValue;

  factory ChatUserTypeEnum.fromJson(String? json) {
    return ChatUserTypeEnum.values.firstWhere((e) => e.jsonValue == json, orElse: () => ChatUserTypeEnum.unKnown);
  }

  const ChatUserTypeEnum(this.jsonValue);
}
