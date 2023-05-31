class WorkoutLogEntry {
  final String logId;
  final String workoutName;
  List<WorkoutRow> warmupRows;
  List<WorkoutRow> setRows;

  WorkoutLogEntry(this.logId, this.workoutName,
      {List<WorkoutRow>? warmupRows, List<WorkoutRow>? setRows})
      : warmupRows = warmupRows ?? [],
        setRows = setRows ?? [];

  factory WorkoutLogEntry.fromJson(Map<String, dynamic> json) {
    return WorkoutLogEntry(
      json['logId'] as String,
      json['workoutName'] as String,
      warmupRows: (json['warmupRows'] as List<dynamic>)
          .map((rowJson) => WorkoutRow.fromJson(rowJson))
          .toList(),
      setRows: (json['setRows'] as List<dynamic>)
          .map((rowJson) => WorkoutRow.fromJson(rowJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logId': logId,
      'workoutName': workoutName,
      'warmupRows': warmupRows.map((row) => row.toJson()).toList(),
      'setRows': setRows.map((row) => row.toJson()).toList(),
    };
  }

  WorkoutLogEntry copyWith({
    String? logId,
    String? workoutName,
    List<WorkoutRow>? warmupRows,
    List<WorkoutRow>? setRows,
  }) {
    return WorkoutLogEntry(
      logId ?? this.logId,
      workoutName ?? this.workoutName,
      warmupRows: warmupRows ?? this.warmupRows,
      setRows: setRows ?? this.setRows,
    );
  }

  @override
  String toString() {
    return 'WorkoutLogEntry(logId: $logId, workoutName: $workoutName, warmupRows: $warmupRows, setRows: $setRows)';
  }
}

class WorkoutRow {
  final int kg;
  final int reps;

  WorkoutRow({this.kg = 0, this.reps = 0});

  factory WorkoutRow.fromJson(Map<String, dynamic> json) {
    return WorkoutRow(
      kg: json['kg'] as int,
      reps: json['reps'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kg': kg,
      'reps': reps,
    };
  }

  @override
  String toString() {
    return 'WorkoutRow(kg: $kg, reps: $reps)';
  }
}