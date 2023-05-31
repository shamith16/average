import 'package:average/app_exports.dart';

class RowAddButton extends StatelessWidget {
  const RowAddButton({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback? onPressed;
  final primaryColor = const Color(0XFFDA7657);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),

      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            Text(
              title,
              style: TextStyle(color: primaryColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
