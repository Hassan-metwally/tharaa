part of core;

const String _tokenKey = 'access_token';
const String _tokenActivated = 'activation';
const String _createdAtKey = 'TokenCreatedAt';

class TokenModel extends TokenEntity {
  TokenModel({required super.token, super.isSingleSession = false, DateTime? createdAt}) : super(createdAt: createdAt ?? DateTime.now());

  factory TokenModel.fromEntity(Token token) =>
      TokenModel(token: token.token, createdAt: token.createdAt, isSingleSession: token.isSingleSession);

  factory TokenModel.forSingleSession({required String token}) =>
      TokenModel(token: token, isSingleSession: true, createdAt: DateTime.now());

  factory TokenModel.fromCache(String tokenJson) {
    final Map<String, dynamic> decodedMap = json.decode(tokenJson);
    return TokenModel.fromMap(decodedMap);
  }

  factory TokenModel.fromMap(Map<String, dynamic> tokenMap) {
    final Map<String, dynamic> decodedMap = tokenMap;
    DateTime? createdAt;
    if (decodedMap.containsKey(_createdAtKey)) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(decodedMap[_createdAtKey]);
    }
    final bool isSingleSession = decodedMap[_tokenActivated] ?? false;
    final String token = decodedMap[_tokenKey] ?? '';
    return TokenModel(token: token, isSingleSession: isSingleSession, createdAt: createdAt);
  }

  Map<String, dynamic> get toMap => {_tokenKey: token, _tokenActivated: isSingleSession, _createdAtKey: createdAt.millisecondsSinceEpoch};

  String get toJson => json.encode(toMap);
}
