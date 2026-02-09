import 'package:evently/app_theme.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TabItem extends StatelessWidget {
  String tabName;
  String iconName;
  bool isSelected;

  TabItem({
    required this.tabName,
    required this.iconName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingspProvider = Provider.of<SettingsProvider>(context);
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? primaryColor
            : settingspProvider.isDark
            ? AppTheme.navy
            : AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? null
            : Border.all(
                color: settingspProvider.isDark
                    ? AppTheme.darkBlue
                    : AppTheme.offWhite,
              ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/$iconName.svg',
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              isSelected ? AppTheme.white : primaryColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8),
          Text(
            iconName,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: isSelected
                  ? AppTheme.white
                  : settingspProvider.isDark
                  ? AppTheme.white
                  : AppTheme.black,
            ),
          ),
        ],
      ),
    );
  }
}
