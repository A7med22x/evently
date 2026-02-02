import 'package:evently/eventScreens/event_details.dart';
import 'package:evently/providers/events_providers.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventsProviders eventsProviders = Provider.of<EventsProviders>(context);
    return Column(
      children: [
        HomeHeader(),
        SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) => InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  EventDetails.routeName,
                  arguments: eventsProviders.allEvents[index],
                );
              },
              child: EventItem(eventsProviders.allEvents[index]),
            ),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: eventsProviders.allEvents.length,
          ),
        ),
      ],
    );
  }
}
