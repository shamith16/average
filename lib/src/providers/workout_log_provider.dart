import 'package:average/app_exports.dart';

class WorkoutLogProvider extends ChangeNotifier {
  List<WorkoutLogEntry> workoutLogs = [
    WorkoutLogEntry(
      "1",
      'Lat Pulldown',
      setRows: [
        WorkoutRow(
          kg: 100,
          reps: 10,
        ),
        WorkoutRow(
          kg: 100,
          reps: 10,
        ),
        WorkoutRow(
          kg: 100,
          reps: 10,
        ),
      ],
      warmupRows: [
        WorkoutRow(
          kg: 100,
          reps: 10,
        ),
        WorkoutRow(
          kg: 100,
          reps: 10,
        ),
        WorkoutRow(
          kg: 100,
          reps: 10,
        ),
      ],
    ),
    WorkoutLogEntry('2', 'Barbell Squat', setRows: [
      WorkoutRow(
        kg: 120,
        reps: 8,
      ),
      WorkoutRow(
        kg: 120,
        reps: 8,
      ),
      WorkoutRow(
        kg: 120,
        reps: 8,
      ),
    ], warmupRows: [
      WorkoutRow(
        kg: 80,
        reps: 10,
      ),
      WorkoutRow(
        kg: 100,
        reps: 10,
      ),
    ]),
  ];
  final Random _random = Random();

  void addWarmupRow(String logId) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final workoutLog = workoutLogs[workoutLogIndex].copyWith(
        warmupRows: [
          ...workoutLogs[workoutLogIndex].warmupRows,
          WorkoutRow(),
        ],
      );
      workoutLogs[workoutLogIndex] = workoutLog;
      notifyListeners();
    }
  }

  void deleteWarmupRow(String logId, int rowIndex) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final updatedWarmupRows =
      List<WorkoutRow>.from(workoutLogs[workoutLogIndex].warmupRows);
      if (rowIndex >= 0 && rowIndex < updatedWarmupRows.length) {
        updatedWarmupRows.removeAt(rowIndex);
        final workoutLog = workoutLogs[workoutLogIndex].copyWith(
          warmupRows: updatedWarmupRows,
        );
        workoutLogs[workoutLogIndex] = workoutLog;
        notifyListeners();
      }
    }
  }

  void addSetRow(String logId) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final workoutLog = workoutLogs[workoutLogIndex].copyWith(
        setRows: [
          ...workoutLogs[workoutLogIndex].setRows,
          WorkoutRow(),
        ],
      );
      workoutLogs[workoutLogIndex] = workoutLog;
      notifyListeners();
    }
  }

  void deleteSetRow(String logId, int rowIndex) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final updatedSetRows =
      List<WorkoutRow>.from(workoutLogs[workoutLogIndex].setRows);
      if (rowIndex >= 0 && rowIndex < updatedSetRows.length) {
        updatedSetRows.removeAt(rowIndex);
        final workoutLog = workoutLogs[workoutLogIndex].copyWith(
          setRows: updatedSetRows,
        );
        workoutLogs[workoutLogIndex] = workoutLog;
        notifyListeners();
      }
    }
  }

  String _generateUniqueId() {
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final int random = _random.nextInt(999999);
    return '$timestamp$random';
  }

  void addDefaultWorkoutLogEntry() {
    final defaultEntry = WorkoutLogEntry(
      _generateUniqueId(),
      'Default Exercise',
      setRows: [],
      warmupRows: [],
    );
    workoutLogs.add(defaultEntry);
    notifyListeners();
  }

  void deleteWorkoutLogEntry(WorkoutLogEntry entry) {
    workoutLogs.remove(entry);
    notifyListeners();
  }
}
