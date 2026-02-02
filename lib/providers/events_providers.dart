import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:evently/models/category_model.dart';

class EventsProviders with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displyedEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displyedEvents = allEvents;
    } else {
      displyedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }
    notifyListeners();
  }
}
