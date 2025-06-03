import 'package:flutter/material.dart';

import '../../../../../Core/FirestoreHandler.dart';
import '../../../../../Core/resources/StringsManger.dart';
import '../../../Widgets/EventItems.dart';

class BirthdayTab extends StatelessWidget {
  const BirthdayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreHandler.getEventsStream('birthday'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Column(
            children: [
              ElevatedButton(onPressed: () {}, child: Text(StringsManger.tryAgain)),
            ],
          );
        }
        var events = snapshot.data ?? [];
        if (events.isEmpty) {
          return Center(
            child: Text(
              StringsManger.noEvent,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
            itemBuilder: (context, index) => EventItems(events[index]),
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: events.length,
          ),
        );
        ;
      },
    );
  }
}
