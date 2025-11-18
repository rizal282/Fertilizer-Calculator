import 'package:logger/logger.dart';

String decimalTextContainsCommaFormatter(String value) {
  var logger = Logger();

  logger.i("VALUE DECIMAL AWAL ==>>>> $value");

  if( value.isEmpty){
    return '0.0';
  }

  if(value.contains(",")){
    final newValue = value.replaceAll(",", ".");

    logger.i("VALUE DECIMAL AFTER FORMAT ====>>> $newValue");

    return newValue;
  }

  return value;
}