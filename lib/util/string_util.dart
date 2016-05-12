part of sg2o;

/// Class for string utility functions.
class StringUtil {

    /// Replaces spaces in a game name to make it compatible for html id.
    static String gameNameToIdCompatibleString(String gameName) {
        return gameName.replaceAll(' ', '-').replaceAll(new RegExp('[^-a-zA-Z0-9]'), '');
    }
}