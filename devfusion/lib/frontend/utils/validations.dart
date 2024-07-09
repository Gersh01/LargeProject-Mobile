List<String> validateSignUp(String firstName, String lastName, String username,
    String email, String password) {
  Map<String, List<String>> errors = {
    'firstName': [],
    'lastName': [],
    'username': [],
    'email': [],
    'password': [],
  };

  // Regex patterns for validation
  final validEmail =
      RegExp(r'^[a-zA-Z0-9._:$!%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final validPassword =
      RegExp(r'(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&])(?=.{8,24}$)');

  // Validate first name
  if (firstName.isEmpty) {
    errors['firstName']!.add('Cannot be empty');
  } else if (firstName.length > 18) {
    errors['firstName']!.add('Name is too long');
  }

  // Validate last name
  if (lastName.isEmpty) {
    errors['lastName']!.add('Cannot be empty');
  } else if (lastName.length > 18) {
    errors['lastName']!.add('Name is too long');
  }

  // Validate username
  if (username.isEmpty) {
    errors['username']!.add('Username cannot be empty');
  } else if (username.length > 24) {
    errors['username']!.add('Username cannot be more than 24 characters');
  }

  // Validate email
  if (email.isEmpty) {
    errors['email']!.add('Email cannot be empty');
  } else if (!validEmail.hasMatch(email)) {
    errors['email']!.add('Email must follow example@email.com format');
  }

  // Validate password
  if (password.isEmpty) {
    errors['password']!.add('Password cannot be empty');
  } else if (!validPassword.hasMatch(password)) {
    errors['password']!.add('Password does not follow the correct format');
  }

  // Combine all error messages into a single list
  List<String> errorMessages = [];
  errors.forEach((key, value) {
    errorMessages.addAll(value);
  });

  return errorMessages;
}

Map<String, List<String>> validateLogin(String username, String password) {
  Map<String, List<String>> errors = {
    'username': [],
    'password': [],
  };

  // Validate username
  if (username.isEmpty) {
    errors['username']!.add('Username cannot be empty');
  }

  // Validate password
  if (password.isEmpty) {
    errors['password']!.add('Password must not be empty');
  }

  return errors;
}
