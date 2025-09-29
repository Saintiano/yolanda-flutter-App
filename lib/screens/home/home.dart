import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:yolanda/components/custom_app_bar_v3.dart';
import 'package:yolanda/components/custom_button_v2.dart';
import 'package:yolanda/components/customfield.dart';
import 'package:yolanda/components/image_widgets.dart';
import 'package:yolanda/components/menu_dropdown.dart';
import 'package:yolanda/constants/svgs.dart';
import 'package:yolanda/models/habit_model.dart';
import 'package:yolanda/repositories/Habit_Http_Repository.dart';
import 'package:yolanda/styles/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _searchController = TextEditingController();
  bool isEmpty = true;
  List<HabitModel> searchedHabits = [];
  searchRoles(){
    print(_searchController.text);
    searchedHabits.clear();
    for(HabitModel habit in Habit_Http_Repository.habitsTest ){

      if(habit.name.toString().toLowerCase().contains(_searchController.text.toLowerCase()) || habit.frequency.toString().toLowerCase().contains(_searchController.text.toLowerCase())){
        setState(() {
          searchedHabits.add(habit);
        });
      }
    }
    setState(() {
      isEmpty = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Custom_Button_V2(
        actionText: "Add Habit",
        onTap: () {
          // Navigator.pop(context);

        },
        elevation: 0,
        left: 0,
        top: 0,
        bottom: 0,
        right: 0,
        height: 50,
        width: 200,
        radius: 8,
        padding: 0,
        isOutline: true,
        overlayColor: AppColors.disabledButton,
        color: AppColors.black,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        key: const Key('add_habit'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:  BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/bg_single.png"),
          //   fit: BoxFit.cover,
          // ),
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary,
                  //add more colors for gradient
                ],
                begin: Alignment.topRight, //begin of the gradient color
                end: Alignment.bottomRight, //end of the gradient color
                stops: const [0, 0.2, 0.5, 0.8] //stops for individual color
              //set the stops number equal to numbers of color
            ),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Custom_App_Bar_Nav_V3(
              title: 'Habit',
              // colorBg: AppColors.white,
              noImage: false,
              buttonIsLeading: false,
              noNavbutton: false,
              titleIsBold: true,
              fontSize: 16,
              leftMargin: 10,
              rightMargin: 10,
              isDashboard: true,
              isNotDashboardTabs: true,
              hasBackButton: true,
              titleIsAtTheBeginning: false,
              menuIsWidget: true,
              menuWidget: MenuDropdown(
                pullDownMenuItem: [
                  PullDownMenuItem(
                    title: 'View All',
                    onTap: () {

                    },
                  ),
                  const PullDownMenuDivider(),
                  PullDownMenuItem(
                    title: 'View Habits Completed',
                    onTap: () {

                    },
                  ),
                  PullDownMenuItem(
                    title: 'View Pending Habits',
                    onTap: () {

                    },
                  ),
                  const PullDownMenuDivider(),
                ],
              ),
              onTapMenu:(){
                print("object");

              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 0, left: 20, top: 0),
                    child: CustomField(
                      hintColor: Theme.of(context).colorScheme.primary,
                      controller: _searchController,
                      hint: 'Enter Habit Name or Frequency',
                      sIcon: SvgImage(asset: search, height: 15, width: 15, color: Theme.of(context).colorScheme.primary),
                      showBorder: false,
                      onChanged: (value){

                      },
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 25,
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  // the method which is called
                  // when button is pressed
                  onPressed: () {

                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
