import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/moduls/searche_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/translation/language.dart';
import 'package:shop_app/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class LayoutScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                navigateTo(context, SearchScreen());
              },
              icon: Icon(Icons.search),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  underline: SizedBox(),
                  icon: Icon(Icons.language),
                  onChanged: (Language? language) {
                    if(language!.language=="en")
                      context.setLocale(Locale('en'));
                    if(language.language=="ar")
                      context.setLocale(Locale('ar'));
                   // AppCubit.get(context).changeLanguage(context.locale.toString());
                  },
                  items: Language.listLang()
                      .map<DropdownMenuItem<Language>>(
                          (lang) => DropdownMenuItem(
                                value: lang,
                                child: Row(
                                  children: [
                                    Text(lang.flag),
                                    SizedBox(width: 5.0,),
                                    Text(lang.name),
                                  ],
                                ),
                              ))
                      .toList(),
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomIndex(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: LocaleKeys.homeText.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: LocaleKeys.categories.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: LocaleKeys.favoriteText.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: LocaleKeys.profileText.tr(),
              )
            ],
          ),
        );
      },
    );
  }
}
