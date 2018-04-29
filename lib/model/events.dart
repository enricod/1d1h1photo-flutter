
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


  DateTime getEndAsDateTime() {
    return DateTime.parse(end);
  }
  bool futuro = true;
  List<Submission> submissions = new List() ;

  Event() {
    name="loading ...";
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
     for (var evn in json['Submissions']) {
       Submission submission = Submission.fromJson(evn);
       submissions.add(submission);

     }
  }



  Map<String, dynamic> toJson() =>
      {
        'Name': name
      };

}