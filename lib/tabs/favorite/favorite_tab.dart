import 'package:evently/providers/events_providers.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late EventsProviders eventsProviders;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserProvider userprovider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      eventsProviders.filterFavoriteEvents(
        userprovider.currentUser!.favoriteEventsIds,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    eventsProviders = Provider.of<EventsProviders>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          DefaultTextFormFiled(
            hintText: 'Search for event',
            suffixIconImageName: 'search',
            onChanged: (query) {},
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) =>
                  EventItem(eventsProviders.favoriteEvents[index]),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: eventsProviders.favoriteEvents.length,
            ),
          ),
        ],
      ),
    );
  }
}
