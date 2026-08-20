// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../src/addresses/data/repositories/address_repository_impl.dart'
    as _i711;
import '../../src/addresses/domain/repositories/address_repository.dart'
    as _i768;
import '../../src/addresses/domain/usecases/add_location_use_case.dart'
    as _i339;
import '../../src/addresses/domain/usecases/delete_location_use_case.dart'
    as _i837;
import '../../src/addresses/domain/usecases/get_addresses_use_case.dart'
    as _i814;
import '../../src/addresses/domain/usecases/update_address_in_address_list_usecase.dart'
    as _i803;
import '../../src/addresses/presentation/my_addresses/my_addresses_cubit.dart'
    as _i583;
import '../../src/addresses/presentation/upsert_address/upsert_address_cubit.dart'
    as _i170;
import '../../src/ads/data/datasources/ads_datasource.dart' as _i268;
import '../../src/ads/data/repositories/ads_repository_impl.dart' as _i331;
import '../../src/ads/domain/repositories/ads_repository.dart' as _i740;
import '../../src/ads/domain/usecases/get_all_ads_usecase.dart' as _i161;
import '../../src/ads/presentation/ads/ads_cubit.dart' as _i779;
import '../../src/authentication/data/repository/authentication_repository_imp.dart'
    as _i469;
import '../../src/authentication/domain/repository/authentication_repository.dart'
    as _i300;
import '../../src/authentication/domain/use_case/can_update_phone_use_case.dart'
    as _i439;
import '../../src/authentication/domain/use_case/delete_account_use_case.dart'
    as _i447;
import '../../src/authentication/domain/use_case/login_use_case.dart' as _i493;
import '../../src/authentication/domain/use_case/logout_use_case.dart' as _i287;
import '../../src/authentication/domain/use_case/register_use_case.dart'
    as _i975;
import '../../src/authentication/domain/use_case/resend_otp_use_case.dart'
    as _i400;
import '../../src/authentication/domain/use_case/verify_otp_use_case.dart'
    as _i902;
import '../../src/cart/data/datasource/cart_datasource.dart' as _i690;
import '../../src/cart/data/repositories/cart_repository_impl.dart' as _i933;
import '../../src/cart/domain/repositories/cart_repository.dart' as _i630;
import '../../src/cart/domain/usecases/delete_cart_item_usecase.dart' as _i607;
import '../../src/cart/domain/usecases/get_cart_items_usecase.dart' as _i896;
import '../../src/cart/domain/usecases/update_cart_delivery_fees_usecase.dart'
    as _i169;
import '../../src/cart/domain/usecases/upsert_cart_item_usecase.dart' as _i507;
import '../../src/cart/presentation/cart_page/cart_cubit.dart' as _i84;
import '../../src/cart/presentation/delete_cart_item/delete_cart_item_cubit.dart'
    as _i262;
import '../../src/cart/presentation/update_cart_delivery_fees/update_cart_delivery_fees_cubit.dart'
    as _i21;
import '../../src/cart/presentation/upsert_cart_item/upsert_cart_item_cubit.dart'
    as _i601;
import '../../src/chat/data/data_source/chat_data_source.dart' as _i559;
import '../../src/chat/data/repository/chat_repository_imp.dart' as _i394;
import '../../src/chat/domain/repository/chat_repository.dart' as _i824;
import '../../src/chat/domain/use_cases/get_chat_information_use_case.dart'
    as _i104;
import '../../src/chat/domain/use_cases/get_chat_messages_use_case.dart'
    as _i989;
import '../../src/chat/domain/use_cases/send_chat_message_use_case.dart'
    as _i558;
import '../../src/chat/domain/use_cases/set_chat_messages_as_read_use_case.dart'
    as _i212;
import '../../src/chats_inbox/data/datasources/chats_inbox_datasource.dart'
    as _i309;
import '../../src/chats_inbox/data/repositories/chats_inbox_repository_impl.dart'
    as _i399;
import '../../src/chats_inbox/domain/repositories/chats_inbox_repository.dart'
    as _i34;
