import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/app_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/place_suggestion_entity.dart';
import 'maps_search_cubit.dart';

part "../widgets/search_app_bar_widget.dart";

class MapsSearchPage extends StatelessWidget {
  const MapsSearchPage({super.key, this.initialAddress});
  final MapAddressEntity? initialAddress;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => MapsSearchCubit(), child: _MapsSearchPageBody(initialAddress));
  }
}

class _MapsSearchPageBody extends StatefulWidget {
  const _MapsSearchPageBody(this.initialAddress);
  final MapAddressEntity? initialAddress;

  @override
  State<_MapsSearchPageBody> createState() => _MapsSearchPageBodyState();
}

class _MapsSearchPageBodyState extends State<_MapsSearchPageBody> {
  final _searchController = TextEditingController();
  Timer? debounceTimer;

  @override
  void initState() {
    if (widget.initialAddress != null) {
      _searchController.text = widget.initialAddress?.address ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapsSearchCubit, MapsSearchState>(
      listenWhen: (previous, current) => previous.getPlaceLocationState != current.getPlaceLocationState,
      listener: (context, state) {
        if (state.getPlaceLocationState.isSuccess) {
          Navigator.of(context).pop(state.getPlaceLocationState.data);
        } else if (state.getPlaceLocationState.isFailure) {
          AppToasts.error(context, message: appLocalizer.failedToGetLocationDetails);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            _MapsSearchAppBarWidget(
              searchController: _searchController,
              onChange: (text) {
                debounceTimer?.cancel();
                debounceTimer = null;
                debounceTimer = Timer.periodic(const Duration(milliseconds: 750), (timer) {
                  MapsSearchCubit.of(context).getSearchSuggestions(text ?? '');

                  debounceTimer?.cancel();
                  debounceTimer = null;
                });
              },
            ),
            Expanded(
              child: BlocBuilder<MapsSearchCubit, MapsSearchState>(
                builder: (context, state) {
                  if (state.suggestionState.isSuccess) {
                    final suggestionsList = state.suggestionState.data ?? [];
                    if (suggestionsList.isEmpty) {
                      return Center(
                        child: Text(
                          appLocalizer.noResultFound,
                          textAlign: TextAlign.center,
                          style: TextStyles.bold14.copyWith(color: AppColors.black600),
                        ),
                      );
                    }
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final currentPlace = suggestionsList[index];
                        return InkWell(
                          onTap: () {
                            MapsSearchCubit.of(context).getPlaceLocation(currentPlace.placeId);
                          },
                          child: _SuggestionItem(entity: currentPlace, isFirst: index == 0, isLast: index == suggestionsList.length - 1),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 2),
                      itemCount: suggestionsList.length,
                    );
                  } else if (state.suggestionState.isFailure) {
                    return AppFailWidget(
                      onRetry: () {
                        MapsSearchCubit.of(context).getSearchSuggestions(_searchController.text);
                      },
                    );
                  } else if (state.suggestionState.isLoading) {
                    return const AppLoadingWidget();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    debounceTimer?.cancel();
    debounceTimer = null;
    _searchController.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }
}

class _SuggestionItem extends StatelessWidget {
  const _SuggestionItem({required this.entity, required this.isFirst, required this.isLast});
  final MapPlaceSuggestionsEntity entity;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isFirst && isLast == false
            ? const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
            : isLast && isFirst == false
            ? const BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))
            : BorderRadius.circular(0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: AppColors.black800, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text.rich(TextSpan(children: _highlightEnteredText(entity)))),
          BlocBuilder<MapsSearchCubit, MapsSearchState>(
            buildWhen: (previous, current) => previous.currentFetchedTappedPlaceID != current.currentFetchedTappedPlaceID,
            builder: (context, state) {
              if (state.currentFetchedTappedPlaceID.data == entity.placeId) {
                return SizedBox(height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 4, color: AppColors.primary));
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  List<TextSpan> _highlightEnteredText(MapPlaceSuggestionsEntity placeSuggestionsEntity) {
    const TextStyle regularTextStyle = TextStyles.regular15;
    const TextStyle highlightedTextStyle = TextStyles.semiBold15;
    final List<TextSpan> textSpans = [];

    int currentIndex = 0;

    for (int i = 0; i < placeSuggestionsEntity.matchedSubstrings.length; i++) {
      final int offset = placeSuggestionsEntity.matchedSubstrings[i].offset;
      final int length = placeSuggestionsEntity.matchedSubstrings[i].length;

      // Add non-highlighted text
      if (currentIndex < offset) {
        final nonHighlightedText = placeSuggestionsEntity.description.substring(currentIndex, offset);
        textSpans.add(TextSpan(text: nonHighlightedText, style: regularTextStyle));
        currentIndex = offset;
      }

      // Add highlighted text
      final highlightedText = placeSuggestionsEntity.description.substring(offset, offset + length);
      textSpans.add(TextSpan(text: highlightedText, style: highlightedTextStyle));
      currentIndex = offset + length;
    }

    // Add remaining non-highlighted text if any
    if (currentIndex < placeSuggestionsEntity.description.length) {
      final remainingText = placeSuggestionsEntity.description.substring(currentIndex);
      textSpans.add(TextSpan(text: remainingText, style: regularTextStyle));
    }

    return textSpans;
  }
}
