import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../authentication/data/models/api_user_model.dart';
import '../../domain/entity/menu/static_page_type_enum.dart';
import '../../domain/use_cases/menu/send_contact_us_message_use_case.dart';

abstract class MenuCommonDatasource {
  Future<String> getStaticPageData(StaticPageTypeEnum type);
  Future<Map<String, dynamic>> getContactUsData();
  Future<void> sendContactUsMessage(SendContactUsMessageParams params);
  Future<ApiUserModel> toggleNotificationEnable();
}

@Injectable(as: MenuCommonDatasource)
class MenuCommonDatasourceImpl extends MenuCommonDatasource {
  final DioHelper _dioHelper;

  MenuCommonDatasourceImpl(this._dioHelper);

  @override
  Future<String> getStaticPageData(StaticPageTypeEnum type) async {
    try {
      final result = await _dioHelper.get(url: ApiConstants.addToApiUrlPath(type.key));
      return result['data']['value'] ?? '';
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getContactUsData() async {
    try {
      final result = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('contact'));
      return result['data'];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> sendContactUsMessage(SendContactUsMessageParams params) async {
    try {
      await _dioHelper.post(url: ApiConstants.addToApiUrlPath('contact-us'), body: params.toMap);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiUserModel> toggleNotificationEnable() async {
    try {
      final result = await _dioHelper.post(url: 'auth/toggle-notification');
      return ApiUserModel.fromJson(result['data']['user']);
    } catch (_) {
      rethrow;
    }
  }
}
