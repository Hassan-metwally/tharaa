part of '../drop_down.dart';

class _SearchField extends StatefulWidget {
  const _SearchField({
    required this.onSearch,
    // ignore: unused_element_parameter
    this.initialValue,
    this.prefixIcon,
  });

  final void Function(String? searchKey) onSearch;
  final String? initialValue;
  final String? prefixIcon;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  Timer? _timer;
  final controller = TextEditingController();

  void _onChanged(String? text) {
    _timer?.cancel();
    _timer = null;
    _timer = Timer(Durations.long1, () {
      widget.onSearch(text);
    });
  }

  @override
  void initState() {
    controller.text = widget.initialValue ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: 200,
      minLines: 1,
      onChanged: _onChanged,
      keyboardType: TextInputType.text,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      inputFormatters: [FilteringTextInputFormatter.deny("\t\t")],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        // prefixIcon: const Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: EdgeInsetsDirectional.only(start: 8),
        //       child: FittedBox(
        //         fit: BoxFit.scaleDown,
        //         child: AppSvgIcon(
        //           path: widget.prefixIcon ?? AppIcons.searchIc,
        //           color: AppColors.hintColor,
        //           size: 20,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        suffixIcon: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) {
            final bool show = value.text.isNotEmpty;
            return AnimatedOpacity(
              duration: Durations.medium3,
              opacity: show ? 1 : 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.clear();
                  _onChanged(null);
                },
                child: const Icon(Icons.close, size: 16),
              ),
            );
          },
        ),
        isDense: true,
        counter: const SizedBox(),
        helper: const SizedBox(),
        hintText: "${appLocalizer.search} ...",
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    controller.dispose();
    super.dispose();
  }
}
