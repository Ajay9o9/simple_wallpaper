import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wallpaper_app/components/theme.dart';

class ThemeSwitchIconButton extends StatefulWidget {
  final IconData icon;

  const ThemeSwitchIconButton({Key? key, this.icon = Icons.palette})
      : super(key: key);

  @override
  State<ThemeSwitchIconButton> createState() => _ThemeSwitchIconButtonState();
}

class _ThemeSwitchIconButtonState extends State<ThemeSwitchIconButton> {
  late String _appThemeId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appThemeId = ThemeProvider.controllerOf(context).currentThemeId;
    print("app theme is ${_appThemeId}");
    return IconButton(
      icon: Icon(
        _appThemeId == "dark_theme" ? Icons.wb_sunny : Icons.brightness_2,
      ),
      color: ThemeProvider.optionsOf<ThisThemeOptions>(context).appBarTextColor,
      onPressed: ThemeProvider.controllerOf(context).nextTheme,
    );
  }
}
