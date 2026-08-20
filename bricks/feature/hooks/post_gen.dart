import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  final withAdd = context.vars['with_add'] as bool? ?? false;
  final withUpdate = context.vars['with_update'] as bool? ?? false;
  final withUpsert = context.vars['with_upsert'] as bool? ?? false;
  final withDelete = context.vars['with_delete'] as bool? ?? false;
  final withGet = context.vars['get_paginated_data'] as bool? ?? false;
  final getListWithoutPagination =
      context.vars['get_list_without_pagination'] as bool? ?? false;
  final withAnyGetPresentation = withGet || getListWithoutPagination;
  final withShow = context.vars['with_show'] as bool? ?? false;
  final withToggleStatus = context.vars['with_toggle_status'] as bool? ?? false;
  final featureName =
      (context.vars['feature_name'] as String?)?.snakeCase ?? '';
  final featureTypeSnake =
      (context.vars['feature_type_snake'] as String?) ?? featureName;
  final entityName = (context.vars['entity_name'] as String?)?.snakeCase ?? '';
  final addSnake = (context.vars['add_snake'] as String?) ?? 'add';
  final updateSnake = (context.vars['update_snake'] as String?) ?? 'update';
  final upsertSnake = (context.vars['upsert_snake'] as String?) ?? 'upsert';
  final getSnake = (context.vars['get_snake'] as String?) ?? 'get';
  final getListWithoutPaginationSnake =
      (context.vars['get_list_without_pagination_snake'] as String?) ??
          'get_all';
  final activeGetSnake =
      (context.vars['active_get_snake'] as String?) ?? getSnake;
  final showSnake = (context.vars['show_snake'] as String?) ?? 'show';
  final toggleSnake = (context.vars['toggle_snake'] as String?) ?? 'toggle';
  final deleteSnake = (context.vars['delete_snake'] as String?) ?? 'delete';
  final entityTypeSnake =
      (context.vars['entity_type_snake'] as String?) ?? entityName;
  final apiModelTypeSnake = (context.vars['api_model_type_snake'] as String?) ??
      'api_$entityTypeSnake';
  if (featureTypeSnake.isEmpty || entityName.isEmpty) return;

  if (!withDelete) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/domain/usecases/${deleteSnake}_${entityName}_usecase.dart',
      'lib/src/$featureTypeSnake/presentation/${deleteSnake}_${entityName}/${deleteSnake}_${entityName}_bottom_sheet.dart',
      'lib/src/$featureTypeSnake/presentation/${deleteSnake}_${entityName}/${deleteSnake}_${entityName}_cubit.dart',
      'lib/src/$featureTypeSnake/presentation/${deleteSnake}_${entityName}/${deleteSnake}_${entityName}_state.dart',
    ]);

    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/${deleteSnake}_${entityName}');
  }

  if (!withShow) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/data/models/${apiModelTypeSnake}_details_model.dart',
      'lib/src/$featureTypeSnake/domain/entities/${entityTypeSnake}_details_entity.dart',
      'lib/src/$featureTypeSnake/domain/usecases/${showSnake}_${entityName}_details_usecase.dart',
      'lib/src/$featureTypeSnake/presentation/${showSnake}_${entityName}_details/${showSnake}_${entityName}_details_page.dart',
      'lib/src/$featureTypeSnake/presentation/${showSnake}_${entityName}_details/${showSnake}_${entityName}_details_cubit.dart',
      'lib/src/$featureTypeSnake/presentation/${showSnake}_${entityName}_details/${showSnake}_${entityName}_details_state.dart',
      'lib/src/$featureTypeSnake/presentation/${showSnake}_${entityName}_details/utils/${showSnake}_${entityName}_details_subscription.dart',
    ]);

    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/${showSnake}_${entityName}_details/utils');
    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/${showSnake}_${entityName}_details');
  }

  if (!withGet) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/domain/usecases/${getSnake}_${featureName}_usecase.dart'
    ]);
  }

  if (!withAnyGetPresentation) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/${featureTypeSnake}_cubit.dart',
      'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/${featureTypeSnake}_state.dart',
      'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/${featureTypeSnake}_page.dart',
      'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/widgets/${entityName}_card.dart',
      'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/widgets/${featureTypeSnake}_filter_bottomsheet.dart',
      'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/utils/${activeGetSnake}_${featureName}_subscription.dart',
    ]);

    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/widgets');
    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/utils');
    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/$featureTypeSnake');
  }

  if (!withGet) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/presentation/$featureTypeSnake/widgets/${featureTypeSnake}_filter_bottomsheet.dart'
    ]);
  }

  if (!getListWithoutPagination) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/domain/usecases/${getListWithoutPaginationSnake}_${featureName}_usecase.dart'
    ]);
  }

  if (!withAdd) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/presentation/${addSnake}_${entityName}/${addSnake}_${entityName}_page.dart',
      'lib/src/$featureTypeSnake/presentation/${addSnake}_${entityName}/${addSnake}_${entityName}_cubit.dart',
      'lib/src/$featureTypeSnake/presentation/${addSnake}_${entityName}/${addSnake}_${entityName}_state.dart',
    ]);

    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/${addSnake}_${entityName}');
  }

  if (!withUpdate) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/presentation/${updateSnake}_${entityName}/${updateSnake}_${entityName}_page.dart',
      'lib/src/$featureTypeSnake/presentation/${updateSnake}_${entityName}/${updateSnake}_${entityName}_cubit.dart',
      'lib/src/$featureTypeSnake/presentation/${updateSnake}_${entityName}/${updateSnake}_${entityName}_state.dart',
    ]);

    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/${updateSnake}_${entityName}');
  }

  if (!withUpsert) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/presentation/${upsertSnake}_${entityName}/${upsertSnake}_${entityName}_page.dart',
      'lib/src/$featureTypeSnake/presentation/${upsertSnake}_${entityName}/${upsertSnake}_${entityName}_cubit.dart',
      'lib/src/$featureTypeSnake/presentation/${upsertSnake}_${entityName}/${upsertSnake}_${entityName}_state.dart',
    ]);

    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/${upsertSnake}_${entityName}');
  }

  if (!withAdd && !withUpdate && !withUpsert) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/domain/usecases/${addSnake}_${entityName}_usecase.dart'
    ]);
  }

  if (!withUpdate && !withUpsert) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/domain/usecases/${updateSnake}_${entityName}_usecase.dart'
    ]);
  }

  if (!withToggleStatus) {
    _deleteFiles(<String>[
      'lib/src/$featureTypeSnake/domain/usecases/${toggleSnake}_${entityName}_status_usecase.dart',
      'lib/src/$featureTypeSnake/presentation/${toggleSnake}_${entityName}_status/${toggleSnake}_${entityName}_status_cubit.dart',
      'lib/src/$featureTypeSnake/presentation/${toggleSnake}_${entityName}_status/${toggleSnake}_${entityName}_status_state.dart',
    ]);

    _deleteDirectoryIfEmpty(
        'lib/src/$featureTypeSnake/presentation/${toggleSnake}_${entityName}_status');
  }

  _formatGeneratedFiles(context, 'lib/src/$featureTypeSnake');
}

void _deleteFiles(List<String> relativePaths) {
  for (final relativePath in relativePaths) {
    final file = File(relativePath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}

void _deleteDirectoryIfEmpty(String relativePath) {
  final directory = Directory(relativePath);
  if (directory.existsSync() && directory.listSync().isEmpty) {
    directory.deleteSync();
  }
}

void _formatGeneratedFiles(HookContext context, String relativePath) {
  if (!Directory(relativePath).existsSync()) {
    context.logger.warn('Skipped dart format: `$relativePath` was not found.');
    return;
  }

  final command = 'dart format $relativePath';
  final progress = context.logger.progress('Running $command');
  final result =
      Process.runSync('dart', ['format', relativePath], runInShell: true);
  final stdout = '${result.stdout}'.trim();
  final stderr = '${result.stderr}'.trim();

  if (result.exitCode == 0) {
    progress.complete(stdout.isEmpty ? 'Formatted generated files.' : stdout);
    return;
  }

  progress.fail('$command failed.');
  if (stdout.isNotEmpty) context.logger.info(stdout);
  if (stderr.isNotEmpty) context.logger.err(stderr);
  throw Exception('$command failed with exit code ${result.exitCode}.');
}
