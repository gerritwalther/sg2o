part of sg2o;

class ColorSetting {

    String title;
    String storageKey;
    Element inputContainer;
    InputElement inputColor;

    ColorSetting (String title, String storageKey) {
        this.title = title;
        this.storageKey = storageKey;

        inputContainer = createColorSetting(this.title, this.storageKey);
    }

    Element createColorSetting(String name, String colorKey) {
        DivElement colorSetting = new DivElement();
        inputColor = new InputElement();

        inputColor.type = 'color';
        inputColor.value = loadColor(colorKey);

        colorSetting.text = name;
        colorSetting.classes.add(classSettingsColorInput);
        colorSetting.append(inputColor);

        return colorSetting;
    }

    String loadColor(String key) {
        if (storage.containsKey(key)) {
            return storage.get(key);
        } else {
            return getDefaultColor(key);
        }
    }

    void store() {
        storage.add(storageKey, inputColor.value);
    }

    void restoreDefault() {
        String defaultColor = getDefaultColor(storageKey);
        storage.add(storageKey, defaultColor);
        inputColor.value = defaultColor;
    }

    String getDefaultColor(String key) {
        String result = '';
        switch (key) {
            case wishListColorKey:
                result = wishListColor;
                break;
            case whiteListColorKey:
                result = whiteListColor;
                break;
            case groupColorKey:
                result = groupColor;
                break;
            case contributorAboveLevelColorKey:
                result = contributorAboveLevelColor;
                break;
            case contributorBelowLevelColorKey:
                result = contributorBelowLevelColor;
                break;
            default:
                break;
        }
        return result;
    }

    Element getContainer() {
        return inputContainer;
    }
}