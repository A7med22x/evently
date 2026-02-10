import 'package:evently/app_theme.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroScreenHeader extends StatelessWidget {
  int currentIndex;
  Function() onBack;
  Function() onSkip;

  IntroScreenHeader({
    required this.currentIndex,
    required this.onBack,
    required this.onSkip,
  });
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingspProvider = Provider.of<SettingsProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (currentIndex < 2)
            ? SizedBox(width: 8)
            : ElevatedButton(
                onPressed: onBack,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(32, 32),
                  backgroundColor: settingspProvider.isDark
                      ? AppTheme.navy
                      : AppTheme.white,
                  foregroundColor: settingspProvider.isDark
                      ? AppTheme.white
                      : AppTheme.primaryLight,
                  side: BorderSide(
                    color: settingspProvider.isDark
                        ? AppTheme.darkBlue
                        : AppTheme.offWhite,
                  ),
                ),
                child: Icon(Icons.arrow_back_ios),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: settingspProvider.isDark
              ? Image.asset(
                  'assets/images/logo_dark.png',
                  height: 27,
                  width: MediaQuery.sizeOf(context).width * 0.37,
                  fit: .fill,
                )
              : Image.asset(
                  'assets/images/logo.png',
                  height: 27,
                  width: MediaQuery.sizeOf(context).width * 0.37,
                  fit: .fill,
                ),
        ),
        (currentIndex == 0 || currentIndex == 3)
            ? SizedBox(width: 8)
            : DefaultElevatedButton(
                label: appLocalizations.skip,
                onPressed: onSkip,
                width: MediaQuery.sizeOf(context).width * 0.25,
                height: 32,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                backgroundColor: settingspProvider.isDark
                    ? AppTheme.navy
                    : AppTheme.white,
                foregroundColor: settingspProvider.isDark
                    ? AppTheme.white
                    : AppTheme.primaryLight,
                border: settingspProvider.isDark
                    ? AppTheme.darkBlue
                    : AppTheme.offWhite,
              ),
      ],
    );
  }
}
