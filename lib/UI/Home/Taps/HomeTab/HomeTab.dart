import 'package:flutter/material.dart';

import '../../Widgets/EventItems.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemBuilder: (context, index) => EventItems(),
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemCount: 10,
      ),
    );
  }
}
