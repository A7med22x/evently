import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          DefaultTextFormFiled(
            hintText: 'Search for event',
            suffixIconImageName: 'search',
            onChanged: (query) {},
          ),
          SizedBox(height: 16,),
          //Expanded(
          //   child: ListView.separated(
          //     itemBuilder: (_, index) => EventItem(),
          //     separatorBuilder: (_, _) => SizedBox(height: 16),
          //     itemCount: 20,
          //   ),
          // ),
        ],
      ),
    );
  }
}
