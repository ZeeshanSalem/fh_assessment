import 'dart:math';

import 'package:intl/intl.dart';

class Utils {

  static String getTransactionTime(String date) {
    DateTime? dateTime = DateTime.tryParse(date);
    if(dateTime != null){
      String formattedDate = DateFormat("dd, MMM yyyy hh:mm a").format(dateTime.toLocal());

      return formattedDate;
    }
    return '';
  }

  static String generateTransactionID() {
    // Get current timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Generate a random number
    String randomNumber = Random().nextInt(100000).toString().padLeft(5, '0');

    // Combine timestamp and random number
    return '$timestamp-$randomNumber';
  }
}