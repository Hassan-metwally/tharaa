part of core;

typedef Token = TokenEntity;

const Duration _expirationDuration = Duration(days: 45);

class TokenEntity extends Equatable {
  final String token;
  final bool isSingleSession;
  final DateTime createdAt;

  const TokenEntity({required this.token, this.isSingleSession = false, required this.createdAt});

  factory TokenEntity.get(String token) => TokenEntity(token: token, createdAt: DateTime.now());

  bool get isValid {
    if (isSingleSession || isExpired) {
      return false;
    }
    return true;
  }

  bool get isExpired {
    final DateTime expirationDateTime = createdAt.add(_expirationDuration);
    final bool isExpired = expirationDateTime.isBefore(DateTime.now());
    return isExpired && token.isEmpty;
  }

  @override
  List<Object?> get props => [token, isSingleSession, createdAt];

  @override
  String toString() {
    return "-----------------------------------------\n"
        "[Token] $token\n"
        "[Is Single Session] $isSingleSession ::: [Created At] $createdAt ::: [Is Expired] $isExpired\n"
        "-----------------------------------------";
  }
}
