import 'package:evently/intro_screens/intro_screen_body.dart';
import 'package:evently/intro_screens/intro_screen_header.dart';
import 'package:evently/models/intro_screen_model.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  IntroScreenModel introScreenModel;
  int currentIndex;
  Function() onNext;
  Function() onBack;
  Function() onSkip;

  PageViewItem({
    required this.introScreenModel,
    required this.currentIndex,
    required this.onNext,
    required this.onBack,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntroScreenHeader(
          currentIndex: currentIndex,
          onBack: onBack,
          onSkip: onSkip,
        ),
        SizedBox(height: 26),
        Image.asset(
          'assets/images/${introScreenModel.imageName}.png',
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.44,
          fit: BoxFit.fill,
        ),
        SizedBox(height: 16),
        Expanded(
          child: IntroScreenBody(
            header: introScreenModel.header,
            body: introScreenModel.body,
            buttunName: introScreenModel.buttonName,
            currentIndex: currentIndex,
            onPressed: onNext,
          ),
        ),
      ],
    );
  }
}
