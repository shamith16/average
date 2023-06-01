import 'package:average/app_exports.dart';

class WorkoutLogCard extends StatelessWidget {
  const WorkoutLogCard({Key? key, required this.workoutLogEntry})
      : super(key: key);

  final WorkoutLogEntry workoutLogEntry;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF222838),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildRowAddButton(
            icon: Icons.add,
            title: 'Warm-up',
            onTap: () {
              Provider.of<WorkoutLogProvider>(context, listen: false)
                  .addWarmupRow(workoutLogEntry.logId);
            },
          ),
          const Divider(
            color: Colors.black,
            height: 1,
          ),
          Column(
            children: workoutLogEntry.warmupRows
                .asMap()
                .entries
                .map((entry) => WorkoutLogRow(
                      index: entry.key,
                      workoutLogEntry: workoutLogEntry,
                      key: Key(workoutLogEntry.warmupRows[entry.key].rowId),
                    ))
                .toList(),
          ),
          Column(
            children: workoutLogEntry.setRows
                .asMap()
                .entries
                .map((entry) => WorkoutLogRow(
                      index: entry.key,
                      isWarmUp: false,
                      workoutLogEntry: workoutLogEntry,
                      key: Key(workoutLogEntry.setRows[entry.key].rowId),
                    ))
                .toList(),
          ),
          const Divider(
            color: Colors.black,
            height: 1,
          ),
          _buildRowAddButton(
            icon: Icons.add,
            title: 'Set',
            onTap: () {
              Provider.of<WorkoutLogProvider>(context, listen: false)
                  .addSetRow(workoutLogEntry.logId);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      margin: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: [
          Text(
            workoutLogEntry.workoutName,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const Spacer(),
          InkWell(
              child: const Icon(
                Icons.help_outline,
                color: Colors.grey,
              ),
              onTap: () =>
                  Provider.of<WorkoutLogProvider>(context, listen: false)
                      .printWorkoutLogEntry(workoutLogEntry.logId)),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              _showDeleteMenu(context);
            },
            child: const Icon(
              Icons.more_vert,
              color: Colors.grey,
              size: 28,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRowAddButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: RowAddButton(
        icon: icon,
        title: title,
      ),
    );
  }

  void _showDeleteMenu(BuildContext context) {
    final provider = Provider.of<WorkoutLogProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                provider.deleteWorkoutLogEntry(workoutLogEntry);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
