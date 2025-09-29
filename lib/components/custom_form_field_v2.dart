
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yolanda/styles/app_colors.dart';
// import 'package:pinput/pinput.dart';

import '../constants/constants.dart';
import '../constants/responsiveness.dart';

class Custom_Form_Field_V2 extends StatefulWidget {
  final bool formIndex;
  final bool showCreamFill;
  final bool showPinPrefilledWidget;
  final String? obscuringCharacter;
  final MainAxisAlignment? mainAxisAlignment;
  final Function(String)? onCompleted;
  final VoidCallback? onTap;
  final String hint;
  final _pinPutFocusNode = FocusNode();
  final Color? fillColor;
  final bool useNativeKeyboard;
  final double? width;
  final double? height;
  final Widget? sIcon;
  final Widget? pIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final Function(String?)? validator;
  final TextStyle? hintstyle;
  final Color? hintColor;
  final int? maxline;
  final String? headtext;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextFieldType? fieldType;
  final bool isWordField;
  final bool validate;
  final bool readonly;
  final bool showCursor;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final bool autoFocus;
  final BoxShape? shape;
  final FocusNode? focusNode;
  final int? pinPutFieldCount;
  final List<TextInputFormatter>? inputFormatters;
  final double labelMargin;
  final Color bgColor;
  final Color headTextColor;
  final Color inputColor;

  Custom_Form_Field_V2({
    Key? key,
    this.hint = '',
    this.width,
    this.height,
    this.sIcon,
    this.pIcon,
    this.obscureText = false,
    this.isWordField = true,
    this.maxline,
    this.controller,
    this.contentPadding,
    this.onChanged,
    this.hintstyle,
    this.hintColor,
    this.headtext,
    this.onTap,
    this.keyboardType,
    this.validate = true,
    this.readonly = false,
    this.autoFocus = false,
    this.fieldType,
    this.inputFormatters,
    this.maxLength,
    this.useNativeKeyboard = true,
    this.fillColor,
    this.onCompleted,
    this.showCursor = false,
    this.shape = BoxShape.rectangle,
    this.pinPutFieldCount = 0,
    this.focusNode,
    this.validator,
    this.mainAxisAlignment,
    this.obscuringCharacter,
    this.showCreamFill = true,
    this.showPinPrefilledWidget = true,
    required this.formIndex,
    this.bgColor = const Color(0xFFF5F5F5), //const Color(0xFFFFFDF6),
    this.labelMargin = 0,
    this.headTextColor = AppColors.steelGray,
    this.inputColor = AppColors.black,
  }) : super(key: key);

  @override
  State<Custom_Form_Field_V2> createState() => _Custom_Form_Field_V2State();
}

class _Custom_Form_Field_V2State extends State<Custom_Form_Field_V2> {
  bool changeBorderColor = false;

