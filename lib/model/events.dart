import 'consts.dart';

class Submission {

  int id;
  String thumbUrl;

  Submission.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        thumbUrl = json['ThumbUrl'];
}


/// Evento
class Event {
  int id = -1;
  String name = '';
  String start = '';
  String end = '';
  
  List<Submission> submissions = new List() ;

  Event(this.name, this.start, this.end);

  Event.named(String name) : this(name, '', '');

  Event.empty( ) : this('', '', '');

  DateTime getEndAsDateTime() {
    return DateTime.parse(end);
  }

  /// evento è in corso!  
  bool isOpen() {
    if (start.length == 0 || end.length == 0) return false;
    DateTime ora = new DateTime.now();
    return ora.millisecondsSinceEpoch >= DateTime.parse(start).millisecondsSinceEpoch && 
            ora.millisecondsSinceEpoch < DateTime.parse(end).millisecondsSinceEpoch;
  }

  bool isFuture() {
    if (start.length == 0) return false;
    DateTime ora = new DateTime.now();
    return ora.isBefore( DateTime.parse(start));
  }

  bool isClosed() {
    if (start.length == 0) return true;
    DateTime ora = new DateTime.now();
    return ora.isAfter( DateTime.parse(end));
  }



  String counter() {
    if (isFuture()) {
        double seconds = ( DateTime.parse(start).millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch  ) / 1000;
        //print ("start: " + start + " => " + DateTime.parse(end).millisecondsSinceEpoch.toString());
        //print ("end: " + end);
        // print (seconds.toString());
        if (seconds > Consts.SECONDS_IN_DAY ) {
          return 'starting in ' + (seconds ~/ Consts.SECONDS_IN_DAY).toString() + " days";
        } else if ( seconds <= Consts.SECONDS_IN_DAY) {
          return 'starting in ' + (seconds ~/ Consts.SECONDS_IN_DAY).toString() + " days";
        } else {
          return 'starting in ' +  seconds.toString() + " sec"; 
        }
    } else if (isOpen()) {
      double seconds = ( DateTime.parse(end).millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch  ) / 1000;
      if (seconds > Consts.SECONDS_IN_DAY ) {
        return 'closing in ' +  (seconds ~/ Consts.SECONDS_IN_DAY).toString() + " days";
      } else if ( seconds <= Consts.SECONDS_IN_DAY) {
        return 'closing in ' + (seconds ~/ Consts.SECONDS_IN_DAY).toString() + " days";
      } else {
        return 'closing in ' + seconds.toString() + " sec"; 
      }
      
    } else {
      return '';
    }
  }
  /*
   * costruisce descrizione dell'evento a partire dalla risposta JSON del server
   */
  Event.fromJson(Map<String, dynamic> json) {
      id = json['ID'];
      name   = json['Name'];
      end    = json['End'];
      start  = json['Start'];

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