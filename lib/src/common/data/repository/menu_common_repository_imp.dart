import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../authentication/data/models/api_user_model.dart';
import '../../domain/entity/menu/contact_us_entity.dart';
import '../../domain/entity/menu/static_page_type_enum.dart';
import '../../domain/repository/menu_common_repository.dart';
import '../../domain/use_cases/menu/send_contact_us_message_use_case.dart';
import '../datasources/menu_common_datasource.dart';

@Injectable(as: MenuCommonRepository)
class MenuCommonRepositoryImp implements MenuCommonRepository {
  final MenuCommonDatasource _dataSource;
  final SecureStorageRepository _secureStorage;

  MenuCommonRepositoryImp(this._dataSource, this._secureStorage);

  @override
  DomainServiceType<String> getStaticPageData(StaticPageTypeEnum type) async {
    return await failureCollect<String>(() async {
      final data = await _dataSource.getStaticPageData(type);
      return Right(data);
    });
  }

  @override
  DomainServiceType<ContactUsEntity> getContactUsData() async {
    return await failureCollect<ContactUsEntity>(() async {
      final data = await _dataSource.getContactUsData();
      return Right(ContactUsEntity.fromJson(data));
    });
  }

  @override
  DomainServiceType<void> sendContactUsMessage(SendContactUsMessageParams params) async {
    return await failureCollect<void>(() async {
      await _dataSource.sendContactUsMessage(params);
      return const Right(null);
    });
  }

  // @override
  // DomainServiceType<List<FaqEntity>> getFaqList() async {
  //   return await failureCollect<List<FaqEntity>>(() async {
  //     final data = await _dataSource.getFaqList();
  //     return Right(data);
  //   });
  // }

  @override
  DomainServiceType<void> toggleNotificationEnable() async {
    return await failureCollect<void>(() async {
      final user = await _dataSource.toggleNotificationEnable();
      await _secureStorage.setCachedUser(user.map.mapToCacheEntity);
      return const Right(null);
    });
  }
}
