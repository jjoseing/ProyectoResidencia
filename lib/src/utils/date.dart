import 'package:intl/intl.dart';

class Format{
  static String toMonthDayDate(DateTime date){
   return DateFormat('MM-dd').format(date);

  }
}