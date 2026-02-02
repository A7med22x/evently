import 'package:evently/models/category_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  late CategoryModel selectedCategory = CategoryModel.Categories[currentIndex];

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).currentUser!;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome Back ✨', style: textTheme.titleMedium),
          SizedBox(height: 4),
          Text(currentUser.name, style: textTheme.titleLarge),
          SizedBox(height: 24),
          DefaultTabController(
            length: CategoryModel.Categories.length + 1,
            child: TabBar(
              isScrollable: true,
              tabAlignment: .start,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.only(right: 8),
              tabs: [
                TabItem(
                  tabName: 'All',
                  iconName: 'all',
                  isSelected: currentIndex == 0,
                ),
                ...CategoryModel.Categories.map(
                  (category) => TabItem(
                    tabName: category.name,
                    iconName: category.icon,
                    isSelected:
                        currentIndex ==
                        CategoryModel.Categories.indexOf(category) + 1,
                  ),
                ),
              ],
              onTap: (index) {
                if (currentIndex == index) return;
                currentIndex = index;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
