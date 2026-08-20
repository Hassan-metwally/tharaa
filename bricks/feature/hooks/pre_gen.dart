import 'package:mason/mason.dart';

void run(HookContext context) {
  final withFlavour = context.vars['with_flavour'] as bool? ?? false;
  final withGet = context.vars['get_paginated_data'] as bool? ?? false;
  final withGetListWithoutPagination =
      context.vars['get_list_without_pagination'] as bool? ?? false;
  var flavourName = '';
  if (withFlavour) {
    final presetFlavourName =
        (context.vars['flavour_name'] as String?)?.trim() ?? '';
    if (presetFlavourName.isNotEmpty) {
      flavourName = presetFlavourName;
    } else {
      while (flavourName.isEmpty) {
        flavourName =
            context.logger.prompt('Flavour name (e.g. client)').trim();
        if (flavourName.isEmpty) {
          context.logger
              .warn('`flavour_name` is required when `with_flavour` is true.');
        }
      }
    }
  }

  final flavourSnake = flavourName.snakeCase;
  final flavourCamel = flavourName.camelCase;
  final flavourPascal = flavourName.pascalCase;
  final featureNameSnake =
      (context.vars['feature_name'] as String?)?.snakeCase ?? '';
  final featureNamePascal =
      (context.vars['feature_name'] as String?)?.pascalCase ?? '';
  final entityNameSnake =
      (context.vars['entity_name'] as String?)?.snakeCase ?? '';
  final entityNamePascal =
      (context.vars['entity_name'] as String?)?.pascalCase ?? '';

  String operationSnake(String operation) =>
      flavourSnake.isEmpty ? operation : '${flavourSnake}_$operation';

  String operationCamel(String operation) {
    final operationPascal = operation.pascalCase;
    return flavourCamel.isEmpty
        ? operation.camelCase
        : '$flavourCamel$operationPascal';
  }

  String operationPascal(String operation) {
    final capitalizedOperation = operation.pascalCase;
    return flavourPascal.isEmpty
        ? capitalizedOperation
        : '$flavourPascal$capitalizedOperation';
  }

  void setOperationVars(String key, String operation) {
    context.vars['${key}_snake'] = operationSnake(operation);
    context.vars['${key}_camel'] = operationCamel(operation);
    context.vars['${key}_pascal'] = operationPascal(operation);
  }

  context.vars['flavour_name'] = flavourName;
  context.vars['flavour_prefix'] =
      flavourSnake.isEmpty ? '' : '${flavourSnake}_';

  context.vars['feature_type_snake'] = flavourSnake.isEmpty
      ? featureNameSnake
      : '${flavourSnake}_$featureNameSnake';
  context.vars['feature_type_pascal'] = flavourPascal.isEmpty
      ? featureNamePascal
      : '$flavourPascal$featureNamePascal';
  context.vars['entity_type_snake'] = flavourSnake.isEmpty
      ? entityNameSnake
      : '${flavourSnake}_$entityNameSnake';
  context.vars['entity_type_pascal'] = flavourPascal.isEmpty
      ? entityNamePascal
      : '$flavourPascal$entityNamePascal';
  context.vars['api_model_type_snake'] = flavourSnake.isEmpty
      ? 'api_$entityNameSnake'
      : '${flavourSnake}_api_$entityNameSnake';
  context.vars['api_model_type_pascal'] = flavourPascal.isEmpty
      ? 'Api$entityNamePascal'
      : '${flavourPascal}Api$entityNamePascal';

  setOperationVars('add', 'add');
  setOperationVars('update', 'update');
  setOperationVars('upsert', 'upsert');
  setOperationVars('get', 'get');
  setOperationVars('get_list_without_pagination', 'get_all');
  setOperationVars('show', 'show');
  setOperationVars('toggle', 'toggle');
  setOperationVars('delete', 'delete');

  final activeGetKey = withGet
      ? 'get'
      : withGetListWithoutPagination
          ? 'get_list_without_pagination'
          : 'get';
  context.vars['with_any_get_presentation'] =
      withGet || withGetListWithoutPagination;
  context.vars['active_get_is_paginated'] = withGet;
  context.vars['active_get_snake'] = context.vars['${activeGetKey}_snake'];
  context.vars['active_get_camel'] = context.vars['${activeGetKey}_camel'];
  context.vars['active_get_pascal'] = context.vars['${activeGetKey}_pascal'];
}
