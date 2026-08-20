part of core;

class AppLanguageState extends Equatable {
  final AppLanguageEnum langCode;

  const AppLanguageState(this.langCode);

  const AppLanguageState.initial() : this(AppLanguageEnum.ar);

  AppLanguageState copyWith({AppLanguageEnum? langCode}) {
    return AppLanguageState(langCode ?? this.langCode);
  }

  @override
  List<Object> get props => [langCode];
}
