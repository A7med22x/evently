import 'package:evently/app_theme.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_providers.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  EventModel event;

  EventItem(this.event);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isFavorite = userProvider.checkEventIsFavorite(event.id);
    SettingsProvider settingspProvider = Provider.of<SettingsProvider>(context);
    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: settingspProvider.isDark
              ? AppTheme.darkBlue
              : AppTheme.offWhite,
        ),
      ),
      clipBehavior: .antiAlias,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/${settingspProvider.isDark ? "${event.category.imageName}_dark" : event.category.imageName}.png',
              height: screenSize.height * 0.23,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: settingspProvider.isDark
                  ? AppTheme.backgroundDark
                  : AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: settingspProvider.isDark
                    ? AppTheme.darkBlue
                    : AppTheme.offWhite,
              ),
            ),
            child: Text(
              DateFormat('d MMM').format(event.dateTime),
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: settingspProvider.isDark
                    ? AppTheme.backgroundDark
                    : AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: settingspProvider.isDark
                      ? AppTheme.darkBlue
                      : AppTheme.offWhite,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(event.title, style: textTheme.titleSmall),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      if (isFavorite) {
                        userProvider.removeEventFromFavorites(event.id);
                        Provider.of<EventsProviders>(
                          context,
                          listen: false,
                        ).filterFavoriteEvents(
                          userProvider.currentUser!.favoriteEventsIds,
                        );
                      } else {
                        userProvider.addEventToFavorites(event.id);
                      }
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: settingspProvider.isDark
                          ? AppTheme.primaryDark
                          : AppTheme.primaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
