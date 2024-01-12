

class Validator {
  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }
    return null;
  }

  static String? validatePhoneNumber({required String? phoneNumber}) {
    if (phoneNumber == null) {
      return null;
    }

    RegExp phoneRegExp = RegExp(r'(^(?:[+]9)?[0-9]{10,12}$)');

    if (phoneNumber.isEmpty) {
      return 'Enter your Phone Number';
    } else if (!phoneRegExp.hasMatch(phoneNumber)) {
      return 'Enter your correct Phonenumber';
    }
    return null;
  }

  static String? validateText({required String? text}) {
    if (text == null) {
      return null;
    }

    if (text.isEmpty) {
      return 'This field cant be empty';
    }
    return null;
  }

  static validateAge({required String? age}) {
    if (age == null || age.isEmpty) {
      return 'This field cant be empty';
    }
    // if (age.) {
    //   return 'Invalid Input';
    // }
  }
}
