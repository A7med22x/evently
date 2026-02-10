import 'package:evently/app_theme.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ArrowBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingspProvider = Provider.of<SettingsProvider>(context);

    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: settingspProvider.isDark
              ? AppTheme.navy
              : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: settingspProvider.isDark
                ? AppTheme.darkBlue
                : AppTheme.backgroundLight,
          ),
        ),
        child: SvgPicture.asset(
          'assets/icons/arrow-left.svg',
          width: 24,
          height: 24,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
