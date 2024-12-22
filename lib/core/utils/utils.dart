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
}