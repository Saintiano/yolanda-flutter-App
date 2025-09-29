
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yolanda/constants/constants.dart';
import 'package:yolanda/constants/responsiveness.dart';
import 'package:yolanda/styles/app_colors.dart';
import 'package:yolanda/utils/amount_input_formatter.dart';
import 'package:yolanda/utils/app_helpers.dart';

@immutable
class CustomField extends StatelessWidget {
  const CustomField(
      {Key? key,
      this.hint = '',
      this.width,
      this.height,
      this.sIcon,
      this.pIcon,
      this.obscureText = false,
      this.isWordField = true,
      this.maxline,
      this.controller,
      this.compareController,
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
      this.headTextSapcing,
      this.headTextStyle,
      this.sIconVerticalPadding,
      this.sHorizontalIconPadding,
      this.pIconVerticalPadding,
      this.pHorizontalIconPadding,
      this.showBorder = true,
      this.seperatorBuilder,
      this.autovalidateMode,
      this.showPinPrefilledWidget = true})
      : super(key: key);
  final double? headTextSapcing;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? headTextStyle;
  final bool showBorder;
  final double? sIconVerticalPadding;
  final double? sHorizontalIconPadding;
  final double? pIconVerticalPadding;
  final double? pHorizontalIconPadding;
  final bool showPinPrefilledWidget;
  final String? obscuringCharacter;
  final MainAxisAlignment? mainAxisAlignment;
  final Function(String)? onCompleted;
  final VoidCallback? onTap;
  final String hint;
  final Color? fillColor;
  final bool useNativeKeyboard;
  final double? width;
  final double? height;
  final Widget? sIcon;
  final Widget? pIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final TextEditingController? compareController;
  final Function(String?)? validator;
  final TextStyle? hintstyle;
  final Color? hintColor;
  final int? maxline;
  final String? headtext;
  final bool obscureText;
  final Widget Function(BuildContext, int)? seperatorBuilder;
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
  final int pinPutFieldCount;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headtext != null) ...[
          Text(headtext!,
              style: headTextStyle ??
                  Theme.of(context)
                      .primaryTextTheme
                      .headlineSmall
                      ?.copyWith(
                      fontFamily: 'Poppins'
                  )),
          if (headTextSapcing != null)
            Gap(headTextSapcing!)
          else
            SizeConfig.space,
        ],
        Expanded(
            flex: 0,
            child: isWordField
                ? SizedBox(
                    width: width,
                    height: height,
                    child: TextFormField(
                      style: TextStyle(color: hintColor),
                      onTap: onTap,
                      maxLines: maxline ?? 1,
                      maxLength: maxLength,
                      obscureText: obscureText,
                      controller: controller,
                      readOnly: readonly,
                      autofocus: false,
                      focusNode: focusNode,
                      autovalidateMode: autovalidateMode,
                      scrollPadding:
                          EdgeInsets.only(bottom: keyboardHeight + 20),
                      enableSuggestions: true,
                      keyboardType: fieldType == TextFieldType.phone
                          ? TextInputType.phone
                          : (fieldType == TextFieldType.phone ||
                                  fieldType == TextFieldType.accountNumber ||
                                  fieldType == TextFieldType.amount ||
                                  fieldType == TextFieldType.pin ||
                                  fieldType == TextFieldType.cvv ||
                                  fieldType == TextFieldType.nairaAmount ||
                                  fieldType == TextFieldType.bvn)
                              ? TextInputType.number
                              : keyboardType ?? TextInputType.text,
                      onChanged: onChanged,
                      inputFormatters: fieldType == TextFieldType.nairaAmount
                          ? [
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.deny(RegExp(r'^0')),
                              AmountInputFormatter()
                            ]
                          : (fieldType == TextFieldType.phone ||
                                      fieldType ==
                                          TextFieldType.accountNumber ||
                                      fieldType == TextFieldType.amount ||
                                      fieldType == TextFieldType.pin ||
                                      fieldType == TextFieldType.cvv ||
                                      fieldType == TextFieldType.bvn) &&
                                  inputFormatters == null
                              ? <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]
                              : inputFormatters,
                      decoration: InputDecoration(
                        counterText: "",
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.red)),
                        contentPadding: contentPadding,
                        filled: true,
                        fillColor: fillColor ?? Theme.of(context).colorScheme.secondaryFixed,
                        errorMaxLines: 6,
                        prefixIcon: pIcon != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: pIconVerticalPadding ?? ySpaceMid,
                                    horizontal:
                                        pHorizontalIconPadding ?? ySpaceMid),
                                child: pIcon,
                              )
                            : null,
                        focusColor: Theme.of(context).colorScheme.primary,
                        border: showBorder
                            ? null
                            : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                        ),
                        enabledBorder: showBorder
                            ? null
                            : OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                        focusedBorder: showBorder
                            ? null
                            : OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                        suffixIcon: sIcon != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: sIconVerticalPadding ?? ySpaceMid,
                                    horizontal:
                                        sHorizontalIconPadding ?? ySpaceMid),
                                child: sIcon,
                              )
                            : null,
                        hintText: hint,
                        hintStyle: hintstyle ??
                            Theme.of(context)
                                .inputDecorationTheme
                                .hintStyle
                                ?.copyWith(color: hintColor),
                      ),
                      validator: (val) {
                        if (fieldType == TextFieldType.refferal) return null;
                        if (val == null) return 'Invalid input';
                        if (validator == null) {
                          if (fieldType == TextFieldType.bvn) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 11) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.accountNumber) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 10) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.pin) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 4) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.phone) {
                            if (val.isEmpty || val.trim().isEmpty) {
                              return 'Field must not be empty';
                            } else if (val.length < phoneNumberFieldLength) {
                              return 'Invalid entry';
                            } else if (int.tryParse(val.replaceAll('+', '')) ==
                                null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else {
                            if (validate) {
                              if (val.isEmpty &&
                                  (fieldType != TextFieldType.pin)) {
                                return "Field cannot be empty";
                              } else if (val.trim().isEmpty) {
                                return "Field cannot be empty";
                              } else if (fieldType == TextFieldType.amount) {
                                if (double.tryParse(val.replaceAll(',', '')) ==
                                    null) {
                                  return 'Enter a valid amount';
                                } else if (double.tryParse(
                                        val.replaceAll(',', ''))! <=
                                    0) {
                                  return 'Enter a valid amount';
                                }
                              } else if (fieldType == TextFieldType.email) {
                                bool isValidEmail = RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(val);
                                return isValidEmail
                                    ? null
                                    : "Please provide a valid email address";
                              } else if (fieldType ==
                                  TextFieldType.setPassword) {
                                bool isValidPassword = val
                                    .isPasswordValid; //RegExp(r"^(?=.[a-z])(?=.[A-Z])(?=.\d)(?=.[^\da-zA-Z]).{8,15}$").hasMatch(val);
                                return isValidPassword
                                    ? null
                                    : "Password must contain at least one special character,one number,\none lower case letter, one upper case letter and between 8 and\n15 characters long";
                              } else if (fieldType == TextFieldType.nin) {
                                if (val.isEmpty || val.trim().isEmpty) {
                                  return 'Field must not be empty';
                                } else if (val.length < 11) {
                                  return 'Invalid entry';
                                } else if (int.tryParse(val) == null) {
                                  return 'Invalid entry';
                                }
                                return null;
                              } else if (fieldType == TextFieldType.expiry) {
                                if (val.isEmpty || val.trim().isEmpty) {
                                  return 'Field must not be empty';
                                } else if (val.length < 5) {
                                  return 'Invalid entry';
                                } else if (!val.contains('/')) {
                                  return 'Invalid entry';
                                }
                                return null;
                              } else if (fieldType == TextFieldType.cvv) {
                                if (val.isEmpty || val.trim().isEmpty) {
                                  return 'Field must not be empty';
                                } else if (val.length < 3) {
                                  return 'Invalid entry';
                                }
                                return null;
                              }
                            }

                            return null;
                          }
                        } else {
                          return validator!(val);
                        }
                      },
                    ),
                  )
                : PinCodeTextField(
                    length: pinPutFieldCount > 0
                        ? pinPutFieldCount.toInt()
                        : pinCodeFieldLength,
                    separatorBuilder: seperatorBuilder,
                    validator: (val) {
                      if (val == null) return 'Invalid input';
                      if (pinPutFieldCount < 1
                          ? val.length < pinCodeFieldLength
                          : val.length < pinPutFieldCount) {
                        return 'Complete the Pin Fields';
                      }
                      return null;
                    },

                    cursorColor: fillColor,
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 50),
                    enableActiveFill: fillColor != null,

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: height ?? 56,
                      fieldWidth: width ?? 48,
                      borderWidth: 1.0,
                      fieldOuterPadding: contentPadding,
                      activeFillColor: fillColor,
                      disabledColor: fillColor,
                      activeColor: fillColor,
                      inactiveColor: fillColor,
                      selectedColor: fillColor,
                      // errorBorderColor: fillColor,
                      selectedFillColor: fillColor,
                      inactiveFillColor: fillColor,
                    ),
                    textStyle: Theme.of(context)
                        .primaryTextTheme
                        .displaySmall!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w300),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onCompleted: onCompleted,
                    obscuringCharacter: obscuringCharacter ?? '*', //●
                    mainAxisAlignment:
                        mainAxisAlignment ?? MainAxisAlignment.center,
                    obscureText: true,
                    autoDismissKeyboard: true,
                    keyboardType: TextInputType.number,
                    controller: controller,
                    focusNode: focusNode,
                    autoFocus: autoFocus,
                    // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,

                    appContext: context,
                  )),
        // if (fieldType != null &&
        //     fieldType == TextFieldType.validatePassword &&
        //     controller != null)
        //   PasswordValidatorWidget(controller: controller!),
        // if (fieldType != null &&
        //     fieldType == TextFieldType.confirmPassword &&
        //     controller != null &&
        //     compareController != null)
        //   ConfirmPasswordErrorWidget(
        //     mainController: controller!,
        //     watchController: compareController!,
        //   )
      ],
    );
  }
}
