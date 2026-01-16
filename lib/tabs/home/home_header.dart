import 'package:evently/models/category_model.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back ✨', style: textTheme.titleMedium),
            SizedBox(height: 4),
            Text('User Name', style: textTheme.titleLarge),
            DefaultTabController(
              length: CategoryModel.Categories.length + 1,
              child: TabBar(
                isScrollable: true,
                tabAlignment: .start,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                labelPadding: EdgeInsets.only(right: 8),
                tabs: [
                  TabItem(tabName: 'All', iconName: 'all', isSelected: true),
                  ...CategoryModel.Categories.map(
                    (category) => TabItem(
                      tabName: category.name,
                      iconName: category.icon,
                      isSelected: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
