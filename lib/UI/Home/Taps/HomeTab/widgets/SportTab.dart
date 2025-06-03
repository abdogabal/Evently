import 'package:flutter/material.dart';

import '../../../Widgets/EventItems.dart';

class SportTab extends StatelessWidget {
  const SportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        itemBuilder: (context, index) => EventItems(),
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemCount: 10,
      ),
    );
  }
}
