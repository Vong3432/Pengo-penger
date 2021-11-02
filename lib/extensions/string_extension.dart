extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String snakeCasetoSentenceCase() {
    return "${this[0].toUpperCase()}${this.substring(1)}"
        .replaceAll(RegExp(r'(_|-)+'), ' ');
  }

  String withoutPhone() {
    return this.replaceAll("+6", "");
  }
}
