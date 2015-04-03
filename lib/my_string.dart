part of sg2o;

/// Parses a number from a [String].
/// This might only work with one number in the string.
int parseNumber(String stringWithNumber) {
    var regexp = new RegExp(r'\d+');
    int number = int.parse(regexp.allMatches(stringWithNumber.replaceAll(',', '')).first.group(0));
    return number;
}

/// This takes a [String] of the format "<amount> <time-unit> ... " and returns it. E.g. "1 hour abc" returns "1 hour".
String parseTime(String stringWithTime) {
    int amount = parseNumber(stringWithTime);
    return amount.toString() + ' ' + stringWithTime.split(' ').elementAt(1);
}

/// Parses the giveaway ID from the [link]. ("http://www.steamgifts.com/giveaway/o7BRU/deus-ex-game-of-the-year-edition" -> "o7BRU")
String parseIdFromLink(String link) {
    var urlParts = link.split('/');
    return urlParts[2];
}