  @override
  Widget build(BuildContext context) {
    // var keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final BoxDecoration pinPutDecoration = BoxDecoration(
      border: Border.all(
        color: widget.fillColor ?? AppColors.black,
      ),
      shape: widget.shape ?? BoxShape.rectangle,
      borderRadius:
          widget.shape == BoxShape.circle ? null : BorderRadius.circular(2),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.formIndex
            ? widget.headtext == null
                ? const SizedBox.shrink()
                : Text(
                    widget.headtext!,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall
                        ?.copyWith(
                            color: widget.headTextColor,
                            // fontFamily: "Inter"
                    ),
                    // style: Theme.of(context)
                    //     .primaryTextTheme
                    //     .headlineSmall
                    //     ?.copyWith(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.normal,
                    //         color: Theme.of(context).brightness == Brightness.dark
                    //                 ? null
                    //                 : AppColors.gray3
                    // )
                  )
            : const SizedBox.shrink(),
        SizeConfig.spaceTextFieldHeaderLabel,
        SizedBox(
          height: widget.labelMargin,
        ),
        Expanded(
            flex: 0, //height: inputFieldHeight,
            child: widget.isWordField
                ? SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.formIndex
                            ? widget.bgColor
                            : Colors.transparent,
                        // border: Border(
                        //   left: BorderSide(color: Color(0xFF66A681), width: 2),
                        //   right: BorderSide(color: Color(0xFF66A681), width: 2),
                        //   top: BorderSide(color: Color(0xFF66A681), width: 2),
                        //   bottom: BorderSide(color: Color(0xFF66A681), width: 2),
                        // ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          // textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 14,
                          color: widget.inputColor,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                        onTap: widget.onTap,
                        maxLines: widget.maxline ?? 1,
                        maxLength: widget.maxLength,
                        obscureText: widget.obscureText,
                        controller: widget.controller,
                        readOnly: widget.readonly,
                        autofocus: false,
                        focusNode: widget.focusNode,
                        scrollPadding:
                            EdgeInsets.only(bottom: keyboardHeight + 20),
                        enableSuggestions: true,
                        keyboardType: widget.fieldType == TextFieldType.phone ||
                                widget.fieldType == TextFieldType.bvn
                            ? TextInputType.phone
                            : widget.fieldType == TextFieldType.pin ||
                                    widget.fieldType == TextFieldType.amount
                                ? TextInputType.number
                                : widget.keyboardType ?? TextInputType.text,
                        onChanged: (value) {
                          // widget.onChanged!;
                          setState(() {
                            changeBorderColor = true;
                          });

                          print(changeBorderColor);
                        },
                        inputFormatters: (widget.fieldType ==
                                    TextFieldType.phone ||
                                widget.fieldType == TextFieldType.amount ||
                                widget.fieldType == TextFieldType.accountNo ||
                                widget.fieldType == TextFieldType.pin ||
                                widget.fieldType == TextFieldType.bvn)
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ]
                            : widget.inputFormatters,
                        decoration: InputDecoration(
                          focusColor: AppColors.primary,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: changeBorderColor
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary,
                          )),
                          border: const OutlineInputBorder(),
                          counterText: "",
                          contentPadding: widget.contentPadding,
                          filled: true,
                          fillColor: widget.showCreamFill
                              ? AppColors.creamWhite.withOpacity(.1)
                              : widget.readonly == true
                                  ? widget.fillColor ?? AppColors.gray5
                                  : widget.fillColor ??
                                      Theme.of(context).colorScheme.surface,
                          errorMaxLines: 6,
                          prefixIcon: widget.pIcon != null
                              ? Padding(
                                  padding: const EdgeInsets.all(ySpaceMid + 3),
                                  child: widget.pIcon,
                                )
                              : null,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(
                                //width: 50,
                                color: AppColors.textField,
                              )),
                          suffixIcon: widget.sIcon != null
                              ? Padding(
                                  padding: const EdgeInsets.all(ySpaceMid),
                                  child: widget.sIcon,
                                )
                              : null,
                          hintText: !widget.formIndex ? widget.hint : "",
                          hintStyle: widget.hintstyle ?? const TextStyle(color: AppColors.subHeaderLogin),
                        ),
                        validator: (val) {
                          print(val);
                          if (widget.fieldType == TextFieldType.refferal) {
                            return null;
                          }
                          if (val == null) return '\u26A0 Invalid input';
                          if (widget.validator == null) {
                            if (widget.fieldType == TextFieldType.bvn) {
                              if (val.isEmpty) {
                                return '\u26A0 Field cannot be empty';
                              } else if (val.trim().isEmpty) {
                                return "\u26A0 Field cannot be empty";
                              } else if (val.length < 11) {
                                return '\u26A0 Invalid Entry';
                              } else if (int.tryParse(val) == null) {
                                return '\u26A0 Invalid entry';
                              }
                              return null;
                            } else if (widget.fieldType ==
                                TextFieldType.accountNo) {
                              if (val.isEmpty) {
                                return '\u26A0 Field cannot be empty';
                              } else if (val.trim().isEmpty) {
                                return "\u26A0 Field cannot be empty";
                              } else if (val.length < 10) {
                                return '\u26A0 Invalid Entry';
                              } else if (val.length > 10) {
                                return '\u26A0 Invalid Entry';
                              } else if (int.tryParse(val) == null) {
                                return '\u26A0 Invalid entry';
                              }
                              return null;
                            } else if (widget.fieldType == TextFieldType.pin) {
                              if (val.isEmpty) {
                                return '\u26A0 Field cannot be empty';
                              } else if (val.trim().isEmpty) {
                                return "\u26A0 Field cannot be empty";
                              } else if (val.length < 4) {
                                return '\u26A0 Invalid Entry';
                              } else if (int.tryParse(val) == null) {
                                return '\u26A0 Invalid entry';
                              }
                              return null;
                            } else if (widget.fieldType ==
                                TextFieldType.phone) {
                              if (val.isEmpty || val.trim().isEmpty) {
                                return 'Field must not be empty';
                              } else {
                                if (val.length > 3) {
                                  if (val.trim().isEmpty) {
                                    return '\u26A0 Field is required.';
                                  }

                                  final RegExp nameExp = RegExp(
                                      r'^(0)(5|7|8|9){1}(0|1){1}[0-9]{8}$');

                                  if (!nameExp.hasMatch(val.trim())) {
                                    return '\u26A0 Enter only correct Nigeria phone number.';
                                  }
                                  if (val.trim().length != 11) {
                                    return '\u26A0 Field must be of 11 digits';
                                  } else {
                                    return null;
                                  }
                                } else {
                                  return null;
                                }
                              }
                            } else {
                              if (widget.validate) {
                                if (val.isEmpty &&
                                    (widget.fieldType != TextFieldType.pin)) {
                                  return "\u26A0 Field cannot be empty";
                                } else if (val.trim().isEmpty) {
                                  return "\u26A0 Field cannot be empty";
                                } else if (widget.fieldType ==
                                    TextFieldType.amount) {
                                  if (double.tryParse(
                                          val.replaceAll(',', '')) ==
                                      null) {
                                    return '\u26A0 Enter a valid amount';
                                  } else if (double.tryParse(
                                          val.replaceAll(',', ''))! <=
                                      0) {
                                    return '\u26A0 Enter a valid amount';
                                  }
                                } else if (widget.fieldType == TextFieldType.email) {
                                  bool isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val);
                                  return isValidEmail ? null : "\u26A0 Please provide a valid email address";
                                }
                                // else if (widget.fieldType ==
                                //     TextFieldType.setPassword) {
                                //   if (val.isEmpty || val.trim().isEmpty) {
                                //     return '\u26A0 Field must not be empty';
                                //   } else if (val.length < 8) {
                                //     return '\u26A0 Password should not be less 8 characters';
                                //   }
                                //   return null;
                                // }
                                else if (widget.fieldType == TextFieldType.setPassword) {
                                  bool isValidPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val);
                                  var containsUnwantedCharacters = val.contains("£");
                                  var containsUnwantedCharacters2 = val.contains("�");
                                  print(containsUnwantedCharacters);
                                  if(isValidPassword && !containsUnwantedCharacters && !containsUnwantedCharacters2){
                                    return null;
                                  }else if(containsUnwantedCharacters || containsUnwantedCharacters2){
                                    return "\u26A0 Password must not contain these special characters £ or �";
                                  }else{
                                    return "\u26A0 Password must contain at least one special character, one number,\none lower case letter, one upper case letter and between 8 and\n15 characters long";
                                  }

                                  // bool isValidPassword = val.isPasswordValid; //RegExp(r"^(?=.[a-z])(?=.[A-Z])(?=.\d)(?=.[^\da-zA-Z]).{8,15}$").hasMatch(val);
                                  //return isValidPassword ? null : "\u26A0 Password must contain at least one special character,one number,\none lower case letter, one upper case letter and between 8 and\n15 characters long";
                                }
                                else if (widget.fieldType ==
                                    TextFieldType.nin) {
                                  if (val.isEmpty || val.trim().isEmpty) {
                                    return '\u26A0 Field must not be empty';
                                  } else if (val.length < 11) {
                                    return '\u26A0 Invalid entry';
                                  } else if (int.tryParse(val) == null) {
                                    return '\u26A0 Invalid entry';
                                  }
                                  return null;
                                } else if (widget.fieldType ==
                                    TextFieldType.expiry) {
                                  if (val.isEmpty || val.trim().isEmpty) {
                                    return '\u26A0 Field must not be empty';
                                  } else if (val.length < 5) {
                                    return '\u26A0 Invalid entry';
                                  } else if (!val.contains('/')) {
                                    return '\u26A0 Invalid entry';
                                  }
                                  return null;
                                }else if (widget.fieldType == TextFieldType.name) {
                                  final RegExp checkCase = RegExp(r'^[a-zA-Z0-9._@#-]+$');
                                  // final RegExp nameRegExp = RegExp('[a-zA-Z]'); // name and number allowed
                                  final RegExp nameRegExp = RegExp(r"^[a-zA-Z]+$");
                                  // allow only @#_- and . as special character for username
                                  if (val.isEmpty || val.trim().isEmpty) {
                                    return '\u26A0 Field must not be empty';
                                  } else if (!nameRegExp.hasMatch(val.trim())) {
                                    return '\u26A0 special characters and numbers are not allowed';
                                  }
                                  return null;
                                }else if (widget.fieldType == TextFieldType.userName) {
                                  final RegExp checkCase = RegExp(r'^[a-zA-Z0-9._@#-]+$');
                                  // allow only @#_- and . as special character for username
                                  if (val.isEmpty || val.trim().isEmpty) {
                                    return '\u26A0 Field must not be empty';
                                  } else if (val.length < 5) {
                                    return '\u26A0 Invalid entry, username must be at least 5 letters';
                                  } else if (!checkCase.hasMatch(val.trim())) {
                                    return '\u26A0 these characters /~`!^&*()+={}[]|\:;"<>,%?\$ are not allowed';
                                  }
                                  return null;
                                }else if (widget.fieldType == TextFieldType.userNameLogin) {
                                  final RegExp checkCase = RegExp(r'^[a-zA-Z0-9._@#-]+$');
                                  // allow only @#_- and . as special character for username
                                  if (val.isEmpty || val.trim().isEmpty) {
                                    return '\u26A0 Field must not be empty';
                                  }else if (!checkCase.hasMatch(val.trim())) {
                                    return '\u26A0 these characters /~`!^&*()+={}[]|\:;"<>,%?\$ are not allowed';
                                  }
                                  return null;
                                }
                                else if (widget.fieldType ==
                                    TextFieldType.cvv) {
                                  if (val.isEmpty || val.trim().isEmpty) {
                                    return '\u26A0 Field must not be empty';
                                  } else if (val.length < 3) {
                                    return '\u26A0 Invalid entry';
                                  }
                                  return null;
                                }
                              }

                              return null;
                            }
                          } else {
                            return widget.validator!(val);
                          }
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink()
            // Theme(
            //     data: Theme.of(context).copyWith(
            //         inputDecorationTheme: const InputDecorationTheme(
            //       filled: false,
            //     )),
            //     child: Pinput(
            //         length: widget.pinPutFieldCount! > 0
            //             ? widget.pinPutFieldCount!.toInt()
            //             : pinCodeFieldLength,
            //         validator: (val) {
            //           if (val == null) return 'Invalid input';
            //           if (widget.pinPutFieldCount! < 1
            //               ? val.length < pinCodeFieldLength
            //               : val.length < widget.pinPutFieldCount!) {
            //             return 'Complete the Pin Fields';
            //           }
            //           return null;
            //         },
            //         defaultPinTheme: PinTheme(
            //             width: widget.width ?? 45,
            //             height: widget.height ?? 50,
            //             textStyle: Theme.of(context)
            //                 .primaryTextTheme
            //                 .displaySmall!
            //                 .copyWith(
            //                     fontSize: 18, fontWeight: FontWeight.w300),
            //             decoration: pinPutDecoration),
            //         onCompleted: widget.onCompleted,
            //         obscuringCharacter:
            //             widget.obscuringCharacter ?? '*', //●
            //         mainAxisAlignment: widget.mainAxisAlignment ??
            //             MainAxisAlignment.center,
            //         obscureText: true,
            //         controller: widget.controller,
            //         pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            //         autofocus: widget.autoFocus,
            //         focusNode: widget._pinPutFocusNode,
            //         preFilledWidget: widget.showPinPrefilledWidget
            //             ? Container(
            //                 height: 35,
            //                 width: 30,
            //                 decoration: const BoxDecoration(
            //                   border: Border(
            //                     bottom: BorderSide(
            //                         width: 1.5, color: AppColors.black),
            //                   ),
            //                 ),
            //               )
            //             : null),
            //   )
            ),
      ],
    );
  }
}
