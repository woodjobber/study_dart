abstract class DialogOptions {
  DialogOptions({
    this.title,
    this.msg,
    this.style,
  });
  String? msg;
  String? title;
  int? style;
}

class AlertOptions extends DialogOptions {
  AlertOptions({
    super.title,
    super.msg,
    super.style,
  });
}
