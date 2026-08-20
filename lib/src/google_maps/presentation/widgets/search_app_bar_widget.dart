part of "../search/maps_search_page.dart";

class _MapsSearchAppBarWidget extends StatelessWidget {
  const _MapsSearchAppBarWidget({required this.searchController, required this.onChange});
  final TextEditingController searchController;
  final void Function(String? text) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(minHeight: 45, maxHeight: 55),
                  decoration: BoxDecoration(color: AppColors.backgroundColor, borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    onChanged: onChange,
                    controller: searchController,
                    autofocus: true,
                    cursorColor: AppColors.primary,
                    style: TextStyles.bold14.copyWith(color: AppColors.black900),
                    cursorHeight: 20,
                    onTapOutside: (_) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    decoration: InputDecoration(
                      hintText: appLocalizer.searchForAddress,
                      hintStyle: TextStyles.medium14.copyWith(color: AppColors.black800),
                      counter: const SizedBox(),
                      helperText: '',
                      isDense: false,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
