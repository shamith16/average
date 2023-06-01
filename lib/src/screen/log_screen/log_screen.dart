import 'package:average/app_exports.dart' hide log;

class WorkoutLogScreen extends StatelessWidget {
  const WorkoutLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Log'),
        centerTitle: true,
      ),
      body: Consumer<WorkoutLogProvider>(
        builder: (context, workoutLogProvider, child) {
          final workoutLogs = workoutLogProvider.workoutLogs;
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: workoutLogs.length,
            itemBuilder: (context, index) {
              final workoutLogEntry = workoutLogs[index];
              return WorkoutLogCard(
                workoutLogEntry: workoutLogEntry,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final workoutLogProvider =
              Provider.of<WorkoutLogProvider>(context, listen: false);
          workoutLogProvider.addDefaultWorkoutLogEntry();
        },
        backgroundColor: const Color(0xFF222838).lighten(10),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
