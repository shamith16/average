import 'package:average/app_exports.dart';

class CustomEditableText extends StatefulWidget {
  final int initialValue;
  final bool isKg;
  final ValueChanged<String>? onKgChanged;
  final ValueChanged<String>? onRepsChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;

  const CustomEditableText({
    Key? key,
    required this.initialValue,
    required this.isKg,
    this.onKgChanged,
    this.onRepsChanged,
    this.onEditingComplete,
    this.onChanged,
  }) : super(key: key);

  @override
  CustomEditableTextState createState() => CustomEditableTextState();
}

class CustomEditableTextState extends State<CustomEditableText> {
  late TextEditingController _controller;
  bool _isEditing = false;
  String? _savedValue;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialValue.toString();
    _savedValue = widget.initialValue.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSubmitted(String value) {
    if (_isEditing) {
      if (value.isEmpty || int.tryParse(value) == null) {
        setState(() {
          _controller.text = _savedValue!;
        });
      } else {
        setState(() {
          _savedValue = value;
        });
        if (widget.isKg) {
          widget.onKgChanged?.call(value);
        } else {
          widget.onRepsChanged?.call(value);
        }
      }
    } else if (_controller.text.isEmpty) {
      setState(() {
        _controller.text = _savedValue!;
      });
    }

    // Dismiss the keyboard
    _focusNode.unfocus();

    if (widget.onEditingComplete != null) {
      widget.onEditingComplete!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final unitText = widget.isKg ? ' kg' : ' reps';

    return SizedBox(
      height: 50,
      width: 100,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        // Assign the focus node
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
        onTap: () {
          if (!_isEditing) {
            setState(() {
              _isEditing = true;
              _controller.text = '';
            });
          }
        },
        onChanged: widget.onChanged,
        onEditingComplete: () {
          setState(() {
            _isEditing = false;
          });
          _onSubmitted(_controller.text);
        },
        onSubmitted: _onSubmitted,
        cursorColor: Colors.white,
      ),
    );
  }
}
