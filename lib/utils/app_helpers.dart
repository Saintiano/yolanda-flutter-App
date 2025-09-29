import 'dart:math';

import 'package:intl/intl.dart';

class AppHelpers {
  static const parsingError =
      "An Error occurred connecting this request, Please try again later!";
  static const exceptionCode = "999";
  static const errorCode = "998";
  static const retryCode = "997";

  static const successCode = "00";
  static const successSecretCode = "90";

  // static String convertNamedDateDisplay(String date) {
  //   final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  //   final DateFormat serverFormater = DateFormat('dd-MMM-yy');
  //   final DateTime displayDate = displayFormater.parse(date);
  //   final String formatted = serverFormater.format(displayDate);
  //   return formatted;
  // }

  static String? validateAmountField(
      {required String amountText,
      required String balance,
      required String limit}) {
    final amount = double.tryParse(amountText);
    final airtimeOrDataLimit = double.tryParse(limit);
    final currentBalance = double.tryParse(balance);
    return switch (amount) {
      null => null,
      _ when currentBalance != null && amount > currentBalance =>
        "Amount exceeds available balance",
      _ when airtimeOrDataLimit != null && amount > airtimeOrDataLimit =>
        "Amount exceeds transaction limit of ${currencyFormatterTwo.format(num.tryParse(limit) ?? 0)}",
      _ => null
    };
  }

  static String generateUniqueReference() {
    var dateFormatter = DateFormat('ddMMyykkmmssss');
    try {
      return 'A${dateFormatter.format(DateTime.now())}${Random.secure().nextInt(10000)}P';
    } catch (e) {
      return generateUniqueReference();
    }
  }

  static removeLeadingZeros(String input) {
    return input.replaceAll(RegExp(r'^0+(?=.)'), '');
  }

  static final currencyFormatter =
      NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 0);
  static final currencyFormatterTwo =
      NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 2);
  static final compactCurrencyFormatter =
      NumberFormat.compactSimpleCurrency(name: 'NGN', decimalDigits: 2);
}

extension StringHelpers on String {
  bool get isPasswordValid => RegExp(
          r"""^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!#$%&'"()*+,-./:;<=>?@[\]^_`{|}~])[A-Za-z\d!#$%&'"()*+,-./:;<=>?@[\]^_`{|}~]{8,15}$""")
      .hasMatch(this);
  bool get passwordHasSmallLetters => contains(RegExp(r'[a-z]'));
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get passwordHasSymbols =>
      RegExp(r"^(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]").hasMatch(this);
  bool get passwordHasNumber => contains(RegExp(r"[0-9]"));
  bool get passwordisValid =>
      containsUppercase &&
      passwordHasSmallLetters &&
      passwordHasSymbols &&
      passwordHasNumber &&
      length >= 8; //TODO(CHANGE TO VARIABLE -- AYOMIDE)
  bool get isValidEmail => RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
      .hasMatch(this);
  String toNaira() {
    return '\u{20A6}$this';
  }

  String toDenominationType() {
    final splitted = split('.');
    final price = splitted[0];
    if (price.length >= 7 && price.length <= 9) {
      return '\u{20A6}${price.substring(0, length - 6)}m';
    } else if (price.length >= 10 && price.length <= 12) {
      return '\u{20A6}${price.substring(0, price.length - 9)}t';
    } else {
      return '\u{20A6}$price';
    }
  }

  String maskEmail() {
    final List<String> texts = split('');

    final len = texts.indexOf("@");
    if (len < 5) {
      return this;
    } else {
      String temp = '';
      int ind = 0;
      for (final String item in texts) {
        if (ind < len - 6) {
          temp += '*';
        } else {
          temp += item;
        }
        ind += 1;
      }
      return temp;
    }
  }

  String toPascalCase() {
    //Some strinngs comes with double whitespace whichn breaks this code which is why i added the replace
    String text = replaceAll("  ", ' ');
    if (length < 1) {
      return this;
    } else {
      String temp = '';
      for (final String item in text.split(' ')) {
        temp +=
            "${item[0].toUpperCase()}${item.substring(1).toLowerCase()}${split(' ').indexOf(item) == split(' ').length - 1 ? '' : ' '}";
      }
      return temp;
    }
  }

  String maskMiddle() {
    final List<String> texts = split('');
    if (texts.length < 2) {
      return this;
    } else {
      String temp = '';
      int ind = 0;
      for (final String item in texts) {
        if (ind > 2 && ind < texts.length - 3) {
          temp += '*';
        } else {
          temp += item;
        }
        ind += 1;
      }
      return temp;
    }
  }

  String firstnLast4() {
    final List<String> texts = split('');
    if (texts.length < 8) {
      return this;
    } else {
      return '${substring(0, 4)}...${substring(length - 4, length)}';
    }
  }

  String last4() {
    final List<String> texts = split('');
    if (texts.length < 8) {
      return this;
    } else {
      return '****${substring(length - 4, length)}';
    }
  }

  String toCardPan() {
    String text = this;
    final string = text.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)}  ");
    return string;
  }

  String toCardExpiry() {
    String text = this;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }
    return buffer.toString();
  }

  String toMonthDate() {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.S");
    final outputFormat = DateFormat("MMM dd, yyyy");

    final dateTime = inputFormat.parse(this).toLocal();

    final date = outputFormat.format(dateTime);

    return date;
  }

  String toDate() {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.S");
    final outputFormat = DateFormat('dd/MM/yy');

    final dateTime = inputFormat.parse(this).toLocal();

    final date = outputFormat.format(dateTime);

    return date;
  }

  //Reverse
  String toFromDate() {
    if (isEmpty) {
      return this;
    }
    final inputFormat = DateFormat('dd/MM/yy');
    final outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.S");

    final dateTime = inputFormat.parse(this).toLocal();

    final date = outputFormat.format(dateTime);

    return date;
  }

  //Wed, Oct 18, 2023
  String toWeekDayFirstNamedDate() {
    DateTime dateTime = DateTime.parse(this).toLocal();

    return DateFormat("E, MMM d, y").format(dateTime);
  }

  ///31/10/23 - 11:00
  String toDateBeforetime() {
    DateTime dateTime = DateTime.parse(this).toLocal();

    return DateFormat("dd/MM/yy - HH:mm").format(dateTime);
  }

  /// "12:00, Sep 17 2023",
  String toTimeFirstNamedDate() {
    DateTime dateTime = DateTime.parse(this).toLocal();

    return DateFormat("HH:mm, MMM d y").format(dateTime);
  }

  String toNumberNamedDate() {
    final dateTime = DateTime.parse(this).toLocal();

    final date = _formatWithOrdinalIndicator(dateTime);

    return date;
  }

  String toTime() {
    final dateTime = DateTime.parse(this);

    final timeFormat = DateFormat("h:mm a");
    final time = timeFormat.format(dateTime);
    return time;
  }

  String toTimeV2() {
    final dateTime = DateTime.parse(this).toLocal();

    final timeFormat = DateFormat("h:mm a");
    final time = timeFormat.format(dateTime);
    return time;
  }

}

String _getOrdinalIndicator(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  } else {
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

String _formatWithOrdinalIndicator(DateTime date) {
  String day = DateFormat('d').format(date);
  String suffix = _getOrdinalIndicator(int.parse(day));

  return DateFormat('d\'$suffix\' MMM, y').format(date);
}
