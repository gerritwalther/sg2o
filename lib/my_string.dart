part of sg2o;

/**
 * This only works with one number in the string.
 */
int parseNumber(String stringWithNumber) {
  var regexp = new RegExp(r'\d+');
  int number = int.parse(regexp.allMatches(stringWithNumber.replaceAll(',', '')).first.group(0));
  return number;
}

/**
 * This takes a string of the format "<amount> <time-unit> ... " and returns it. E.g. "1 hour abc" returns "1 hour".
 */
String parseTime(String stringWithTime) {
  int amount = parseNumber(stringWithTime);
  return amount.toString() + ' ' + stringWithTime.split(' ').elementAt(1);
}