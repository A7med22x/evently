import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/language_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).currentUser!;
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingspProvider = Provider.of<SettingsProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 16),
          CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage('assets/images/route_logo.png'),
          ),
          SizedBox(height: 16),
          Text(
            currentUser.name,
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(currentUser.email, style: textTheme.titleSmall),
          SizedBox(height: 32),
          SwitchListTile(
            value: settingspProvider.isDark,
            onChanged: (isDark) {
              settingspProvider.changeTheme(isDark ? .dark : .light);
            },
            title: Text(appLocalizations.darkMode),
            activeTrackColor: Theme.of(context).primaryColor,
            inactiveTrackColor: AppTheme.lightGrey,
            thumbColor: WidgetStatePropertyAll(AppTheme.white),
            trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(appLocalizations.language),
            trailing: DropdownButton(
              value: settingspProvider.languageCode,
              items: LanguageModel.languages
                  .map(
                    (language) => DropdownMenuItem(
                      value: language.code,
                      child: Text(
                        language.name
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (languageCode) {
                if (languageCode == null) return;
                settingspProvider.changelanguage(languageCode);
              },
              dropdownColor: AppTheme.white,
              borderRadius: BorderRadius.circular(16),
              underline: SizedBox(),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(appLocalizations.logout),
            trailing: SvgPicture.asset(
              'assets/icons/logout.svg',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            onTap: () => FirebaseService.logout().then((_) {
              Navigator.of(
                context,
              ).pushReplacementNamed(LoginScreen.routeName).then((_) {
                Provider.of<UserProvider>(context).updateCurrentUser(null);
              });
            }),
          ),
        ],
      ),
    );
  }
}
