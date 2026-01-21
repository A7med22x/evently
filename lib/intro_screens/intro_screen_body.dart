import 'dart:ffi';

import 'package:evently/app_theme.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroScreenBody extends StatelessWidget {
  String header;
  String body;
  String buttunName;
  int currentIndex;
  Function() onPressed;

  IntroScreenBody({
    required this.header,
    required this.body,
    required this.buttunName,
    required this.currentIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDarkTheme = false;

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
              color: AppTheme.darkGrey,
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
                        'Language',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppTheme.primaryLight,
                        ),
                      ),
                      Row(
                        children: [
                          DefaultElevatedButton(
                            label: 'English',
                            onPressed: () {},
                            width: 100,
                            height: 32,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(width: 8),
                          DefaultElevatedButton(
                            label: 'Arabic',
                            onPressed: () {},
                            width: 100,
                            height: 32,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            backgroundColor: AppTheme.white,
                            foregroundColor: AppTheme.primaryLight,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Theme',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppTheme.primaryLight,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: SvgPicture.asset(
                              'assets/icons/light_theme.svg',
                              colorFilter: ColorFilter.mode(
                                isDarkTheme
                                    ? AppTheme.primaryLight
                                    : AppTheme.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: SvgPicture.asset(
                              'assets/icons/dark_theme.svg',
                              colorFilter: ColorFilter.mode(
                                isDarkTheme
                                    ? AppTheme.primaryLight
                                    : AppTheme.white,
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
