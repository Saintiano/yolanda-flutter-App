import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';


class ValidatorsController extends GetxController {

  // create a reusable instance
  final requiredValidator = RequiredValidator(errorText: 'this field is required');
  final miniLengthValidator = MinLengthValidator(6, errorText: "Password must contain atleast 6 characters");
  final maxLengthValidator = MaxLengthValidator(15, errorText: "Password cannot be more 15 characters");
  final passwordPatternValidator = PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: "Password must have atleast one special character");
  final emailValidator = EmailValidator(errorText: "Please enter a valid email address");
  final phoneValidator = PatternValidator(r'^((+|00)?218|0?)?(9[0-9]{8})$', errorText: "Please enter a valid email address");
  final miniLengthPhoneNumberValidator = MinLengthValidator(10, errorText: "Phone Number Should Be 11 characters");
  final maxLengthPhoneNumberValidator = MaxLengthValidator(10, errorText: "Phone Number Should Not Be More Than 11 characters");

  bool isFieldEmpty(String fieldValue) => fieldValue.isEmpty ?? true;

  String? validateName(String? value) {
    if (value!.trim().isEmpty) return 'Field is required.';
    final RegExp nameExp = RegExp(r'^[A-za-z. ]+$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? validateDropDown(String? value) {
    value!.isEmpty ? 'field required' : null;
    return null;
  }

  static String? validateValidIdNumber(String? value) {
    if (value!.trim().isEmpty) return 'Field is required.';
    if (value.trim().length <= 8) {
      return 'Please enter a valid Means of Identification Number.';
    }
    return "Valid identification number";
  }

  static String? validateMobile(String? value) {
    //Indian Mobile number are of 10 digit only
    if (value!.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  String? validateAddress(String? value) {
    if (value!.trim().isEmpty) return 'Field is required.';
    if (value.trim().length <= 8) {
      return 'Please enter a valid address.';
    }
    return "Valid address";
  }

  String? validateEmail(String? value) {
    if (value!.trim().isEmpty) return 'Field is required.';
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return 'Enter Valid Email';
    } else {
      return 'Email Valid';
    }
  }

  bool? passwordValidationToast(TextEditingController? controller) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$';
    RegExp regex = RegExp(pattern.toString());
    if (controller!.text.isEmpty) {
      Get.snackbar("Password", "Please enter password.");
      return false;
    } else if (!regex.hasMatch(controller.text.trim())) {
      Get.snackbar("Password",'Password should contain at least one upper case, at least one lower case, at least one digit and at least one Special character and minimum of 8 characters',
      );
      return false;
    } else {
      return true;
    }
  }



  String? validatePassword(String? value) {
    if (value!.trim().isEmpty || value.trim().length < 4) {
      return 'Please enter password.';
    }
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$';
    RegExp regex =  RegExp(pattern.toString());

    // if (!regex.hasMatch(value.trim()))
    //   return 'Password should contain at least one upper case';
    // else
    // if (!RegExp(r'^(?=.*?[a-z])$').hasMatch(value.trim()))
    //   return 'Password should contain at least one lower case';
    // else
    // if (!RegExp(r'^(?=.*?[#?!@$%^&*-])$').hasMatch(value.trim()))
    //   return 'Password should contain at least one Special character';
    // else
    // if (!RegExp(r'^.{8,}$').hasMatch(value.trim()))
    //   return 'Password must have minimum of 8 characters';
    // else
    // if (!regex.hasMatch(value.trim()))
    //   return 'Password should contain at least one upper case, at least one lower case, at least one digit and at least one Special character and minimum of 8 characters';
    // else
    return "Password is valid";
  }

  static String? validateNumber(String? value) {
    if (value!.trim().isEmpty) return 'Field is required.';
    final RegExp nameExp = RegExp(r'^[-0-9 ]+$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only numeric characters.';
    }else if (value.trim().length != 11) {
      return 'Field must be of 11 digits';
    }else {
      return null;
    }
  }

  String? validatePhoneNumber(String? value) {
    if (value!.trim().isEmpty) return 'Field is required.';
    final RegExp nameExp = RegExp(r'^(?:[+0])?[0-9]{10}$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only correct phone number.';
    }
    if (value.trim().length != 11) {
      return 'Field must be of 11 digits';
    } else {
      return null;
    }
  }

  String? validateAccountNumber(String? value) {
    if (value!.trim().isEmpty) return 'Field is required.';
    final RegExp nameExp = RegExp(r'^(?:[+0])?[0-9]{10}$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only correct phone number.';
    }
    if (value.trim().length != 10) {
      return 'Field must be of 10 digits';
    } else {
      return "Account number valid";
    }
  }

  String? validateString(dynamic value) {
    if (value.toString().trim().isEmpty) {
      return 'Field is required.';
    } else {
      return "String is valid";
    }
  }


  String validateTransactionPin(dynamic value) {
    if (value.toString().trim().isEmpty) return 'Field is required.';
    if (value.toString().trim().length < 4) {
      return 'Field must be of 4 digits.';
    } else {
      return "Transaction Pin valid";
    }
  }

  String validateOtp(dynamic value) {
    if (value.toString().trim().isEmpty) return 'Field is required.';
    if (value.toString().trim().length <= 6) {
      return 'Field must be of 6 digits.';
    } else {
      return "OTP is valid";
    }
  }

  bool spinnerVaidation(TextEditingController controller, String text) {
    if (controller.text.isEmpty) {
      Get.snackbar("Spinner", text);
      return false;
    } else {
      return true;
    }
  }
}