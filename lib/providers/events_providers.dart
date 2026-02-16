import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:evently/models/category_model.dart';

class EventsProviders with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favoriteEvents = [];
  List<EventModel> searchEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;
    notifyListeners();
  }

  Future<void> addEvent(EventModel event) async {
    await FirebaseService.createEvent(event);
    await getEvents();
    notifyListeners();
  }

  Future<void> updateEvent(EventModel event) async {
    await FirebaseService.updateEvent(event);
    await getEvents();
    notifyListeners();
  }

  Future<void> deleteEvent(EventModel event) async {
    await FirebaseService.deleteEvent(event);
    await getEvents();
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }
    notifyListeners();
  }

  void filterFavoriteEvents(List<String>? favoriteIds) {
    if (favoriteIds != null) {
      favoriteEvents = allEvents
          .where((event) => favoriteIds.contains(event.id))
          .toList();
    }
    notifyListeners();
  }

  List<EventModel> searchForEvents(String query) {
    if (query.isEmpty) {
      searchEvents = [];
    } else {
      searchEvents = allEvents.where((event) {
        return event.category.name.toLowerCase().contains(
              query.toLowerCase(),
            ) ||
            event.title.toLowerCase().contains(query.toLowerCase()) ||
            event.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
    return searchEvents;
  }
}
