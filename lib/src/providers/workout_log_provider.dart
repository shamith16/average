import 'dart:developer';

import 'package:average/app_exports.dart' hide log;

class WorkoutLogProvider extends ChangeNotifier {
  List<WorkoutLogEntry> workoutLogs = [];
  final Random _random = Random();

  void addWarmupRow(String logId) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final workoutLog = workoutLogs[workoutLogIndex].copyWith(
        warmupRows: [
          ...workoutLogs[workoutLogIndex].warmupRows,
          WorkoutRow(
            _generateUniqueId(),
          ),
        ],
      );
      workoutLogs[workoutLogIndex] = workoutLog;
      notifyListeners();
      log('addWarmupRow called: Added a warm-up row to logId $logId with rowId ${workoutLog.warmupRows.last.rowId}');
    }
  }

  void deleteWarmupRow(String logId, String rowId) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final updatedWarmupRows =
          List<WorkoutRow>.from(workoutLogs[workoutLogIndex].warmupRows);
      updatedWarmupRows.removeWhere((row) => row.rowId == rowId);
      final workoutLog = workoutLogs[workoutLogIndex].copyWith(
        warmupRows: updatedWarmupRows,
      );
      workoutLogs[workoutLogIndex] = workoutLog;
      notifyListeners();
      log('deleteWarmupRow called: Deleted a warm-up row from logId $logId with rowId $rowId');

      // Log remaining warm-up rows and their rowIds
      final remainingRows = workoutLogs[workoutLogIndex].warmupRows;
      log('Remaining warm-up rows:');
      for (final row in remainingRows) {
        log('rowId: ${row.rowId}');
      }
    }
  }

  void deleteSetRow(String logId, String rowId) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final updatedSetRows =
          List<WorkoutRow>.from(workoutLogs[workoutLogIndex].setRows);
      updatedSetRows.removeWhere((row) => row.rowId == rowId);
      final workoutLog = workoutLogs[workoutLogIndex].copyWith(
        setRows: updatedSetRows,
      );
      workoutLogs[workoutLogIndex] = workoutLog;
      notifyListeners();
      log('deleteSetRow called: Deleted a set row from logId $logId with rowId $rowId');

      // Log remaining set rows and their rowIds
      final remainingRows = workoutLogs[workoutLogIndex].setRows;
      log('Remaining set rows:');
      for (final row in remainingRows) {
        log('rowId: ${row.rowId}');
      }
    }
  }

  void addSetRow(String logId) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final workoutLog = workoutLogs[workoutLogIndex].copyWith(
        setRows: [
          ...workoutLogs[workoutLogIndex].setRows,
          WorkoutRow(
            _generateUniqueId(),
          ),
        ],
      );
      workoutLogs[workoutLogIndex] = workoutLog;
      notifyListeners();
      log('addSetRow called: Added a set row to logId $logId with rowId ${workoutLog.setRows.last.rowId}');
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
    log('addDefaultWorkoutLogEntry called: Added a default workout log entry');
  }

  void deleteWorkoutLogEntry(WorkoutLogEntry entry) {
    workoutLogs.remove(entry);
    notifyListeners();
    log('deleteWorkoutLogEntry called: Deleted a workout log entry');
  }

  void updateWarmupRow(String logId, String rowId, int kg, int reps) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final updatedWarmupRows =
          List<WorkoutRow>.from(workoutLogs[workoutLogIndex].warmupRows);
      final rowToUpdateIndex =
          updatedWarmupRows.indexWhere((row) => row.rowId == rowId);
      if (rowToUpdateIndex != -1) {
        final updatedRow = updatedWarmupRows[rowToUpdateIndex].copyWith(
          kg: kg,
          reps: reps,
        );
        updatedWarmupRows[rowToUpdateIndex] = updatedRow;
        final workoutLog = workoutLogs[workoutLogIndex].copyWith(
          warmupRows: updatedWarmupRows,
        );
        workoutLogs[workoutLogIndex] = workoutLog;
        notifyListeners();
        log('updateWarmupRow called: Updated warm-up row with rowId $rowId in logId $logId to kg: $kg, reps: $reps');
      }
    }
  }

  void updateSetRow(String logId, String rowId, int kg, int reps) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final updatedSetRows =
          List<WorkoutRow>.from(workoutLogs[workoutLogIndex].setRows);
      final rowToUpdateIndex =
          updatedSetRows.indexWhere((row) => row.rowId == rowId);
      if (rowToUpdateIndex != -1) {
        final updatedRow = updatedSetRows[rowToUpdateIndex].copyWith(
          kg: kg,
          reps: reps,
        );
        updatedSetRows[rowToUpdateIndex] = updatedRow;
        final workoutLog = workoutLogs[workoutLogIndex].copyWith(
          setRows: updatedSetRows,
        );
        workoutLogs[workoutLogIndex] = workoutLog;
        notifyListeners();
        log('updateSetRow called: Updated set row with rowId $rowId in logId $logId to kg: $kg, reps: $reps');
      }
    }
  }

  void printWorkoutLogEntry(String logId) {
    final workoutLogIndex = workoutLogs.indexWhere((log) => log.logId == logId);
    if (workoutLogIndex != -1) {
      final workoutLog = workoutLogs[workoutLogIndex];

      final StringBuffer buffer = StringBuffer();

      // Log WorkoutLogEntry name
      buffer.writeln('Workout Log Entry:');
      buffer.writeln('Name: ${workoutLog.workoutName}');

      // Log warm-up rows
      buffer.writeln('\nWarm-up Rows:');
      if (workoutLog.warmupRows.isNotEmpty) {
        for (final row in workoutLog.warmupRows) {
          buffer.writeln('Row ID: ${row.rowId}');
          buffer.writeln('Kg: ${row.kg}');
          buffer.writeln('Reps: ${row.reps}');
          buffer.writeln();
        }
      } else {
        buffer.writeln('No warm-up rows found');
      }

      // Log set rows
      buffer.writeln('\nSet Rows:');
      if (workoutLog.setRows.isNotEmpty) {
        for (final row in workoutLog.setRows) {
          buffer.writeln('Row ID: ${row.rowId}');
          buffer.writeln('Kg: ${row.kg}');
          buffer.writeln('Reps: ${row.reps}');
          buffer.writeln();
        }
      } else {
        buffer.writeln('No set rows found');
      }

      log(buffer.toString());
    }
  }
}
