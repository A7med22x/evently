import 'package:evently/eventScreens/event_details.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> events = [];

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      getEvents();
    }
    return Column(
      children: [
        HomeHeader(),
        SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) => InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(EventDetails.routeName, arguments: events[index]);
              },
              child: EventItem(events[index])),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: events.length,
          ),
        ),
      ],
    );
  }

  Future<void> getEvents() async {
    events = await FirebaseService.getEvents();
    setState(() {});
  }
}
