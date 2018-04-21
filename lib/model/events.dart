
class Event {
  String name;

  Event() {
    name="Nessun evento in calendario";
  }

  Event.fromJson(Map<String, dynamic> json)
      : name = json['Name'];


  Map<String, dynamic> toJson() =>
      {
        'Name': name
      };

}