import '../../src/chats_inbox/domain/usecases/get_chats_inbox_usecase.dart'
    as _i388;
import '../../src/chats_inbox/presentation/chats_inbox_cubit.dart' as _i659;
import '../../src/common/data/datasources/common_datasource.dart' as _i1065;
import '../../src/common/data/datasources/menu_common_datasource.dart' as _i758;
import '../../src/common/data/repository/common_repository_imp.dart' as _i867;
import '../../src/common/data/repository/menu_common_repository_imp.dart'
    as _i294;
import '../../src/common/domain/repository/common_repository.dart' as _i92;
import '../../src/common/domain/repository/menu_common_repository.dart'
    as _i646;
import '../../src/common/domain/use_cases/get_banks_usecase.dart' as _i725;
import '../../src/common/domain/use_cases/get_cities_usecase.dart' as _i212;
import '../../src/common/domain/use_cases/get_services_usecase.dart' as _i459;
import '../../src/common/domain/use_cases/language/change_langauge_use_case.dart'
    as _i1006;
import '../../src/common/domain/use_cases/menu/get_contact_us_data_use_case.dart'
    as _i268;
import '../../src/common/domain/use_cases/menu/get_static_data_use_case.dart'
    as _i573;
import '../../src/common/domain/use_cases/menu/send_contact_us_message_use_case.dart'
    as _i45;
import '../../src/common/domain/use_cases/menu/toggle_enable_notification_use_case.dart'
    as _i1015;
import '../../src/google_maps/data/data_sources/maps_data_source.dart' as _i401;
import '../../src/google_maps/data/repository/maps_repository_imp.dart'
    as _i683;
import '../../src/google_maps/domain/repository/maps_repository.dart' as _i410;
import '../../src/google_maps/domain/use_cases/distance/calculate_distance_usecase.dart'
    as _i703;
import '../../src/google_maps/domain/use_cases/enable_gps_and_handle_premistion.dart'
    as _i298;
import '../../src/google_maps/domain/use_cases/google_maps_api/get_location_address_use_case.dart'
    as _i532;
import '../../src/google_maps/domain/use_cases/google_maps_api/get_maps_place_details_use_case.dart'
    as _i10;
import '../../src/google_maps/domain/use_cases/google_maps_api/get_maps_search_suggestions_use_case.dart'
    as _i659;
import '../../src/google_maps/domain/use_cases/location/get_current_location_use_case.dart'
    as _i194;
import '../../src/google_maps/domain/use_cases/location/update_user_location_use_case.dart'
    as _i904;
import '../../src/more/data/repository/more_repository_imp.dart' as _i539;
import '../../src/more/domain/repository/client_more_repository.dart' as _i931;
import '../../src/more/domain/use_cases/get_profile_use_case.dart' as _i582;
import '../../src/more/domain/use_cases/update_profile_use_case.dart' as _i87;
import '../../src/more/presentation/more_page/more_cubit.dart' as _i496;
import '../../src/more/presentation/personal_profile/personal_profile_cubit.dart'
    as _i656;
import '../../src/notifications/data/data_sources/notification_data_source.dart'
    as _i529;
import '../../src/notifications/data/repository/notification_repository_imp.dart'
    as _i1047;
import '../../src/notifications/domain/repository/notification_repository.dart'
    as _i209;
import '../../src/notifications/domain/use_cases/get_notifications_use_case.dart'
    as _i23;
import '../../src/notifications/domain/use_cases/get_unreaded_notifications_count_usecase.dart'
    as _i630;
import '../../src/notifications/domain/use_cases/mark_all_notifications_as_read_use_case.dart'
    as _i366;
import '../../src/notifications/domain/use_cases/read_notification_usecase.dart'
    as _i726;
import '../../src/notifications/presentation/notifications_cubit.dart' as _i545;
import '../../src/rating/data/datasources/rating_datasource.dart' as _i995;
import '../../src/rating/data/repositories/rating_repository_impl.dart'
    as _i665;
