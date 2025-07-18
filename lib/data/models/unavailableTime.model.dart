class UnavailableTime {
  UnavailableTime(this.id, this.day, this.start, this.end);

  int id;
  String day;
  DateTime start;
  DateTime end;

  factory UnavailableTime.fromJson(Map<String, dynamic> json) {
    return UnavailableTime(
      json['id'] as int,
      json['day'] as String,
      DateTime.parse(json['start']),
      DateTime.parse(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }


   @override
  String toString() {
    return '{id: $id, day: $day, start: $start, end: $end}\n';
  }
}
