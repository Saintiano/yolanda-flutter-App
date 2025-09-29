import 'package:adaptive_theme/adaptive_theme.dart' show AdaptiveTheme;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:yolanda/components/buttons.dart';
import 'package:yolanda/components/custom_app_bar_v3.dart';
import 'package:yolanda/components/custom_button_v2.dart';
import 'package:yolanda/components/custom_card_shape.dart';
import 'package:yolanda/components/custom_form_field_v2.dart';
import 'package:yolanda/components/custom_stateful_body.dart';
import 'package:yolanda/components/custom_text_with_Images.dart';
import 'package:yolanda/components/customfield.dart';
import 'package:yolanda/components/dialogs.dart';
import 'package:yolanda/components/empty_state_widget.dart';
import 'package:yolanda/components/image_widgets.dart';
import 'package:yolanda/components/menu_dropdown.dart';
import 'package:yolanda/constants/constants.dart';
import 'package:yolanda/constants/responsiveness.dart';
import 'package:yolanda/constants/svgs.dart';
import 'package:yolanda/controller/habit_controller.dart';
import 'package:yolanda/models/habit_model.dart';
import 'package:yolanda/repositories/Habit_Http_Repository.dart';
import 'package:yolanda/services/loading_overlay_service.dart';
import 'package:yolanda/styles/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Habit_Controller habit_controller = Habit_Controller(Habit_Http_Repository());
  TextEditingController _nameController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  static String onChangeDropDownValueFrequency = "";
  static String dropDownValueFrequency = "";
  bool isEmpty = true;
  List<HabitModel> searchedHabits = [];
  List<HabitModel>? habits;
  @override
  void initState(){
    getHabitsController();
    // habits = Habit_Http_Repository.habitsTest;
    _searchController.addListener(searchedHabit);
    super.initState();
  }

  searchedHabit(){
    print(_searchController.text);
    searchedHabits.clear();
    for(HabitModel habit in habits! ){

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
          addDetailsBottomSheet(context: context);

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
                    title: 'Light/Dark Mode',
                    onTap: () {
                      darkLightBottomSheet();
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
                    getHabitsController();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isEmpty ?
                      habits == null || habits!.isEmpty ?
                      Center(
                        child: EmptyStateWidget(
                            isException: true,
                            isError: true,
                            message: "You have No Habits to Track",
                            icon: null
                        ),
                      ):
                      ListView.builder(
                          itemCount: habits!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (itemBuilder, index){
                            final HabitModel item = habits![index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    viewDetailsBottomSheet(context: context, habit: item);
                                  },
                                  child: CustomTextWithImages(
                                    imageRightColor:
                                    Theme.of(context).colorScheme.primary,
                                    imageLeftColor:
                                    Theme.of(context).colorScheme.primary,
                                    imageLeft: back_arrow,
                                    imageRight: arrow_right,
                                    width: 25,
                                    height: 25,
                                    right: 0,
                                    left: 0,
                                    top: 10,
                                    bottom: 10,
                                    hasNoImages: true,
                                    imageIsRight: true,
                                    textChild: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          // width: 25,
                                          // height: 25,
                                          child: SvgPicture.asset(
                                            time,
                                            // color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: item.name,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {



                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "${item.frequency}",
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {



                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    text: "${item.dateCreated.substring(0,10)}",
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {



                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    text: item.status,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.orange
                                                    ),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {



                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: SvgPicture.asset(
                                            arrow_right,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 0, top: 0),
                                  child: const Divider(
                                    thickness: 0.5,
                                    color: AppColors.disabledButton,
                                  ),
                                ),
                              ],
                            );
                          }
                      ):
                      ListView.builder(
                          itemCount: searchedHabits.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (itemBuilder, index){
                            final HabitModel item = searchedHabits[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    viewDetailsBottomSheet(context: context, habit: item);
                                  },
                                  child: CustomTextWithImages(
                                    imageRightColor:
                                    Theme.of(context).colorScheme.primary,
                                    imageLeftColor:
                                    Theme.of(context).colorScheme.primary,
                                    imageLeft: back_arrow,
                                    imageRight: arrow_right,
                                    width: 25,
                                    height: 25,
                                    right: 0,
                                    left: 0,
                                    top: 10,
                                    bottom: 10,
                                    hasNoImages: true,
                                    imageIsRight: true,
                                    textChild: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          // width: 25,
                                          // height: 25,
                                          child: SvgPicture.asset(
                                            time,
                                            // color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: item.name,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {



                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "${item.frequency}",
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {



                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    text: "${item.dateCreated.substring(0,10)}",
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {



                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    text: item.status,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.orange
                                                    ),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {



                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: SvgPicture.asset(
                                            arrow_right,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 0, top: 0),
                                  child: const Divider(
                                    thickness: 0.5,
                                    color: AppColors.disabledButton,
                                  ),
                                ),
                              ],
                            );
                          }
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  void addDetailsBottomSheet({
    required BuildContext context,
  }) {
    DialogWidgets.customBodyDialog(
        context,
        noDismissIcon: true,
        transparency: MaterialType.transparency,
        child: CustomStatefulBody(
          body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateSB) {
                Size size = MediaQuery.of(context).size;
                return Container(
                    height: size.height/2.0,
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 50,
                          child: Divider(
                            thickness: 4,
                            color: AppColors.disabledButton,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 0, left: 20, top: 20),
                            child: Text(
                              "Add New Habits",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none,
                                  // fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal),
                              textAlign: TextAlign.center,
                            )
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Custom_Shape_Card(
                                      leftMargin: 0,
                                      rightMargin: 0,
                                      backgroundImageOpacity: 1,
                                      hasBackgroundImage: false,
                                      gradientColor1:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor2:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor3:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor4:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      height: size.height / 16,
                                      width: size.width / 1.1,
                                      // height: menuButtonPressed ? size.width * 0.18 : size.width * 0.14,
                                      // width: menuButtonPressed ? size.width * 0.18 : size.width * 0.14,
                                      bottomLeftRadius: 10,
                                      bottomRightRadius: 10,
                                      topLeftRadius: 10,
                                      topRightRadius: 10,
                                      backgroundImageUrl: '',
                                      hasBackGroundColor: true,
                                      hasBorderColor: false,
                                      borderColor:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      borderWidth: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: CustomTextWithImages(
                                          imageRightColor: Theme.of(context).colorScheme.primary,
                                          imageLeftColor: Theme.of(context).colorScheme.primary,
                                          imageLeft: time,
                                          imageRight: arrow_right,
                                          width: 25,
                                          height: 25,
                                          right: 30,
                                          left: 20,
                                          top: 10,
                                          bottom: 10,
                                          hasNoImages: false,
                                          imageIsRight: false,
                                          textChild: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    text:
                                                    "The incoming transfer has been identified and is currently being processed.",
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor: Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {
                                                            // Handle the tap event, e.g., launch a URL
                                                            // For example: launchUrl(Uri.parse('https://example.com'));
                                                            print('Clickable link tapped!');
                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 0, left: 0, top: 20, bottom: 0),
                                    child: Custom_Form_Field_V2(
                                      bgColor: Theme.of(context).colorScheme.secondary,
                                      inputColor: Theme.of(context).colorScheme.primary,
                                      headTextColor: Theme.of(context).colorScheme.primary,
                                      hintColor: Theme.of(context).colorScheme.primary,
                                      onTap: () {

                                      },
                                      hint: 'Type Name of Tracker',
                                      headtext: "Name",
                                      obscureText: false,
                                      // contentPadding: EdgeInsets.zero,
                                      pIcon: SvgPicture.asset(
                                        person_outline,
                                        height: 24,
                                        width: 24,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      keyboardType: TextInputType.text,
                                      fieldType: TextFieldType.others,
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      formIndex: true,
                                      // height: 48,
                                      controller: _nameController,
                                      // headTextColor: AppColors.headerLogin,
                                      onChanged: checkIfAllFieldsAreFilled(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FutureBuilder<List<String>?>(
                                    future: habit_controller.getFrequenciesController(),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        case ConnectionState.done:
                                          if (snapshot.hasError)
                                            return Text(snapshot.error.toString());
                                          else {
                                            return Container(
                                              height: 56,
                                              margin: const EdgeInsets.only(
                                                  left: 0, right: 0, top: 0, bottom: 0),
                                              padding: const EdgeInsets.only(left: 20, right: 12),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.secondaryFixed,
                                                  border: Border.all(
                                                    color: AppColors.steelGray.withOpacity(0.5),
                                                  ),
                                                  borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(8),
                                                      bottomRight: Radius.circular(8),
                                                      topRight: Radius.circular(8),
                                                      topLeft: Radius.circular(8))),
                                              child: DropdownButton(
                                                dropdownColor: Theme.of(context).colorScheme.secondaryFixed,
                                                icon: SvgPicture.asset(
                                                  arrow_right,
                                                    height: 24,
                                                    width: 24,
                                                  color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                underline:
                                                const SizedBox(), //removes the underline
                                                hint: dropDownValueFrequency == ""
                                                    ? Text(
                                                  'Select Frequency',
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    // fontFamily: "Inter"
                                                  ),
                                                )
                                                    : Text(
                                                  dropDownValueFrequency,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    // fontFamily: "Inter"
                                                  ),
                                                ),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                  color: Theme.of(context).colorScheme.primary,
                                                  // fontFamily: "Inter"
                                                ),
                                                items: snapshot.data!.map(
                                                  //(data as List).map(
                                                      (val) {
                                                    return DropdownMenuItem<String>(
                                                      onTap: () {
                                                        setState(() {
                                                          onChangeDropDownValueFrequency = val;
                                                          print(onChangeDropDownValueFrequency);
                                                        });
                                                      },
                                                      value: val,
                                                      child: Text(val),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (val) {
                                                  print(val);
                                                  setState(() {
                                                    dropDownValueFrequency = val!;
                                                  });
                                                },
                                              ),
                                            );
                                          }

                                        default:
                                          return Text('Unhandle State');
                                      }
                                    },
                                  ),

                                ],
                              ),
                            )
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 5),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomButton(
                                    actionText: "",
                                    optionWidget: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Cancel",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headlineSmall
                                                ?.copyWith(fontWeight: FontWeight.w700),
                                          ),
                                          const Gap(ySpace1),
                                          SvgImage(asset: previous, color: Theme.of(context).colorScheme.primary,)
                                        ]),
                                    isOutline: true,
                                    onTap: () async {

                                      Get.back();

                                    }),
                            ),
                            const Gap(20),
                            Expanded(
                                child: CustomButton(
                                    actionText: "",
                                    optionWidget: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Create",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headlineSmall
                                                ?.copyWith(fontWeight: FontWeight.w700),
                                          ),
                                          const Gap(ySpace1),
                                          SvgImage(asset: arrow_right, color: Theme.of(context).colorScheme.primary,)
                                        ]),
                                    isOutline: true,
                                    onTap: () async {

                                      if(_nameController.text.isNotEmpty && dropDownValueFrequency.isNotEmpty) {
                                        HabitModel habitModel = HabitModel
                                            .fromJson({
                                          "name": _nameController.text,
                                          "frequency": dropDownValueFrequency,
                                          "status": "Pending",
                                          "dateCreated": DateTime
                                              .now()
                                              .toString(),
                                          "dateUpdated": DateTime
                                              .now()
                                              .toString(),
                                        });

                                        createHabitsController(
                                          habitModel: habitModel,
                                        );

                                      }else{
                                        Get.snackbar("Fields Required", "All fields are required", backgroundColor: Colors.red);
                                      }



                                    }),
                            )
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 5),
                        )
                      ],
                    )
                );
              }
          ),
        )
    );
  }

  checkIfAllFieldsAreFilled(){

  }

  void viewDetailsBottomSheet({
    required BuildContext context,
    required HabitModel habit,

  }) {
    DialogWidgets.customBodyDialog(
        context,
        noDismissIcon: true,
        transparency: MaterialType.transparency,
        child: CustomStatefulBody(
          body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateSB) {
                Size size = MediaQuery.of(context).size;
                return Container(
                    height: size.height/1.8,
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 50,
                          child: Divider(
                            thickness: 4,
                            color: AppColors.disabledButton,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 0, left: 20, top: 20),
                            child: Text(
                              "Habit Details",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none,
                                  // fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal),
                              textAlign: TextAlign.center,
                            )
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Custom_Shape_Card(
                                      leftMargin: 0,
                                      rightMargin: 0,
                                      backgroundImageOpacity: 1,
                                      hasBackgroundImage: false,
                                      gradientColor1:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor2:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor3:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor4:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      height: size.height / 16,
                                      width: size.width / 1.1,
                                      // height: menuButtonPressed ? size.width * 0.18 : size.width * 0.14,
                                      // width: menuButtonPressed ? size.width * 0.18 : size.width * 0.14,
                                      bottomLeftRadius: 10,
                                      bottomRightRadius: 10,
                                      topLeftRadius: 10,
                                      topRightRadius: 10,
                                      backgroundImageUrl: '',
                                      hasBackGroundColor: true,
                                      hasBorderColor: false,
                                      borderColor:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      borderWidth: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: CustomTextWithImages(
                                          imageRightColor: Theme.of(context).colorScheme.primary,
                                          imageLeftColor: Theme.of(context).colorScheme.primary,
                                          imageLeft: time,
                                          imageRight: arrow_right,
                                          width: 25,
                                          height: 25,
                                          right: 30,
                                          left: 20,
                                          top: 10,
                                          bottom: 10,
                                          hasNoImages: false,
                                          imageIsRight: false,
                                          textChild: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    text:
                                                    "View the details of your habit tracker",
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500),
                                                    // Default style for the entire RichText
                                                    // style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration:
                                                          TextDecoration.underline,
                                                          decorationColor: Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {
                                                            // Handle the tap event, e.g., launch a URL
                                                            // For example: launchUrl(Uri.parse('https://example.com'));
                                                            print('Clickable link tapped!');
                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Custom_Shape_Card(
                                      leftMargin: 00,
                                      rightMargin: 0,
                                      backgroundImageOpacity: 1,
                                      hasBackgroundImage: false,
                                      gradientColor1:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor2:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor3:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      gradientColor4:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      height: size.height / 3.2,
                                      width: size.width / 1.1,
                                      // height: menuButtonPressed ? size.width * 0.18 : size.width * 0.14,
                                      // width: menuButtonPressed ? size.width * 0.18 : size.width * 0.14,
                                      bottomLeftRadius: 10,
                                      bottomRightRadius: 10,
                                      topLeftRadius: 10,
                                      topRightRadius: 10,
                                      backgroundImageUrl: '',
                                      hasBackGroundColor: true,
                                      hasBorderColor: false,
                                      borderColor:
                                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      borderWidth: 1,
                                      child: GestureDetector(
                                        onTap: () {

                                        },
                                        child: CustomTextWithImages(
                                            imageRightColor: Theme.of(context).colorScheme.primary,
                                            imageLeftColor: Theme.of(context).colorScheme.primary,
                                            imageLeft: back_arrow,
                                            imageRight: arrow_right,
                                            width: 25,
                                            height: 25,
                                            right: 10,
                                            left: 10,
                                            top: 10,
                                            bottom: 10,
                                            hasNoImages: true,
                                            imageIsRight: false,
                                            textChild: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          "Name: ",
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          habit.name,
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                                  child: const Divider(
                                                    thickness: 1,
                                                    color: AppColors.disabledButton,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          "Frequency: ",
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          habit.frequency,
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                                  child: const Divider(
                                                    thickness: 1,
                                                    color: AppColors.disabledButton,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          "Status: ",
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          habit.status,
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                                  child: const Divider(
                                                    thickness: 1,
                                                    color: AppColors.disabledButton,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          "Date Created: ",
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          habit.dateCreated,
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                                  child: const Divider(
                                                    thickness: 1,
                                                    color: AppColors.disabledButton,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          "Date Updated: ",
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                          habit.dateUpdated,
                                                          style: Theme.of(context)
                                                              .primaryTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          // Default style for the entire RichText
                                                          // style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                decoration:
                                                                TextDecoration.underline,
                                                                decorationColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),



                                              ],
                                            )
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 1),
                        ),
                        CustomButton(
                            actionText: "",
                            optionWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Done",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const Gap(ySpace1),
                                  SvgImage(asset: previous, color: Theme.of(context).colorScheme.primary,)
                                ]),
                            isOutline: true,
                            onTap: () async {

                              Get.back();

                            }),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 1),
                        )
                      ],
                    )
                );
              }
          ),
        )
    );
  }

  getHabitsController() {
    habit_controller.getHabitsController(
      loading: (isLoading) {
        if (isLoading) {
          OverlayService.showOverlay(context);
        } else {
          OverlayService.hideOverlay(context);
        }
      },
    ).then((value) {
      print("value.success $value");

      setState(() {
        if (value.isNotEmpty) {

          habits = value;

        } else {


        }
      });

    });
  }

  createHabitsController({required HabitModel habitModel}) {
    habit_controller.createHabitsController(
      habitModel: habitModel,
      loading: (isLoading) {
        if (isLoading) {
          OverlayService.showOverlay(context);
        } else {
          OverlayService.hideOverlay(context);
        }
      },
    ).then((value) {
      print("value.success $value");

      setState(() {
        if (value) {

          getHabitsController();

        } else {


        }
      });

    });
  }

  void darkLightBottomSheet() {
    DialogWidgets.customBodyDialog(
        context,
        noDismissIcon: true,
        transparency: MaterialType.transparency,
        child: CustomStatefulBody(
          body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateSB) {
                Size size = MediaQuery.of(context).size;
                return Container(
                    height: size.height/2.8,
                    margin: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Divider(
                              thickness: 4,
                              color: AppColors.disabledButton,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 0, left: 20, top: 24),
                              child: Text(
                                "Display Theme",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.none,
                                    // fontFamily: 'Inter',
                                    fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              )
                          ),
                          const Padding(
                              padding:  EdgeInsets.only(right: 20, left: 20, top: 8),
                              child: Text(
                                "Select the display theme you are confortable with",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.subHeaderLogin,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none,
                                    // fontFamily: 'Helvetica-Neue-Font',
                                    fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              )
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextWithImages(
                            imageRightColor:
                            Theme.of(context).colorScheme.error,
                            imageLeftColor:
                            Theme.of(context).colorScheme.error,
                            imageLeft: add_user,
                            imageRight: add_user,
                            width: 25,
                            height: 25,
                            right: 0,
                            left: 0,
                            top: 10,
                            bottom: 10,
                            hasNoImages: true,
                            imageIsRight: true,
                            textChild: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: SvgPicture.asset(
                                    light,
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    AdaptiveTheme.of(context).setLight();
                                  },
                                  child: RichText(
                                    // textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "Light Mode",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headlineSmall
                                          ?.copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.w500),
                                      // Default style for the entire RichText
                                      // style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headlineSmall
                                              ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                            TextDecoration.underline,
                                            decorationColor:
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {

                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(right: 0),
                                    padding: const EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 2,
                                        color: AdaptiveTheme.of(context).mode.isLight ? AppColors.greenDeep : AppColors.steelGray.withOpacity(0.3),
                                      ),
                                    ),
                                    child: AdaptiveTheme.of(context).mode.isLight ? SvgPicture.asset(
                                      circled_x,
                                      color: AppColors.greenDeep,
                                      height: 10,
                                      width: 10,
                                    ): const SizedBox.shrink()
                                )
                              ],
                            ),
                          ),
                          CustomTextWithImages(
                            imageRightColor:
                            Theme.of(context).colorScheme.error,
                            imageLeftColor:
                            Theme.of(context).colorScheme.error,
                            imageLeft: add_user,
                            imageRight: add_user,
                            width: 25,
                            height: 25,
                            right: 0,
                            left: 0,
                            top: 10,
                            bottom: 10,
                            hasNoImages: true,
                            imageIsRight: true,
                            textChild: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(
                                    dark,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 17,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    AdaptiveTheme.of(context).setDark();
                                  },
                                  child: RichText(
                                    // textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "Dark Mode",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headlineSmall
                                          ?.copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.w500),
                                      // Default style for the entire RichText
                                      // style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headlineSmall
                                              ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                            TextDecoration.underline,
                                            decorationColor:
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {

                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(right: 0),
                                    padding: const EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 2,
                                        color: AdaptiveTheme.of(context).mode.isDark ? AppColors.greenDeep : AppColors.steelGray.withOpacity(0.3),
                                      ),
                                    ),
                                    child: AdaptiveTheme.of(context).mode.isDark ? SvgPicture.asset(
                                      circled_x,
                                      color: AppColors.greenDeep,
                                      height: 10,
                                      width: 10,
                                    ): const SizedBox.shrink()
                                )
                              ],
                            ),
                          ),
                          CustomTextWithImages(
                            imageRightColor:
                            Theme.of(context).colorScheme.error,
                            imageLeftColor:
                            Theme.of(context).colorScheme.error,
                            imageLeft: add_user,
                            imageRight: add_user,
                            width: 25,
                            height: 25,
                            right: 0,
                            left: 0,
                            top: 10,
                            bottom: 10,
                            hasNoImages: true,
                            imageIsRight: true,
                            textChild: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(
                                    system_setting,
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    AdaptiveTheme.of(context).setSystem();
                                  },
                                  child: RichText(
                                    // textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "System Settings",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headlineSmall
                                          ?.copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.w500),
                                      // Default style for the entire RichText
                                      // style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headlineSmall
                                              ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                            TextDecoration.underline,
                                            decorationColor:
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {

                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(right: 0),
                                    padding: const EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 2,
                                        color: AdaptiveTheme.of(context).mode.isSystem ? AppColors.greenDeep : AppColors.steelGray.withOpacity(0.3),
                                      ),
                                    ),
                                    child: AdaptiveTheme.of(context).mode.isSystem ? SvgPicture.asset(
                                      circled_x,
                                      color: AppColors.greenDeep,
                                      height: 10,
                                      width: 10,
                                    ): const SizedBox.shrink()
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    )
                );
              }
          ),
        )
    );

  }

}