import '../../src/rating/domain/repositories/rating_repository.dart' as _i482;
import '../../src/rating/domain/usecases/add_rate_usecase.dart' as _i303;
import '../../src/rating/domain/usecases/get_ratings_usecase.dart' as _i1024;
import '../../src/rating/presentation/add_rate/add_rate_cubit.dart' as _i295;
import '../../src/rating/presentation/ratings/ratings_cubit.dart' as _i158;
import '../../src/statistics/data/datasources/statistics_datasource.dart'
    as _i1069;
import '../../src/statistics/data/repositories/statistics_repository_impl.dart'
    as _i550;
import '../../src/statistics/domain/repositories/statistics_repository.dart'
    as _i581;
import '../../src/statistics/domain/usecases/get_statistics_usecase.dart'
    as _i844;
import '../../src/statistics/presentation/driver_statistics/driver_statistics_cubit.dart'
    as _i38;
import '../../src/statistics/presentation/provider_statistics/provider_statistics_cubit.dart'
    as _i876;
import '../../src/wallet/data/repository/wallet_repository_imp.dart' as _i514;
import '../../src/wallet/domain/repository/wallet_repository.dart' as _i46;
import '../../src/wallet/domain/use_case/charage_wallet_use_case.dart' as _i125;
import '../../src/wallet/domain/use_case/get_balance_use_case.dart' as _i321;
import '../../src/wallet/domain/use_case/get_wallet_history_use_case.dart'
    as _i937;
import '../../src/wallet/domain/use_case/withdraw_balance_use_case.dart'
    as _i751;
import '../../src/wallet/presentation/_client_wallet/client_wallet_cubit.dart'
    as _i612;
import '../../src/wallet/presentation/charge_wallet/charage_wallet_cubit.dart'
    as _i165;
