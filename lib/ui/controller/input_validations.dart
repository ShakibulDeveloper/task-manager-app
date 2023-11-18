class FormValidation {
  static String? emailValidation(String? value) {
    const validEmailPattern =
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(validEmailPattern);

    if (value!.trim().isEmpty || !regex.hasMatch(value)) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }

  static String? inputValidation(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Please fill-up the input field.";
    }
    return null;
  }

  static String? phoneNumberValidation(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Please fill-up the input field.";
    }
    if (value!.length > 11) {
      return "Your phone number cannot exceed 11 digit";
    }

    return null;
  }
}
