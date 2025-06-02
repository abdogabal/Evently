import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Models/OnboardingModal.dart';
import 'package:flutter/material.dart';

class PageViewOnboarding extends StatelessWidget {
  OnboardingModel model;

  PageViewOnboarding({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(model.image, fit: BoxFit.contain),
          Spacer(flex: 1),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              softWrap: true,
              model.title.tr(),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
          Spacer(flex: 2),
          Text(
            softWrap: true,
            model.description.tr(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
