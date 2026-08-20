import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../repository/menu_common_repository.dart';

@Injectable()
class SendContactUsMessageUseCase extends IUseCase<void, SendContactUsMessageParams> {
  final MenuCommonRepository _repository;

  SendContactUsMessageUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(SendContactUsMessageParams params) async {
    return await _repository.sendContactUsMessage(params);
  }
}

class SendContactUsMessageParams {
  final String name;
  final String email;
  final String countryCode;
  final String phone;
  final ContactUsMessageType type;
  final String message;

  SendContactUsMessageParams({
    required this.name,
    required this.email,
    required this.message,
    required this.phone,
    required this.type,
    required this.countryCode,
  });

  Map<String, dynamic> get toMap => {
    "name": name,
    "email": email,
    "message_type": type.apiValue,
    "message": message,
    "country_code": countryCode,
    "phone": (phone.isNotEmpty && !phone.startsWith('0')) ? '0$phone' : phone,
  };
}

enum ContactUsMessageType {
  request,
  suggestion,
  inquery,
  complaint,
  other;

  String get title {
    switch (this) {
      case ContactUsMessageType.request:
        return appLocalizer.request;
      case ContactUsMessageType.suggestion:
        return appLocalizer.suggestion;
      case ContactUsMessageType.inquery:
        return appLocalizer.inquery;
      case ContactUsMessageType.complaint:
        return appLocalizer.complaint;
      case ContactUsMessageType.other:
        return appLocalizer.other;
    }
  }

  String get apiValue {
    switch (this) {
      case ContactUsMessageType.request:
        return "request";
      case ContactUsMessageType.suggestion:
        return "suggestion";
      case ContactUsMessageType.inquery:
        return "inquiry";
      case ContactUsMessageType.complaint:
        return "complaint";
      case ContactUsMessageType.other:
        return "another";
    }
  }
}
