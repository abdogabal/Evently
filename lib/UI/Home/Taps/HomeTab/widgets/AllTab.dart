import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/FirestoreHandler.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/Models/Event.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/EventItems.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreHandler.getAllEventsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Column(
            children: [
              Text(snapshot.error.toString()),
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
      },
    );
  }
}
