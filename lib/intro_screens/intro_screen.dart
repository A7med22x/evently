import 'package:evently/home_screen.dart';
import 'package:evently/intro_screens/page_view_item.dart';
import 'package:evently/models/intro_screen_model.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = '/intro';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  late PageController pageController = PageController(
    initialPage: currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  onPageChanged: (index) {
                    currentIndex = index;
                    setState(() {});
                  },
                  itemBuilder: (_, index) => PageViewItem(
                    introScreenModel:
                        IntroScreenModel.introScreenModels[currentIndex],
                    currentIndex: currentIndex,
                    onBack: onBackBottonClicked,
                    onNext: onNextBottonClicked,
                  ),
                  itemCount: IntroScreenModel.introScreenModels.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onNextBottonClicked() {
    if (currentIndex < IntroScreenModel.introScreenModels.length - 1) {
      currentIndex++;
      setState(() {});
      pageController.jumpToPage(currentIndex);
    } else if (currentIndex == IntroScreenModel.introScreenModels.length - 1) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  void onBackBottonClicked() {
    if (currentIndex > 0) {
      currentIndex--;
      setState(() {});
      pageController.jumpToPage(currentIndex);
    }
  }
}
