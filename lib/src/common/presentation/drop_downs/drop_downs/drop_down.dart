import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/theme/app_theme.dart';
import '../../../../../core/core.dart';
import '../../../../../material/app_fail_widget.dart';
import '../../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../../material/spin_kit_loading_widget.dart';
import 'drop_down_cubit.dart';

part 'widgets/search_field.dart';

class AppSingleDropDown<T> extends StatelessWidget {
  const AppSingleDropDown({
    super.key,
    required this.controller,
    this.onChanged,
    required this.itemDisplay,
    this.hint = "",
    required this.title,
    this.items = const [],
    this.prefixIc,
    this.prefixIcColor,
    this.cubit,
    this.maxAllowedSelectCount = 1,
    this.validator,
    this.isEnabled = true,
    this.hasRequiredSymbol = false,
  });

  final ValidatorFieldController<T?> controller;
  final void Function(T? value)? onChanged;
  final String? Function(T? displayValue) itemDisplay;
  final String hint;
  final String title;
  final List<T> items;
  final String? prefixIc;
  final Color? prefixIcColor;
  final DropDownCubit<T>? cubit;
  final int maxAllowedSelectCount;
  final String? Function(T? value)? validator;
  final bool isEnabled;
  final bool hasRequiredSymbol;

  @override
  Widget build(BuildContext _) {
    final heroTag = UniqueKey();
    return BlocProvider(
      create: (context) => cubit ?? (DefaultDropDownCubit<T>()..setData(items)),
      child: ValidatorField<T?>(
        controller: controller,
        onSaved: onChanged,
        validator:
            validator ??
            (value) {
              if (value == null || value == '') {
                return appLocalizer.fieldRequired;
              }
              return null;
            },
        build: (context, errorMessage, hasError, value) {
          return DefaultInputFieldDesign(
            heroTag: heroTag,
            hasRequiredSymbol: hasRequiredSymbol,
            prefixIconPath: prefixIc,
            prefixIcColor: prefixIcColor,
            suffixIconPath: "",
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              if (isEnabled == false) {
                controller.validate();
                return;
              }
              Navigator.of(context).push(
                _AppDropDownRoute<T>(
                  child: BlocProvider.value(
                    value: context.read<DropDownCubit<T>>(),
                    child: _AppDropDownOverlay<T>(
                      maxAllowedSelectCount: maxAllowedSelectCount,
                      prefixIc: prefixIc,
                      items: items,
                      hero: heroTag,
                      itemDisplay: itemDisplay,
                      onPressed: (context, result, animationController) {
                        if (result != null && result != value) {
                          controller.setValue(result);
                          if (!animationController.isAnimating) {
                            animationController.reverse().then((_) {
                              Navigator.of(context).pop();
                            });
                          }
                          controller.save();
                          controller.validate();
                        }
                      },
                      selectedValue: value == null ? <T>[] : [value],
                    ),
                  ),
                ),
              );
            },
            title: title,
            hasError: hasError,
            hint: hint,
            value: value == null ? null : itemDisplay(value),
            errorMessage: errorMessage ?? '',
          );
        },
      ),
    );
  }
}

// class AppMultiDropDown<T> extends StatelessWidget {
//   const AppMultiDropDown({
//     super.key,
//     required this.value,
//     this.onChanged,
//     required this.itemDisplay,
//     this.hint = "",
//     required this.title,
//     this.items = const [],
//     this.prefixIc,
//     this.cubit,
//     this.validator,
//     this.isEnabled = true,
//     this.filterWhere,
//     this.hasRequiredSymbol = false,
//   });

//   final List<T> value;
//   final void Function(List<T> value)? onChanged;
//   final String? Function(T? displayValue) itemDisplay;
//   final String hint;
//   final String title;
//   final List<T> items;
//   final String? prefixIc;
//   final DropDownCubit<T>? cubit;
//   final String? Function(List<T>? value)? validator;
//   final bool isEnabled;
//   final bool Function(T element)? filterWhere;
//   final bool hasRequiredSymbol;

//   @override
//   Widget build(BuildContext _) {
//     final heroTag = UniqueKey();
//     final validator = this.validator ??
//         (value) {
//           if ((value?.isEmpty ?? false)) return appLocalizer.fieldRequired;
//           return null;
//         };
//     return BlocProvider(
//       create: (context) => cubit ?? (DefaultDropDownCubit<T>()..setData(items)),
//       child: ValidatorField<List<T>>(
//         value: value,
//         onSaved: (newValue) => onChanged?.call(newValue ?? []),
//         validator: validator,
//         build: (
//           context,
//           hasError,
//           errorMessage,
//           value,
//           onChange,
//           onSave,
//           validate,
//         ) {
//           final List<T> data = List<T>.from(value ?? []);
//           final String dataString = data.map((e) => itemDisplay(e)).join(' , ');

