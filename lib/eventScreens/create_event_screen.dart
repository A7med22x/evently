import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_providers.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/arrow_back.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/ui_utils.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/create event';

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int currentIndex = 0;
  CategoryModel selectedCategory = CategoryModel.Categories.first;
  TextEditingController titleController = .new();
  TextEditingController descriptionController = .new();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  late AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    appLocalizations = AppLocalizations.of(context)!;
    SettingsProvider settingspProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: ArrowBack(), title: Text(appLocalizations.addEvent)),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: settingspProvider.isDark ? Image.asset(
                    'assets/images/${selectedCategory.imageName}_dark.png',
                    width: .infinity,
                    height: MediaQuery.sizeOf(context).height * 0.21,
                    fit: .fill,
                  ) : Image.asset(
                    'assets/images/${selectedCategory.imageName}.png',
                    width: .infinity,
                    height: MediaQuery.sizeOf(context).height * 0.21,
                    fit: .fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: DefaultTabController(
                  length: CategoryModel.Categories.length,
                  child: TabBar(
                    tabs: CategoryModel.Categories.map(
                      (category) => TabItem(
                        tabName: category.name,
                        iconName: category.icon,
                        isSelected:
                            currentIndex ==
                            CategoryModel.Categories.indexOf(category),
                      ),
                    ).toList(),
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    labelPadding: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.only(left: 16),
                    tabAlignment: .start,
                    onTap: (index) {
                      if (currentIndex == index) return;
                      currentIndex = index;
                      selectedCategory = CategoryModel.Categories[currentIndex];
                      setState(() {});
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(appLocalizations.title, style: textTheme.titleMedium),
                    SizedBox(height: 8),
                    DefaultTextFormFiled(
                      hintText: appLocalizations.eventTitle,
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return appLocalizations.titleCanNotBeEmpty;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      appLocalizations.description,
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: 8),
                    DefaultTextFormFiled(
                      hintText: appLocalizations.eventDescription,
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return appLocalizations.descriptionCanNotBeEmpty;
                        }
                        return null;
                      },
                      maxLines: 5,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/date.svg'),
                        SizedBox(width: 4),
                        Text(
                          appLocalizations.eventDate,
                          style: textTheme.titleMedium,
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                              initialDate: selectedDate,
                              initialEntryMode: .calendarOnly,
                            );
                            if (date != null) {
                              selectedDate = date;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedDate == null
                                ? appLocalizations.chooseDate
                                : dateFormat.format(selectedDate!),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/time.svg'),
                        SizedBox(width: 4),
                        Text(
                          appLocalizations.eventTime,
                          style: textTheme.titleMedium,
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: selectedTime ?? TimeOfDay.now(),
                              initialEntryMode: .dialOnly,
                            );
                            if (time != null) {
                              selectedTime = time;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedTime?.format(context) ??
                                appLocalizations.chooseTime,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DefaultElevatedButton(
                      label: appLocalizations.addEvent,
                      onPressed: createEvent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createEvent() {
    if (formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      EventModel event = EventModel(
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );
      Provider.of<EventsProviders>(context, listen: false)
          .addEvent(event)
          .then((_) {
            Navigator.of(context).pop();
            UiUtils.showSuccessMessage(appLocalizations.eventCreatedSuccessfully);
          })
          .catchError((_) {
            UiUtils.showErrorMessage(appLocalizations.failedToCreateEvent);
          });
    }
  }
}
