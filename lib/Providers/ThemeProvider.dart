import 'package:evently/Core/PrefsManager.dart';
import 'package:flutter/material.dart';

class ThemeProviders extends ChangeNotifier{
  ThemeMode themeMode= ThemeMode.light;
  init(){
    bool result = PrefsManager.getTheme();
    if(result){
      themeMode=ThemeMode.dark;
    }else{
      themeMode=ThemeMode.light;
    }
  }
  changeTheme(ThemeMode newTheme){
    themeMode =newTheme;
    notifyListeners();
  }


}