//           return DefaultInputFieldDesign(
//             heroTag: heroTag,
//             prefixIconPath: prefixIc,
//             // suffixIconPath: AppIcons.arrowDownIc,
//             hasRequiredSymbol: hasRequiredSymbol,
//             onTap: () async {
//               if (isEnabled == false) {
//                 validate();
//                 return;
//               }

//               // if (hasError) return;
//               FocusScope.of(context).requestFocus(FocusNode());

//               Navigator.of(
//                 context,
//                 rootNavigator: true,
//               ).push(
//                 _AppDropDownRoute<T>(
//                   child: BlocProvider.value(
//                     value: context.read<DropDownCubit<T>>(),
//                     child: _AppDropDownOverlay<T>(
//                       maxAllowedSelectCount: 15,
//                       hero: heroTag,
//                       prefixIc: prefixIc,
//                       items: items,
//                       itemDisplay: itemDisplay,
//                       filterWhere: filterWhere,
//                       onPressed: (context, result, _) {
//                         if (result != null && result != value) {
//                           final bool isSelected = data.contains(result);
//                           if (isSelected) {
//                             data.remove(result);
//                           } else {
//                             data.add(result);
//                           }
//                           onChange(data);
//                           onSave();
//                         }
//                       },
//                       selectedValue: data,
//                     ),
//                   ),
//                 ),
//               );
//             },
//             title: title,
//             hasError: hasError,
//             hint: hint,
//             value: data.isEmpty ? null : dataString,
//             errorMessage: errorMessage ?? '',
//           );
//         },
//       ),
//     );
//   }
// }

class _AppDropDownOverlay<T> extends StatefulWidget {
  static const String routeName = 'AppDropDownOverlay';

  final List<T> items;
  final List<T> selectedValue;
  final String? Function(T? displayValue) itemDisplay;
  final String? prefixIc;
  final int maxAllowedSelectCount;
  final bool Function(T element)? filterWhere;
  final void Function(BuildContext context, T? value, AnimationController controller) onPressed;
  final Object hero;
  const _AppDropDownOverlay({
    required this.items,
    required this.selectedValue,
    required this.itemDisplay,
    required this.onPressed,
    this.prefixIc,
    this.maxAllowedSelectCount = 1,
    required this.hero,
    this.filterWhere,
  });

  @override
  State<_AppDropDownOverlay<T>> createState() => _AppDropDownOverlayState<T>();
}

class _AppDropDownOverlayState<T> extends State<_AppDropDownOverlay<T>> with TickerProviderStateMixin {
  late final AnimationController _contentController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = CurvedAnimation(parent: _contentController, curve: Curves.easeOutBack);

