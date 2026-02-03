import 'package:evently/app_theme.dart';
import 'package:evently/eventScreens/edit_event_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/widgets/arrow_back.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:evently/widgets/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  static const String routeName = '/event details';
  late EventModel event;
  late TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context)!.settings.arguments as EventModel;
    TextTheme textTheme = Theme.of(context).textTheme;
    descriptionController = TextEditingController(text: event.description);

    return Scaffold(
      appBar: AppBar(
        leading: ArrowBack(),
        title: Text('Event details'),
        actions: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: .antiAlias,
            child: IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(EditEventScreen.routeName, arguments: event);
              },
              icon: SvgPicture.asset('assets/icons/edit.svg'),
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: .antiAlias,
            child: IconButton(
              onPressed: () {
                FirebaseService.onEventDelete(event).then((_) {
                  Navigator.of(context).pop();
                  UiUtils.showSuccessMessage('Event deleted successfully');
                });
              },
              icon: SvgPicture.asset('assets/icons/trash.svg'),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(
                'assets/images/${event.category.imageName}.png',
                width: .infinity,
                height: MediaQuery.sizeOf(context).height * 0.21,
                fit: .fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  event.title,
                  style: textTheme.titleMedium!.copyWith(fontSize: 18),
                ),
                SizedBox(height: 8),
                Container(
                  width: .infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: .antiAlias,
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/date.svg',
                          width: 24,
                          height: 24,
                          fit: .scaleDown,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            DateFormat('d MMMM').format(event.dateTime),
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            DateFormat('hh: mm a').format(event.dateTime),
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text('Description', style: textTheme.titleMedium),
                SizedBox(height: 8),
                DefaultTextFormFiled(
                  hintText: '',
                  controller: descriptionController,
                  readOnly: true,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
