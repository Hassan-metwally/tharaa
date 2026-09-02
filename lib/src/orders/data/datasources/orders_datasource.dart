import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/usecases/add_order_usecase.dart';
import '../../domain/usecases/apply_checkout_coupon_usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/preview_checkout_usecase.dart';
import '../../domain/usecases/toggle_order_status_usecase.dart';

import '../models/api_checkout_preview_model.dart';
import '../models/api_order_details_model.dart';
import '../models/api_order_model.dart';

abstract class OrdersDatasource {
  Future<ApiOrderDetailsModel> showOrderDetails(int id);

  Future<ApiPaginatedData<ApiOrderModel>> getOrders(GetOrdersParams params);

  Future<String> toggleOrderStatus(ToggleOrderStatusParams params);

  Future<ApiCheckoutPreviewModel> previewCheckout(PreviewCheckoutParams params);

  Future<ApiCheckoutPreviewModel> applyCheckoutCoupon(ApplyCheckoutCouponParams params);

  Future<ApiOrderModel> addOrder(UpsertOrderParams params);
}

@Injectable(as: OrdersDatasource)
class OrdersDatasourceImpl extends OrdersDatasource {
  final DioHelper _dioHelper;

  OrdersDatasourceImpl(this._dioHelper);

  @override
  Future<ApiOrderDetailsModel> showOrderDetails(int id) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('orders/$id'));
      return ApiOrderDetailsModel.fromJson(response['data']);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiPaginatedData<ApiOrderModel>> getOrders(GetOrdersParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('orders'), queryParameters: params.toMap);
      final data = ApiPaginatedData<ApiOrderModel>.fromJson(
        response['data'],
        getData: (dataList) => dataList.map((e) => ApiOrderModel.fromJson(e)).toList(),
      );
      return data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> toggleOrderStatus(ToggleOrderStatusParams params) async {
    try {
      switch (params.toggleAction) {
        case OrderStatusToggleActionEnum.makeAsSold:
          final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/ads/mark-as-sold/${params.id}')");
          return response['message'];
        case OrderStatusToggleActionEnum.pay:
          final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/ads/pay/${params.id}', body: params.toMap)");
          return response['message'];
        case OrderStatusToggleActionEnum.cancel:
          final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/ads/expire/${params.id}')");
          return response['message'];
        case OrderStatusToggleActionEnum.favorite:
          final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/ads/${params.id}/favorite')");
          return response['message'];
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiCheckoutPreviewModel> previewCheckout(PreviewCheckoutParams params) async {
    try {
      final response = await _dioHelper.post(
        url: ApiConstants.addToApiUrlPath('checkout/preview'),
        body: params.toMap,
      );
      return ApiCheckoutPreviewModel.fromJson(response['data'] as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiCheckoutPreviewModel> applyCheckoutCoupon(ApplyCheckoutCouponParams params) async {
    try {
      final response = await _dioHelper.post(
        url: ApiConstants.addToApiUrlPath('checkout/apply-coupon'),
        body: params.toMap,
      );
      return ApiCheckoutPreviewModel.fromJson(response['data'] as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiOrderModel> addOrder(UpsertOrderParams params) async {
    try {
      final response = await _dioHelper.post(
        url: ApiConstants.addToApiUrlPath('checkout/place'),
        body: params.toMap,
      );
      final data = response['data'] as Map<String, dynamic>;
      return ApiOrderModel.fromJson(data['order'] as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }
}
