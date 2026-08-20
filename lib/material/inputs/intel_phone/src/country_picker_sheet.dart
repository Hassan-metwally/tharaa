// ignore_for_file: library_private_types_in_public_api

part of phone_field;

class CountryPickerStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  CountryPickerStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerSheet extends StatefulWidget {
  final List<PhoneFieldCountryEntity> countryList;
  final PhoneFieldCountryEntity selectedCountry;
  final ValueChanged<PhoneFieldCountryEntity> onCountryChanged;
  final String searchText;
  final List<PhoneFieldCountryEntity> filteredCountries;
  final CountryPickerStyle? style;

  const CountryPickerSheet({
    super.key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  });

  @override
  _CountryPickerSheetState createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  List<PhoneFieldCountryEntity> get _filteredCountries {
    final countries = List<PhoneFieldCountryEntity>.from(widget.countryList);
    final searchText = _searchController.text.replaceAll("+", "");

    if (_isNumeric(searchText)) {
      return countries.where((country) => country.dialCode.contains(searchText)).toList();
    } else if (searchText.isNotEmpty) {
      countries.retainWhere(
        (country) =>
            country.name.toLowerCase().contains(searchText.toLowerCase()) ||
            country.arabicName.toLowerCase().contains(searchText.toLowerCase()),
      );
    }
    return countries;
  }

  final _searchController = TextEditingController();

  late PhoneFieldCountryEntity _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    super.initState();
  }

  bool _isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppTextFormField(
          hint: appLocalizer.searchForCountry,
          controller: _searchController,
          prefixIcon: (_) => AppSvgIcon(path: "assets/icons/search-ic.svg", color: AppColors.hintColor),
          onChanged: (value) {
            if (mounted) setState(() {});
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _filteredCountries.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider());
                  },
                  itemBuilder: (context, index) {
                    final bool isSelected = _selectedCountry.code == _filteredCountries[index].code;
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        _selectedCountry = _filteredCountries[index];
                        widget.onCountryChanged(_selectedCountry);
                        Navigator.of(context).pop(_filteredCountries[index]);
                      },
                      child: Row(
                        children: [
                          Text(_filteredCountries[index].flag),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              getLocaleTypeEnum == AppLanguageEnum.ar
                                  ? _filteredCountries[index].arabicName
                                  : _filteredCountries[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: (isSelected ? TextStyles.bold12 : TextStyles.light12),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text("${_filteredCountries[index].dialCode}+", style: (isSelected ? TextStyles.bold12 : TextStyles.light12)),
                        ],
                      ),
                    );
                  },
                  itemCount: _filteredCountries.length,
                )
              : Center(
                  child: Text(appLocalizer.noResultFound, textAlign: TextAlign.center, style: TextStyles.medium14),
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
