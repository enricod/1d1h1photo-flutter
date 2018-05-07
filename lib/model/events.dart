
class Submission {

  int id;
  String thumbUrl;

  Submission.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        thumbUrl = json['ThumbUrl'];
}

class Event {
  String name;
  String end;
  bool futuro = true;
  List<Submission> submissions = new List() ;

  Event(this.name, this.end);

  Event.named(String name) : this(name, "");

  Event.empty( ) : this("", "");

  DateTime getEndAsDateTime() {
    return DateTime.parse(end);
  }
  
  bool isFuturo() {
    return futuro;
  }

  /*
   * costruisce descrizione dell'evento a partire dalla risposta JSON del server
   */
  Event.fromJson(Map<String, dynamic> json) {
     name = json['Name'];
     end = json['End'];
     var submissionsJson = json['Submissions'];

     // il campo Submissions può essere null, quindi dobbiamo gestire la situazione
     if (submissionsJson != null) {
      for (var evn in json['Submissions']) {
        Submission submission = Submission.fromJson(evn);
        submissions.add(submission);
      }
     }
     // FIXME mettere sempre 3 sumbissions, gestendo eventualmente dei "placeholders"
  }



  Map<String, dynamic> toJson() =>
      {
        'Name': name
      };

}