import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_model.dart';
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
  List<EventModel> search = [];
  TextEditingController searchController = .new();

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
            hintText: AppLocalizations.of(context)!.searchForEvent,
            suffixIconImageName: 'search',
            onChanged: (query) {
              search = eventsProviders.searchForEvents(query);
              setState(() {});
            },
            controller: searchController,
          ),
          SizedBox(height: 16),
          Expanded(
            child: searchController.text.isNotEmpty && search.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.noResults,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (_, index) => EventItem(
                      search.isNotEmpty
                          ? search[index]
                          : eventsProviders.favoriteEvents[index],
                    ),
                    separatorBuilder: (_, _) => SizedBox(height: 16),
                    itemCount: search.isNotEmpty
                        ? search.length
                        : eventsProviders.favoriteEvents.length,
                  ),
          ),
        ],
      ),
    );
  }
}
