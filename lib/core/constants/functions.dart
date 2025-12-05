bool isValidEmail(String email) {
  // Regular expression pattern for a valid email
  String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,4}$';
  RegExp regex = RegExp(emailPattern);

  // Check if the email matches the regex pattern
  return regex.hasMatch(email);
}