import '../core.dart' as _i351;
import '../data/data_source/language_cache_date_source.dart' as _i203;
import '../data/data_source/secure_storage_data_source.dart' as _i177;
import '../data/repository/language_cache_repository_imp.dart' as _i361;
import '../data/repository/secure_storage_repository_imp.dart' as _i526;
import '../data/repository/theme_repository_imp.dart' as _i715;
import '../domain/repository/theme_repository.dart' as _i984;
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i351.GetIsUserAuthenticatedUseCase>(
      () => _i351.GetIsUserAuthenticatedUseCase(),
    );
    gh.factory<_i361.CancelToken>(() => registerModule.dioCancelToken);
    gh.factory<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i496.MoreCubit>(() => _i496.MoreCubit());
    gh.lazySingleton<_i703.CalculateDistanceUsecase>(
      () => _i703.CalculateDistanceUsecase(),
    );
    gh.lazySingleton<_i298.EnableGpsAndHandlePermissionUseCase>(
      () => _i298.EnableGpsAndHandlePermissionUseCase(),
    );
    gh.factory<_i177.SecureStorageDataSource>(
      () => _i177.SecureStorageDataSourceImpl(),
    );
    gh.factory<_i203.LanguageCacheDateSource>(
      () => _i203.LanguageCacheDateSourceImp(),
    );
    gh.factory<_i984.ThemeRepository>(() => _i715.ThemeRepositoryImp());
    gh.factory<_i351.DioHelper>(() => _i351.DioHelper(dio: gh<_i361.Dio>()));
    gh.factory<_i1069.StatisticsDatasource>(
      () => _i1069.StatisticsDatasourceImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i401.MapsDataSource>(
      () => _i401.MapsDataSourceImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i581.StatisticsRepository>(
      () => _i550.StatisticsRepositoryImpl(gh<_i1069.StatisticsDatasource>()),
    );
    gh.factory<_i559.ChatDataSource>(
      () => _i559.ChatDataSourceImp(gh<_i351.DioHelper>()),
    );
    gh.factory<_i529.NotificationDataSource>(
      () => _i529.NotificationDataSourceImp(gh<_i351.DioHelper>()),
    );
    gh.factory<_i758.MenuCommonDatasource>(
      () => _i758.MenuCommonDatasourceImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i690.CartDatasource>(
      () => _i690.CartDatasourceImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i351.SecureStorageRepository>(
      () =>
          _i526.SecureStorageRepositoryImp(gh<_i177.SecureStorageDataSource>()),
    );
    gh.factory<_i46.WalletRepository>(
      () => _i514.WalletRepositoryImp(gh<_i351.DioHelper>()),
    );
    gh.factory<_i931.MoreRepository>(
      () => _i539.MoreRepositoryImp(
        gh<_i351.DioHelper>(),
        gh<_i351.SecureStorageRepository>(),
      ),
    );
    gh.factory<_i300.AuthenticationRepository>(
      () => _i469.AuthenticationRepositoryImp(
        gh<_i351.DioHelper>(),
        gh<_i351.SecureStorageRepository>(),
      ),
    );
    gh.factory<_i351.DeleteAllSecureCacheUseCase>(
      () => _i351.DeleteAllSecureCacheUseCase(
        gh<_i351.SecureStorageRepository>(),
      ),
    );
    gh.factory<_i351.DeleteCachedUserUseCase>(
      () => _i351.DeleteCachedUserUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.DeleteTokenUseCase>(
      () => _i351.DeleteTokenUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.GetCachedUserUseCase>(
      () => _i351.GetCachedUserUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.GetTokenUseCase>(
      () => _i351.GetTokenUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.SetCachedUserUseCase>(
      () => _i351.SetCachedUserUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.SetTokenUseCase>(
      () => _i351.SetTokenUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i209.NotificationRepository>(
      () =>
          _i1047.NotificationRepositoryImp(gh<_i529.NotificationDataSource>()),
    );
    gh.factory<_i309.ChatsInboxDatasource>(
      () => _i309.ChatsInboxDatasourceImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i410.MapsRepository>(
      () => _i683.MapsRepositoryImp(
        gh<_i401.MapsDataSource>(),
        gh<_i351.SecureStorageRepository>(),
      ),
    );
    gh.factory<_i630.CartRepository>(
      () => _i933.CartRepositoryImpl(gh<_i690.CartDatasource>()),
    );
    gh.factory<_i607.DeleteCartItemUsecase>(
      () => _i607.DeleteCartItemUsecase(gh<_i630.CartRepository>()),
    );
    gh.factory<_i896.GetCartItemsUsecase>(
      () => _i896.GetCartItemsUsecase(gh<_i630.CartRepository>()),
    );
    gh.factory<_i169.UpdateCartDeliveryFeesUsecase>(
      () => _i169.UpdateCartDeliveryFeesUsecase(gh<_i630.CartRepository>()),
    );
    gh.factory<_i507.UpsertCartItemUsecase>(
      () => _i507.UpsertCartItemUsecase(gh<_i630.CartRepository>()),
    );
    gh.factory<_i439.CanUpdatePhoneUseCase>(
      () => _i439.CanUpdatePhoneUseCase(gh<_i300.AuthenticationRepository>()),
    );
    gh.factory<_i447.DeleteAccountUseCase>(
      () => _i447.DeleteAccountUseCase(gh<_i300.AuthenticationRepository>()),
    );
    gh.factory<_i493.LogInUseCase>(
      () => _i493.LogInUseCase(gh<_i300.AuthenticationRepository>()),
    );
    gh.factory<_i287.LogOutUseCase>(
      () => _i287.LogOutUseCase(gh<_i300.AuthenticationRepository>()),
    );
    gh.factory<_i975.RegisterUseCase>(
      () => _i975.RegisterUseCase(gh<_i300.AuthenticationRepository>()),
    );
    gh.factory<_i400.ResendOtpUseCase>(
      () => _i400.ResendOtpUseCase(gh<_i300.AuthenticationRepository>()),
    );
    gh.factory<_i902.VerifyOtpUseCase>(
      () => _i902.VerifyOtpUseCase(gh<_i300.AuthenticationRepository>()),
    );
    gh.factory<_i262.DeleteCartItemCubit>(
      () => _i262.DeleteCartItemCubit(gh<_i607.DeleteCartItemUsecase>()),
    );
    gh.factory<_i268.AdsDatasource>(
      () => _i268.AdsDatasourceImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i601.UpsertCartItemCubit>(
      () => _i601.UpsertCartItemCubit(gh<_i507.UpsertCartItemUsecase>()),
    );
    gh.factory<_i351.LanguageCacheRepository>(
      () =>
          _i361.LanguageCacheRepositoryImp(gh<_i203.LanguageCacheDateSource>()),
    );
    gh.factory<_i844.GetStatisticsUsecase>(
      () => _i844.GetStatisticsUsecase(gh<_i581.StatisticsRepository>()),
    );
    gh.factory<_i23.GetNotificationsUseCase>(
      () => _i23.GetNotificationsUseCase(gh<_i209.NotificationRepository>()),
    );
    gh.factory<_i630.GetUnreadedNotificationsCountUsecase>(
      () => _i630.GetUnreadedNotificationsCountUsecase(
        gh<_i209.NotificationRepository>(),
      ),
    );
    gh.factory<_i366.MarkAllNotificationsAsReadUseCase>(
      () => _i366.MarkAllNotificationsAsReadUseCase(
        gh<_i209.NotificationRepository>(),
      ),
    );
    gh.factory<_i726.ReadNotificationUseCase>(
      () => _i726.ReadNotificationUseCase(gh<_i209.NotificationRepository>()),
    );
    gh.factory<_i1065.CommonDatasource>(
      () => _i1065.CommonDatasourceImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i646.MenuCommonRepository>(
      () => _i294.MenuCommonRepositoryImp(
        gh<_i758.MenuCommonDatasource>(),
        gh<_i351.SecureStorageRepository>(),
      ),
    );
    gh.factory<_i995.RatingDatasource>(
      () => _i995.RatingDatasourceImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i768.AddressRepository>(
      () => _i711.AddressRepositoryImpl(gh<_i351.DioHelper>()),
    );
    gh.factory<_i740.AdsRepository>(
      () => _i331.AdsRepositoryImpl(gh<_i268.AdsDatasource>()),
    );
    gh.factory<_i268.GetContactUsDataUseCase>(
      () => _i268.GetContactUsDataUseCase(gh<_i646.MenuCommonRepository>()),
    );
    gh.factory<_i573.GetStaticDataUseCase>(
      () => _i573.GetStaticDataUseCase(gh<_i646.MenuCommonRepository>()),
    );
    gh.factory<_i45.SendContactUsMessageUseCase>(
      () => _i45.SendContactUsMessageUseCase(gh<_i646.MenuCommonRepository>()),
    );
    gh.factory<_i1015.ToggleEnableNotificationUseCase>(
      () => _i1015.ToggleEnableNotificationUseCase(
        gh<_i646.MenuCommonRepository>(),
      ),
    );
    gh.factory<_i482.RatingRepository>(
      () => _i665.RatingRepositoryImpl(gh<_i995.RatingDatasource>()),
    );
    gh.factory<_i824.ChatRepository>(
      () => _i394.ChatRepositoryImp(
        gh<_i559.ChatDataSource>(),
        gh<_i351.GetCachedUserUseCase>(),
      ),
    );
    gh.factory<_i84.CartCubit>(
      () => _i84.CartCubit(gh<_i896.GetCartItemsUsecase>()),
    );
    gh.factory<_i104.GetChatInformationUseCase>(
      () => _i104.GetChatInformationUseCase(gh<_i824.ChatRepository>()),
    );
    gh.factory<_i989.GetChatMessagesUseCase>(
      () => _i989.GetChatMessagesUseCase(gh<_i824.ChatRepository>()),
    );
    gh.factory<_i558.SendChatMessageUseCase>(
      () => _i558.SendChatMessageUseCase(gh<_i824.ChatRepository>()),
    );
    gh.factory<_i212.SetChatMessagesAsReadUseCase>(
      () => _i212.SetChatMessagesAsReadUseCase(gh<_i824.ChatRepository>()),
    );
    gh.factory<_i125.CharageWalletUseCase>(
      () => _i125.CharageWalletUseCase(gh<_i46.WalletRepository>()),
    );
    gh.factory<_i321.GetBalanceUseCase>(
      () => _i321.GetBalanceUseCase(gh<_i46.WalletRepository>()),
    );
    gh.factory<_i937.GetWalletHistoryUseCase>(
      () => _i937.GetWalletHistoryUseCase(gh<_i46.WalletRepository>()),
    );
    gh.factory<_i751.WithdrawBalanceUseCase>(
      () => _i751.WithdrawBalanceUseCase(gh<_i46.WalletRepository>()),
    );
    gh.factory<_i582.GetProfileUseCase>(
      () => _i582.GetProfileUseCase(gh<_i931.MoreRepository>()),
    );
    gh.factory<_i87.UpdateProfileUseCase>(
      () => _i87.UpdateProfileUseCase(gh<_i931.MoreRepository>()),
    );
    gh.factory<_i161.GetAllAdsUsecase>(
      () => _i161.GetAllAdsUsecase(gh<_i740.AdsRepository>()),
    );
    gh.factory<_i612.ClientWalletCubit>(
      () => _i612.ClientWalletCubit(
        gh<_i937.GetWalletHistoryUseCase>(),
        gh<_i751.WithdrawBalanceUseCase>(),
        gh<_i321.GetBalanceUseCase>(),
      ),
    );
    gh.factory<_i351.ClearLanguageCacheUseCase>(
      () =>
          _i351.ClearLanguageCacheUseCase(gh<_i351.LanguageCacheRepository>()),
    );
    gh.factory<_i351.GetCachedLanguageUseCase>(
      () => _i351.GetCachedLanguageUseCase(gh<_i351.LanguageCacheRepository>()),
    );
    gh.factory<_i351.GetDeviceLanguageUseCase>(
      () => _i351.GetDeviceLanguageUseCase(gh<_i351.LanguageCacheRepository>()),
    );
    gh.factory<_i351.SetCachedLanguageUseCase>(
      () => _i351.SetCachedLanguageUseCase(gh<_i351.LanguageCacheRepository>()),
    );
    gh.factory<_i656.ClientPersonalProfileCubit>(
      () => _i656.ClientPersonalProfileCubit(
        gh<_i582.GetProfileUseCase>(),
        gh<_i87.UpdateProfileUseCase>(),
      ),
    );
    gh.factory<_i532.GetMapLocationAddressUseCase>(
      () => _i532.GetMapLocationAddressUseCase(gh<_i410.MapsRepository>()),
    );
    gh.factory<_i10.GetMapsPlaceDetailsUseCase>(
      () => _i10.GetMapsPlaceDetailsUseCase(gh<_i410.MapsRepository>()),
    );
    gh.factory<_i659.GetSearchSuggestionsUseCase>(
      () => _i659.GetSearchSuggestionsUseCase(gh<_i410.MapsRepository>()),
    );
    gh.factory<_i904.UpdateUserLocationUseCase>(
      () => _i904.UpdateUserLocationUseCase(gh<_i410.MapsRepository>()),
    );
    gh.factory<_i21.UpdateCartDeliveryFeesCubit>(
      () => _i21.UpdateCartDeliveryFeesCubit(
        gh<_i169.UpdateCartDeliveryFeesUsecase>(),
      ),
    );
    gh.factory<_i34.ChatsInboxRepository>(
      () => _i399.ChatsInboxRepositoryImpl(gh<_i309.ChatsInboxDatasource>()),
    );
    gh.factory<_i165.CharageWalletCubit>(
      () => _i165.CharageWalletCubit(gh<_i125.CharageWalletUseCase>()),
    );
    gh.factory<_i92.CommonRepository>(
      () => _i867.CommonRepositoryImp(gh<_i1065.CommonDatasource>()),
    );
    gh.factory<_i38.DriverStatisticsCubit>(
      () => _i38.DriverStatisticsCubit(gh<_i844.GetStatisticsUsecase>()),
    );
    gh.factory<_i876.ProviderStatisticsCubit>(
      () => _i876.ProviderStatisticsCubit(gh<_i844.GetStatisticsUsecase>()),
    );
    gh.factory<_i303.AddRateUsecase>(
      () => _i303.AddRateUsecase(gh<_i482.RatingRepository>()),
    );
    gh.factory<_i1024.GetRatingsUsecase>(
      () => _i1024.GetRatingsUsecase(gh<_i482.RatingRepository>()),
    );
    gh.factory<_i545.NotificationsCubit>(
      () => _i545.NotificationsCubit(
        gh<_i23.GetNotificationsUseCase>(),
        gh<_i366.MarkAllNotificationsAsReadUseCase>(),
        gh<_i630.GetUnreadedNotificationsCountUsecase>(),
        gh<_i726.ReadNotificationUseCase>(),
      ),
    );
    gh.factory<_i339.AddLocationUseCase>(
      () => _i339.AddLocationUseCase(gh<_i768.AddressRepository>()),
    );
    gh.factory<_i837.DeleteLocationUseCase>(
      () => _i837.DeleteLocationUseCase(gh<_i768.AddressRepository>()),
    );
    gh.factory<_i814.GetAddressesUseCase>(
      () => _i814.GetAddressesUseCase(gh<_i768.AddressRepository>()),
    );
    gh.factory<_i803.UpdateAddressInAddressListuseCase>(
      () => _i803.UpdateAddressInAddressListuseCase(
        gh<_i768.AddressRepository>(),
      ),
    );
    gh.lazySingleton<_i194.GetCurrentLocationUseCase>(
      () => _i194.GetCurrentLocationUseCase(
        gh<_i298.EnableGpsAndHandlePermissionUseCase>(),
        gh<_i532.GetMapLocationAddressUseCase>(),
        gh<_i904.UpdateUserLocationUseCase>(),
      ),
    );
    gh.factory<_i158.RatingsCubit>(
      () => _i158.RatingsCubit(gh<_i1024.GetRatingsUsecase>()),
    );
    gh.factory<_i725.GetBanksUseCase>(
      () => _i725.GetBanksUseCase(gh<_i92.CommonRepository>()),
    );
    gh.factory<_i212.GetCitiesUseCase>(
      () => _i212.GetCitiesUseCase(gh<_i92.CommonRepository>()),
    );
    gh.factory<_i459.GetServicesUseCase>(
      () => _i459.GetServicesUseCase(gh<_i92.CommonRepository>()),
    );
    gh.factory<_i1006.ChangeLanguageUseCase>(
      () => _i1006.ChangeLanguageUseCase(gh<_i92.CommonRepository>()),
    );
    gh.factory<_i170.UpsertAddressCubit>(
      () => _i170.UpsertAddressCubit(
        gh<_i339.AddLocationUseCase>(),
        gh<_i803.UpdateAddressInAddressListuseCase>(),
      ),
    );
    gh.factory<_i779.AdsCubit>(
      () => _i779.AdsCubit(gh<_i161.GetAllAdsUsecase>()),
    );
    gh.factory<_i388.GetChatsInboxUsecase>(
      () => _i388.GetChatsInboxUsecase(gh<_i34.ChatsInboxRepository>()),
    );
    gh.factory<_i583.MyAddressesCubit>(
      () => _i583.MyAddressesCubit(
        gh<_i814.GetAddressesUseCase>(),
        gh<_i837.DeleteLocationUseCase>(),
      ),
    );
    gh.factory<_i295.AddRateCubit>(
      () => _i295.AddRateCubit(gh<_i303.AddRateUsecase>()),
    );
    gh.factory<_i659.ChatsLogCubit>(
      () => _i659.ChatsLogCubit(gh<_i388.GetChatsInboxUsecase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i913.RegisterModule {}
