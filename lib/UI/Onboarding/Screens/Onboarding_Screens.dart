import 'package:dots_indicator/dots_indicator.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/UI/Login/Screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:evently/Models/OnboardingModal.dart';

import '../../../Core/PrefsManager.dart';
import '../Widgets/PageViewOnboarding.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = 'Onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int pos = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<OnboardingModel> onboardingModel = [
      OnboardingModel(
        image: AssetsManger.hotTrending,
        title: StringsManger.onboardingTitle1,
        description: StringsManger.onboardingDesc1,
      ),
      OnboardingModel(
        image:
            Theme.of(context).colorScheme.brightness == Brightness.dark
                ? AssetsManger.wireframe
                : AssetsManger.mangerDesk,
        title: StringsManger.onboardingTitle2,
        description: StringsManger.onboardingDesc2,
      ),
      OnboardingModel(
        image:
            Theme.of(context).colorScheme.brightness == Brightness.dark
                ? AssetsManger.uploading
                : AssetsManger.socialMedia,
        title: StringsManger.onboardingTitle3,
        description: StringsManger.onboardingDesc3,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManger.logoBar, height: 50, width: 150),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  pos = index;
                  setState(() {});
                },
                controller: pageController,
                itemBuilder:
                    (context, index) =>
                        PageViewOnboarding(model: onboardingModel[index]),
                itemCount: onboardingModel.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: pos != 0,
                  maintainSize: true,
                  maintainState: true,
                  maintainSemantics: true,
                  maintainAnimation: true,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    onPressed: () {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.linear,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                DotsIndicator(
                  dotsCount: onboardingModel.length,
                  position: pos.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Theme.of(context).colorScheme.primary,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: Size.square(9.0),
                    activeSize: Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (pos < (onboardingModel.length - 1)) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.linear,
                      );
                    } else {
                      PrefsManager.onboardingFirstTime();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                        (route) => false,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
