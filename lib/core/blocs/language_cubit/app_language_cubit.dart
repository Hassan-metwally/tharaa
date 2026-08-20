part of core;

class AppLanguageCubit extends Cubit<AppLanguageState> {
  late final LocalizationContainer _localizationContainer;

  AppLanguageCubit() : super(const AppLanguageState.initial()) {
    _localizationContainer = injector();
  }

  static AppLanguageCubit of(BuildContext context) => BlocProvider.of(context);

  Future<void> changeLanguage(AppLanguageEnum langCode) async {
    if (langCode == state.langCode) return;
    // We put this before reset dependencies scope.
    // Because it will not get reset cause it is in different scope
    await injector<LocalizationContainer>().setLanguage(langCode);
    await resetDependenciesScope();
    emit(state.copyWith(langCode: langCode));
  }

  Future<void> init() async {
    await _localizationContainer.init();
    emit(state.copyWith(langCode: _localizationContainer.getLang));
  }

  bool get isRtl {
    return isArabic;
  }

  bool get isArabic {
    return state.langCode == AppLanguageEnum.ar;
  }

  bool get isEnglish {
    return state.langCode == AppLanguageEnum.en;
  }

  @override
  void emit(AppLanguageState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
