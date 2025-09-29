
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:yolanda/components/colored_back_icon.dart';
import 'package:yolanda/constants/constants.dart';

import '../../constants/svgs.dart';


class Custom_App_Bar_Nav_V3 extends StatefulWidget {
  final String title;
  final bool buttonIsLeading;
  final bool noNavbutton;
  final Function? customNavigate;
  final bool noImage;
  final double fontSize;
  final bool titleIsBold;
  final bool isDashboard;
  final bool isNotDashboardTabs;
  final bool hasBackButton;
  final bool titleIsAtTheBeginning;
  final double leftMargin;
  final double rightMargin;
  final Color? colorBg;
  final bool? menuIsWidget;
  final Widget? menuWidget;
  final Function? onTapMenu;
  final Function? onTapNotifications;
  final Function? onTapQuestions;

  const Custom_App_Bar_Nav_V3(
      {Key? key,
      required this.title,
      required this.buttonIsLeading,
      required this.fontSize,
      required this.noNavbutton,
      required this.titleIsBold,
      this.leftMargin = 25,
      this.colorBg,
      this.noImage = true,
      this.isNotDashboardTabs = true,
      this.titleIsAtTheBeginning = false,
      this.hasBackButton = false,
      this.rightMargin = 25,
      this.customNavigate,
      this.menuIsWidget,
      this.menuWidget,
      this.onTapMenu,
      this.onTapNotifications,
      this.onTapQuestions,
      this.isDashboard = false})
      : super(key: key);

  @override
  State<Custom_App_Bar_Nav_V3> createState() => _Custom_App_Bar_Nav_V3State();
}

class _Custom_App_Bar_Nav_V3State extends State<Custom_App_Bar_Nav_V3> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width * 0.15,
      color: widget.colorBg ?? Theme.of(context).colorScheme.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.hasBackButton ?
          Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.only(left: 5),
              margin: EdgeInsets.only(left: widget.leftMargin),
              decoration: BoxDecoration(
                  border: Border(
                    left:
                    BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                    right:
                    BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                    top: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                    bottom:
                    BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.secondary),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  tooltip: 'Return',
                  onPressed: () {
                    if (widget.isDashboard) {
                      Get.back();
                    } else {
                      Get.back();
                    }
                  },
                ),
              )):
          const SizedBox.shrink(),
          widget.titleIsAtTheBeginning ?
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(widget.title,
                  style: TextStyle(
                    // fontFamily: 'Inter',
                      fontWeight: widget.titleIsBold
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: widget.fontSize
                  )
              ),
            )
          ):
          const SizedBox.shrink(),
          widget.titleIsAtTheBeginning ?
          const Spacer():
          const SizedBox.shrink(),
          widget.titleIsAtTheBeginning ?
          const SizedBox.shrink():
          Container(
            child: widget.noNavbutton ?
            const SizedBox.shrink() :
            widget.buttonIsLeading ?
            Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.only(left: 5),
                        margin: EdgeInsets.only(left: widget.leftMargin),
                        decoration: BoxDecoration(
                            border: Border(
                              left:
                                  BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                              right:
                                  BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                              top: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                              bottom:
                                  BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                            ),
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).colorScheme.secondary),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            tooltip: 'Return',
                            onPressed: () {
                              if (widget.isDashboard) {
                                Get.back();
                              } else {
                                Get.back();
                              }
                            },
                          ),
                        )) :
            SizedBox(
              width: widget.noNavbutton ? 0 : size.width * 0.15,
              height: size.width * 0.15,
            ),
          ),
          widget.titleIsAtTheBeginning ?
          const SizedBox.shrink():
          Expanded(
              flex: 1,
              child: Center(
                child: widget.noImage
                    ? SvgPicture.asset(
                        logo,
                        color: Theme.of(context).colorScheme.primary,
                        height: 53,
                        width: 42,
                      )
                    : Text(widget.title,
                        style: TextStyle(
                            // fontFamily: 'Inter',
                            fontWeight: widget.titleIsBold
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: widget.fontSize
                        )
                ),
              )
          ),
          SizedBox(
            width: widget.noNavbutton ? 0 : widget.isNotDashboardTabs ? size.width * 0.13 : 0,
            height: size.width * 0.15,
          ),
          Container(
            child: widget.noNavbutton ?
            const SizedBox.shrink() :
            widget.buttonIsLeading ?
            const SizedBox.shrink() :
            widget.isNotDashboardTabs ?
            widget.menuIsWidget! ?
            widget.menuWidget :
            Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(right: widget.rightMargin),
                        decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary, width: 1),
                              right: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary, width: 1),
                              top: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary, width: 1),
                              bottom: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary, width: 1),
                            ),
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).colorScheme.secondary),
                        child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Theme.of(context).colorScheme.primary,
                            size: 25,
                          ),
                          tooltip: 'Return',
                          onPressed: () {
                            if(widget.onTapMenu != null){
                              widget.onTapMenu!();
                            }
                          },
                        ),
                      ):
            Row(
              children: [
                const Gap(ySpace1),
                GestureDetector(
                  onTap: () {
                    // CustomRouter(Routes.bulkTransfer, ref).navigateTo();
                    // Get.to(
                    //       () => const Actions_Settings(),
                    //   fullscreenDialog: false,
                    //   popGesture: true,
                    //   transition: Transition.rightToLeftWithFade,
                    //   duration: const Duration(milliseconds: 700),
                    // );

                    if(widget.onTapNotifications != null){
                      widget.onTapNotifications!();
                    }

                  },
                  child: ColoredBackIcon(
                      height: 35,
                      width: 35,
                      icon: notifications,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 0,),
                GestureDetector(
                  onTap: () {
                    // CustomRouter(Routes.bulkTransfer, ref).navigateTo();
                    // Get.to(
                    //       () => const Actions_Settings(),
                    //   fullscreenDialog: false,
                    //   popGesture: true,
                    //   transition: Transition.rightToLeftWithFade,
                    //   duration: const Duration(milliseconds: 700),
                    // );
                    if(widget.onTapQuestions != null){
                      widget.onTapQuestions!();
                    }
                  },
                  child: ColoredBackIcon(
                      height: 35,
                      width: 35,
                      icon: question_help,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 20,),
              ],
            )
          )
        ],
      ),
    );

  }
}
