part of sg2o;

/// Class for utility functions in category time.
class TimeUtil {

    TimeUtil() {
    }

    /// kudos to http://stackoverflow.com/a/3177838/1004795 and http://stackoverflow.com/a/23259289/1004795
    String timeSince(DateTime date) {
        num seconds = ((new DateTime.now().millisecondsSinceEpoch -
            date.millisecondsSinceEpoch) / 1000).floor();
        String intervalType;

        num interval = (seconds / 31536000).floor();
        if (interval >= 1) {
            intervalType = 'year';
        } else {
            interval = (seconds / 2592000).floor();
            if (interval >= 1) {
                intervalType = 'month';
            } else {
                interval = (seconds / 86400).floor();
                if (interval >= 1) {
                    intervalType = 'day';
                } else {
                    interval = (seconds / 3600).floor();
                    if (interval >= 1) {
                        intervalType = 'hour';
                    } else {
                        interval = (seconds / 60).floor();
                        if (interval >= 1) {
                            intervalType = 'minute';
                        } else {
                            intervalType = 'second';
                        }
                    }
                }
            }
        }

        if (interval > 1 || interval == 0) {
            intervalType += 's';
        }
        return '$interval $intervalType ago';
    }
}