import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_providers.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/arrow_back.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:evently/widgets/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = '/edit event';

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late EventModel event;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DateTime selectedDate = event.dateTime;
  late TimeOfDay selectedTime = TimeOfDay.fromDateTime(event.dateTime);
  DateFormat dateFormat = DateFormat('MMM d, yyy');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    event = ModalRoute.of(context)!.settings.arguments as EventModel;
    titleController.text = event.title;
    descriptionController.text = event.description;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    int currentIndex = CategoryModel.Categories.indexOf(event.category);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: ArrowBack(), title: Text('Edit event')),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/${event.category.imageName}.png',
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
                      event.category = CategoryModel.Categories[currentIndex];
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
                    Text('Title', style: textTheme.titleMedium),
                    SizedBox(height: 8),
                    DefaultTextFormFiled(
                      hintText: '',
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title can not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text('Description', style: textTheme.titleMedium),
                    SizedBox(height: 8),
                    DefaultTextFormFiled(
                      hintText: '',
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description can not be empty';
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
                        Text('Event Date', style: textTheme.titleMedium),
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
                          child: Text(dateFormat.format(selectedDate)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/time.svg'),
                        SizedBox(width: 4),
                        Text('Event Time', style: textTheme.titleMedium),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                              initialEntryMode: .dialOnly,
                            );
                            if (time != null) {
                              selectedTime = time;
                              setState(() {});
                            }
                          },
                          child: Text(selectedTime.format(context)),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DefaultElevatedButton(
                      label: 'Update event',
                      onPressed: updateEvent,
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

  void updateEvent() {
    if (formKey.currentState!.validate()) {
      DateTime dateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      event = EventModel(
        id: event.id,
        category: event.category,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );
      Provider.of<EventsProviders>(context, listen: false)
          .updateEvent(event)
          .then((_) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            UiUtils.showSuccessMessage('Event updated successfully');
          })
          .catchError((_) {
            UiUtils.showErrorMessage('Failed to update event');
          });
    }
  }
}
