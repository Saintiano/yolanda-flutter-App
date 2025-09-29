import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import 'package:yolanda/components/image_widgets.dart';
import 'package:yolanda/components/menu_dropdown.dart';
import 'package:yolanda/constants/constants.dart';
import 'package:yolanda/constants/responsiveness.dart';
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

  TextEditingController _nameController = TextEditingController();
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
                    height: size.height/1.9,
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
                                      // pIcon: SvgPicture.asset(
                                      //   username_icon,
                                      //   height: 24,
                                      //   width: 24,
                                      // ),
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
                                ],
                              ),
                            )
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 1),
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

                                      Get.back();

                                    }),
                            )
                          ],
                        ),
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

  checkIfAllFieldsAreFilled(){

  }

  void viewDetailsBottomSheet({
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
                    height: size.height/1.2,
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
                            padding: const EdgeInsets.only(right: 0, left: 20, top: 0),
                            child: Text(
                              "Transaction Details",
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
                                      height: size.height / 1.6,
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
                                                          "Pending",
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
                                                          "Transaction Type: ",
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
                                                          "NIP INWARD TRANSACTION",
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
                                                          "Transaction Amount: ",
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
                                                          "₦10,000.50",
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
                                                          "Sender Name: ",
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
                                                          "Sefunmi Afere",
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
                                                          "Sending Bank: ",
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
                                                          "Sterling Bank",
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
                                                          "Transaction Date: ",
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
                                                          "01/02/2024",
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
                                                          "Credited Account: ",
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
                                                          "0012345678",
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
                                                          "Account Name: ",
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
                                                          "ABC Group",
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
                                                          "Remark: ",
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
                                                          "Funds",
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
                                                          "Session ID: ",
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
                                                          "000001240201183319744920658494",
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


}
