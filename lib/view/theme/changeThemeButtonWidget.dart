import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/view/theme/myThemes.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      activeColor: Colors.pinkAccent,
        value: themeProvider.isDarkMode,
        onChanged: (value){
        final provider =Provider.of<ThemeProvider>(context,listen: false);
        provider.toggleTheme(value);
        }
    );
  }
}
