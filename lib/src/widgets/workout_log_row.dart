import 'package:average/app_exports.dart';

class WorkoutLogRow extends StatelessWidget {
  const WorkoutLogRow({
    Key? key,
    this.isWarmUp = true,
    this.index,
    this.isLast = false,
    required this.workoutLogEntry,
  })  : assert(isWarmUp || index != null,
  'Index must be provided for non-warm-up rows'),
        super(key: key);

  final bool isWarmUp;
  final int? index;
  final bool isLast;
  final WorkoutLogEntry workoutLogEntry;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const BehindMotion(), children: [
        SlidableAction(
          onPressed: _handleVideoTap,
          icon: Icons.video_call,
          backgroundColor: Colors.black,
        ),
        SlidableAction(
          onPressed: _handleDeleteTap,
          icon: Icons.delete,
          backgroundColor: Colors.black,
          foregroundColor: Colors.red,
        ),
      ]),
      child: SizedBox(
        height: 55,
        child: Stack(
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width * 0.15,
              height: 55,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isWarmUp
                      ? const Icon(Icons.emoji_people_rounded)
                      : Text("${index! + 1}",
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            const Positioned(
              left: 45,
              height: 55,
              child: VerticalDivider(
                color: Colors.black,
              ),
            ),
            if (!isLast)
              Positioned(
                bottom: 0,
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
              ),
            Positioned(
              left: 80,
              width: MediaQuery.of(context).size.width * 0.2,
              child: const CustomEditableText(
                initialValue: 0,
                isKg: true,
              ),
            ),
            Positioned(
              left: 230,
              width: MediaQuery.of(context).size.width * 0.2,
              child: const CustomEditableText(
                initialValue: 0,
                isKg: false,
              ),
            ),
            const Positioned(
              right: 16,
              top: 12,
              child: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }

  void _handleVideoTap(BuildContext context) {
    // Handle video icon tap
  }

  void _handleDeleteTap(BuildContext context) {
    final provider = context.read<WorkoutLogProvider>();
    if (isWarmUp) {
      provider.deleteWarmupRow(workoutLogEntry.logId, index!);
    } else {
      provider.deleteSetRow(workoutLogEntry.logId, index!);
    }
  }
}
