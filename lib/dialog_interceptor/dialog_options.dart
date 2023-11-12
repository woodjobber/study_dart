abstract class DialogOptions {
  DialogOptions({
    this.title,
    this.msg,
  });
  String? msg;
  String? title;
}

class AlertOptions extends DialogOptions {
  int? type;
  AlertOptions({super.title, super.msg, this.type});
}
