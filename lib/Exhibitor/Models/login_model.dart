class LoginModel {
  final int? event_id;
  final String? current_event;

  LoginModel({
    this.event_id,
    this.current_event,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      event_id: json['current_event_id'],
      current_event: json['current_event'],
    );
  }
}
