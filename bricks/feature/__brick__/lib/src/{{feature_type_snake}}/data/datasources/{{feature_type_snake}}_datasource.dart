import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
{{#with_add}}
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_add}}
{{^with_add}}
{{#with_update}}
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_update}}
{{^with_update}}
{{#with_upsert}}
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_upsert}}
{{/with_update}}
{{/with_add}}
{{#get_paginated_data}}
import '../../domain/usecases/{{get_snake}}_{{feature_name.snakeCase()}}_usecase.dart';
{{/get_paginated_data}}
{{#with_toggle_status}}
import '../../domain/usecases/{{toggle_snake}}_{{entity_name.snakeCase()}}_status_usecase.dart';
{{/with_toggle_status}}
{{#with_show}}
import '../models/{{api_model_type_snake}}_details_model.dart';
{{/with_show}}
import '../models/{{api_model_type_snake}}_model.dart';

abstract class {{feature_type_pascal}}Datasource {
  {{#with_add}}
  Future<{{api_model_type_pascal}}Model> {{add_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params);
  {{/with_add}}
  {{^with_add}}
  {{#with_upsert}}
  Future<{{api_model_type_pascal}}Model> {{add_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params);
  {{/with_upsert}}
  {{/with_add}}
  {{#with_update}}
  Future<{{api_model_type_pascal}}Model> {{update_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params);
  {{/with_update}}
  {{^with_update}}
  {{#with_upsert}}
  Future<{{api_model_type_pascal}}Model> {{update_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params);
  {{/with_upsert}}
  {{/with_update}}
  {{#with_show}}
  Future<{{api_model_type_pascal}}DetailsModel> {{show_camel}}{{entity_name.pascalCase()}}Details(int id);
  {{/with_show}}
  {{#get_paginated_data}}
  Future<ApiPaginatedData<{{api_model_type_pascal}}Model>> {{get_camel}}{{feature_name.pascalCase()}}({{get_pascal}}{{feature_name.pascalCase()}}Params params);
  {{/get_paginated_data}}
  {{#get_list_without_pagination}}
  Future<List<{{api_model_type_pascal}}Model>> {{get_list_without_pagination_camel}}{{feature_name.pascalCase()}}(NoParams params);
  {{/get_list_without_pagination}}
  {{#with_delete}}
  Future<String> {{delete_camel}}{{entity_name.pascalCase()}}(int id);
  {{/with_delete}}
  {{#with_toggle_status}}
  Future<String> {{toggle_camel}}{{entity_name.pascalCase()}}Status({{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams params);
  {{/with_toggle_status}}
}

@Injectable(as: {{feature_type_pascal}}Datasource)
class {{feature_type_pascal}}DatasourceImpl extends {{feature_type_pascal}}Datasource {
  final DioHelper _dioHelper;

  {{feature_type_pascal}}DatasourceImpl(this._dioHelper);

  {{#with_add}}
  @override
  Future<{{api_model_type_pascal}}Model> {{add_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) async {
    try {
      final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/{{entity_name.snakeCase()}}')", body: params.toMap);
      return {{api_model_type_pascal}}Model.fromJson(response['data']);
    } catch (_) {
      rethrow;
    }
  }
  {{/with_add}}
  {{^with_add}}
  {{#with_upsert}}
  @override
  Future<{{api_model_type_pascal}}Model> {{add_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) async {
    try {
      final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/{{entity_name.snakeCase()}}')", body: params.toMap);
      return {{api_model_type_pascal}}Model.fromJson(response['data']);
    } catch (_) {
      rethrow;
    }
  }
  {{/with_upsert}}
  {{/with_add}}

  {{#with_delete}}
  @override
  Future<String> {{delete_camel}}{{entity_name.pascalCase()}}(int id) async {
    try {
      final response = await _dioHelper.delete(url: "ApiConstants.addToApiUrlPath('/{{entity_name.snakeCase()}}/$id')");
      return response['message'];
    } catch (_) {
      rethrow;
    }
  }
  {{/with_delete}}

  {{#with_show}}
  @override
  Future<{{api_model_type_pascal}}DetailsModel> {{show_camel}}{{entity_name.pascalCase()}}Details(int id) async {
    try {
      final response = await _dioHelper.get(url: "ApiConstants.addToApiUrlPath('/{{entity_name.snakeCase()}}/$id')");
      return {{api_model_type_pascal}}DetailsModel.fromJson(response['data']);
    } catch (_) {
      rethrow;
    }
  }
  {{/with_show}}

  {{#get_paginated_data}}
  @override
  Future<ApiPaginatedData<{{api_model_type_pascal}}Model>> {{get_camel}}{{feature_name.pascalCase()}}({{get_pascal}}{{feature_name.pascalCase()}}Params params) async {
    try {
      final response = await _dioHelper.get(url: "ApiConstants.addToApiUrlPath('/{{entity_name.snakeCase()}}')", queryParameters: params.toMap);
      final data = ApiPaginatedData<{{api_model_type_pascal}}Model>.fromJson(
        response['data'],
        getData: (dataList) => dataList.map((e) => {{api_model_type_pascal}}Model.fromJson(e)).toList(),
      );
      return data;
    } catch (_) {
      rethrow;
    }
  }
  {{/get_paginated_data}}

  {{#get_list_without_pagination}}
  @override
  Future<List<{{api_model_type_pascal}}Model>> {{get_list_without_pagination_camel}}{{feature_name.pascalCase()}}(NoParams params) async {
    try {
      final response = await _dioHelper.get(
        url: "ApiConstants.addToApiUrlPath('/{{entity_name.snakeCase()}}')",
        queryParameters: {'page': 0, 'limit': 0},
      );
      final rawList = (response['data']?['data'] as List<dynamic>? ?? const <dynamic>[]);
      final List<{{api_model_type_pascal}}Model> data =
          rawList.map((e) => {{api_model_type_pascal}}Model.fromJson(e)).toList();
      return data;
    } catch (_) {
      rethrow;
    }
  }
  {{/get_list_without_pagination}}

  {{#with_update}}
  @override
  Future<{{api_model_type_pascal}}Model> {{update_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) async {
    try {
      final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/reps/${params.id}')", body: params.toMap);
      return {{api_model_type_pascal}}Model.fromJson(response['data']);
    } catch (_) {
      rethrow;
    }
  }
  {{/with_update}}
  {{^with_update}}
  {{#with_upsert}}
  @override
  Future<{{api_model_type_pascal}}Model> {{update_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) async {
    try {
      final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/reps/${params.id}')", body: params.toMap);
      return {{api_model_type_pascal}}Model.fromJson(response['data']);
    } catch (_) {
      rethrow;
    }
  }
  {{/with_upsert}}
  {{/with_update}}

  {{#with_toggle_status}}
  @override
  Future<String> {{toggle_camel}}{{entity_name.pascalCase()}}Status({{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams params) async {
    try {
      switch (params.toggleAction) {
        case {{entity_name.pascalCase()}}StatusToggleActionEnum.makeAsSold:
          final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/ads/mark-as-sold/${params.id}')");
          return response['message'];
        case {{entity_name.pascalCase()}}StatusToggleActionEnum.pay:
          final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/ads/pay/${params.id}', body: params.toMap)");
          return response['message'];
        case {{entity_name.pascalCase()}}StatusToggleActionEnum.cancel:
          final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/ads/expire/${params.id}')");
          return response['message'];
        case {{entity_name.pascalCase()}}StatusToggleActionEnum.favorite:
          final response = await _dioHelper.post(url: "ApiConstants.addToApiUrlPath('/ads/${params.id}/favorite')");
          return response['message'];
      }
    } catch (_) {
      rethrow;
    }
  }
  {{/with_toggle_status}}
}

