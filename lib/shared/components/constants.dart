




String? token='';
//String lang="en";

enum Lang {ar, en, }

void chooseToastColor(Lang lang) {
  String? apiLang;
  switch (lang) {
    case Lang.ar:
      apiLang ="ar";
      break;
    case Lang.en:
      apiLang ="en";
      break;
  }
}
