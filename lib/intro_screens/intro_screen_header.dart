import 'package:evently/app_theme.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';

class IntroScreenHeader extends StatelessWidget {
  int currentIndex;
  Function() onBack;
  Function() onSkip;

  IntroScreenHeader({required this.currentIndex, required this.onBack, required this.onSkip});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (currentIndex == 0)
            ? SizedBox(width: 8)
            : ElevatedButton(
                onPressed: onBack,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.white,
                  foregroundColor: AppTheme.primaryLight,
                ),
                child: Icon(Icons.arrow_back_ios),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Image.asset(
            'assets/images/logo.png',
            width: MediaQuery.sizeOf(context).width * 0.37,
            fit: BoxFit.scaleDown,
          ),
        ),
        (currentIndex == 0)
            ? SizedBox(width: 8)
            : DefaultElevatedButton(
                label: 'Skip',
                onPressed: onSkip,
                width: 80,
                height: 32,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                backgroundColor: AppTheme.white,
                foregroundColor: AppTheme.primaryLight,
              ),
      ],
    );
  }
}
