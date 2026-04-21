import 'package:evently/app_theme.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class IntroScreenBody extends StatelessWidget {
  final String header;
  final String body;
  final String buttunName;
  final int currentIndex;
  final Function() onPressed;

  const IntroScreenBody({
    required this.header,
    required this.body,
    required this.buttunName,
    required this.currentIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingspProvider = Provider.of<SettingsProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          header,
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Expanded(
          child: Text(
            body,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: settingspProvider.isDark
                  ? AppTheme.silver
                  : AppTheme.darkGrey,
            ),
          ),
        ),
        SizedBox(height: 16),
        (currentIndex != 0)
            ? SizedBox(height: 0)
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocalizations.language,
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: settingspProvider.isDark
                              ? AppTheme.white
                              : AppTheme.primaryLight,
                        ),
                      ),
                      Row(
                        children: [
                          DefaultElevatedButton(
                            label: appLocalizations.english,
                            onPressed: () {
                              settingspProvider.changelanguage('en');
                            },
                            width: MediaQuery.sizeOf(context).width * 0.30,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,

                            backgroundColor: settingspProvider.isDark
                                ? settingspProvider.isEnglish
                                      ? AppTheme.primaryDark
                                      : AppTheme.navy
                                : settingspProvider.isEnglish
                                ? AppTheme.primaryLight
                                : AppTheme.white,
                            foregroundColor: settingspProvider.isDark
                                ? AppTheme.white
                                : settingspProvider.isEnglish
                                ? AppTheme.white
                                : AppTheme.primaryLight,
                            border: settingspProvider.isDark
                                ? AppTheme.darkBlue
                                : AppTheme.white,
                          ),
                          SizedBox(width: 8),
                          DefaultElevatedButton(
                            label: appLocalizations.arabic,
                            onPressed: () {
                              settingspProvider.changelanguage('ar');
                            },
                            width: MediaQuery.sizeOf(context).width * 0.30,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            backgroundColor: settingspProvider.isDark
                                ? settingspProvider.isEnglish
                                      ? AppTheme.navy
                                      : AppTheme.primaryDark
                                : settingspProvider.isEnglish
                                ? AppTheme.white
                                : AppTheme.primaryLight,
                            foregroundColor: settingspProvider.isDark
                                ? AppTheme.white
                                : settingspProvider.isEnglish
                                ? AppTheme.primaryLight
                                : AppTheme.white,
                            border: settingspProvider.isDark
                                ? AppTheme.darkBlue
                                : AppTheme.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocalizations.theme,
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: settingspProvider.isDark
                              ? AppTheme.white
                              : AppTheme.primaryLight,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              settingspProvider.changeTheme(.light);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: settingspProvider.isDark
                                  ? AppTheme.navy
                                  : AppTheme.primaryLight,
                              side: BorderSide(
                                color: settingspProvider.isDark
                                    ? AppTheme.darkBlue
                                    : AppTheme.primaryLight,
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/light_theme.svg',
                              colorFilter: ColorFilter.mode(
                                AppTheme.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              settingspProvider.changeTheme(.dark);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: settingspProvider.isDark
                                  ? AppTheme.primaryDark
                                  : AppTheme.white,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/dark_theme.svg',
                              colorFilter: ColorFilter.mode(
                                settingspProvider.isDark
                                    ? AppTheme.white
                                    : AppTheme.primaryLight,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
        DefaultElevatedButton(label: buttunName, onPressed: onPressed),
      ],
    );
  }
}