    // Start after hero animation finishes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 150), () {
        _contentController.forward();
      });
    });
    context.read<DropDownCubit<T>>().fetch();
    selectedValues.addAll(widget.selectedValue);
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  final List<T> selectedValues = <T>[];
  String? searchText;

  bool get _canSelectMore => selectedValues.length < widget.maxAllowedSelectCount;

  bool get popOnSelect => widget.maxAllowedSelectCount == 1;

  bool get isDataLoadSuccess => context.read<DropDownCubit<T>>().state.isSuccess;

  List<T> get items => (context.read<DropDownCubit<T>>().state.data) ?? <T>[];

  List<T> get getSortedItems {
    return items;
    // final data = List<T>.from(items);
    // data.sort((a, b) {
    //   final bool aSelected = selectedValues.contains(a);
    //   final bool bSelected = selectedValues.contains(b);

    //   if (aSelected && !bSelected) return -1;
    //   if (!aSelected && bSelected) return 1;
    //   return 0;
    // });
    // return data;
  }

  List<T> get getFilteredItems {
    final data = List<T>.from(getSortedItems);

    if (widget.filterWhere != null) {
      data.removeWhere(widget.filterWhere!);
    }

    if (searchText?.isEmpty == true || searchText == null) {
      return data;
    } else if (searchText?.isNotEmpty == true && searchText != null) {
      return data.where((element) => (widget.itemDisplay(element) ?? '').toLowerCase().contains(searchText!.toLowerCase())).toList();
    }

    return data;
  }

  void onSelected(T selectedValue) async {
    final bool isSelected = selectedValues.contains(selectedValue);
    if (isSelected) {
      selectedValues.remove(selectedValue);
    } else {
      if (!_canSelectMore && popOnSelect) {
        widget.onPressed(context, selectedValue, _contentController);
        return;
      }

      selectedValues.add(selectedValue);
    }

    widget.onPressed(context, selectedValue, _contentController);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DropDownCubit<T>, Async<List<T>>>(
      listener: (context, state) {
        if (state.isSuccess) {
          setState(() {});
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (!_contentController.isAnimating) {
                  _contentController.reverse().then((_) {
                    final currentRoute = AppRouter.getCurrentRoute;
                    if (currentRoute == _AppDropDownOverlay.routeName) {
                      Navigator.of(context).pop();
                    }
                  });
                }
              },
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                      child: Hero(
                        tag: widget.hero,
                        child: Material(
                          color: Colors.transparent,
                          clipBehavior: Clip.antiAlias,
                          child: IgnorePointer(
                            ignoring: !isDataLoadSuccess,
                            child: _SearchField(
                              prefixIcon: widget.prefixIc,
                              onSearch: (searchKey) {
                                setState(() {
                                  searchText = searchKey;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 24, right: 20, left: 20),
                        clipBehavior: Clip.antiAlias,
                        constraints: BoxConstraints(minHeight: 200, minWidth: MediaQuery.of(context).size.width),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [AppColors.boxShadow],
                        ),
                        child: SingleChildScrollView(
                          clipBehavior: Clip.antiAlias,
                          child: BlocBuilder<DropDownCubit<T>, Async<List<T>>>(
                            builder: (context, state) {
                              // final data = state.data ?? [];

                              if (state.isLoading) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 60),
                                  child: SpinKitLoadingWidget(size: 20, color: AppColors.primary),
                                );
                              } else if (state.isFailure) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 60),
                                  child: AppFailWidget.mini(
                                    onRetry: () {
                                      context.read<DropDownCubit<T>>().fetch();
                                    },
                                  ),
                                );
                              } else if (state.isSuccess && getFilteredItems.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: Text(
                                      appLocalizer.noResultFound,
                                      style: TextStyles.semiBold12.copyWith(color: AppColors.textColor),
                                    ),
                                  ),
                                );
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: getFilteredItems.map((option) {
                                  final bool isSelected = selectedValues.contains(option);
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: AnimatedContainer(
                                      clipBehavior: Clip.antiAlias,
                                      width: double.infinity,
                                      duration: Durations.medium1,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? getThemeColor(darkColor: AppColors.blue50.withAlpha(20), lightColor: AppColors.blue50)
                                            : null,
                                      ),
                                      child: _HighlightText(text: widget.itemDisplay(option) ?? '', searchText: searchText ?? ''),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppDropDownRoute<T> extends PageRoute<T> {
  final Widget child;

  _AppDropDownRoute({required this.child});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black26;

  @override
  String get barrierLabel => 'Dismiss';

  @override
  RouteSettings get settings => const RouteSettings(name: _AppDropDownOverlay.routeName);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  bool get maintainState => true;
}

class _HighlightText extends StatelessWidget {
  final String text;
  final String searchText;

  const _HighlightText({required this.text, required this.searchText});

  TextStyle get _highlightStyle => TextStyles.bold12.copyWith(color: AppColors.textColor);
  TextStyle get _normalStyle => TextStyles.light12.copyWith(color: AppColors.primary400);

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(children: highlightSearchText(text, searchText)));
  }

  List<TextSpan> highlightSearchText(String text, String searchText) {
    if (searchText.isEmpty) {
      return [TextSpan(text: text, style: _normalStyle)];
    }

    final List<TextSpan> spans = [];
    final String lowerText = text.toLowerCase();
    final String lowerSearchText = searchText.toLowerCase();

    int start = 0;
    int index = lowerText.indexOf(lowerSearchText);

    while (index != -1) {
      // Add normal text before the match
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index), style: _normalStyle));
      }

      // Add the highlighted search text
      spans.add(TextSpan(text: text.substring(index, index + searchText.length), style: _highlightStyle));

      // Move past the matched text
      start = index + searchText.length;
      index = lowerText.indexOf(lowerSearchText, start);
    }

    // Add any remaining text after the last match
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: _normalStyle));
    }

    return spans;
  }
}
