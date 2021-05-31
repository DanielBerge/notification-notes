String? titleValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter title';
  }
  return null;
}