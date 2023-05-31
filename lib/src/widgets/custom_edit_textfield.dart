import 'package:average/app_exports.dart';

class CustomEditableText extends StatelessWidget {
  final int initialValue;
  final bool isKg;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  const CustomEditableText({
    super.key,
    required this.initialValue,
    required this.isKg,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = initialValue.toString();

    final unitText = isKg ? ' kg' : ' reps';

    return SizedBox(
      height: 50,
      width: 100,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          suffixText: unitText,
          suffixStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        cursorColor: Colors.white,
      ),
    );
  }
}
