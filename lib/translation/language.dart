class Language{
  late int id;
  late String flag;
 late String name;
  late String language;
  Language(this.id, this.flag, this.name, this.language);
  static List<Language> listLang(){
    return <Language>[
      Language(1, '🇺🇸', 'English', 'en'),
      Language(2, '🇩🇿', 'العربية', 'ar'),
    ];
  }
}