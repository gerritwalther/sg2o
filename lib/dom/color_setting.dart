part of sg2o;

class ColorSetting {

    late String title;
    late String storageKey;
    late Element inputContainer;
    late InputElement inputColor;

    ColorSetting (String title, String storageKey) {
        this.title = title;
        this.storageKey = storageKey;

        inputContainer = createColorSetting();
    }

    Element createColorSetting() {
        DivElement colorSetting = new DivElement();
        inputColor = new InputElement();

        inputColor.type = 'color';
        inputColor.value = loadColor();

        colorSetting.text = title;
        colorSetting.classes.add(classSettingsColorInput);
        colorSetting.append(inputColor);

        return colorSetting;
    }

    String loadColor() {
        if (storage.containsKey(storageKey)) {
            return storage.get(storageKey);
        } else {
            return getDefaultColor(storageKey);
        }
    }

    void store() {
        storage.add(storageKey, inputColor.value ?? getDefaultColor(storageKey));
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