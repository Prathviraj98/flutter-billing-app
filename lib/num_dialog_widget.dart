import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late TextEditingController controllern;
Future<T?> showNumDialog<T>(
  BuildContext context, {
  required String title,
  required String value,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
        title: title,
        value: value,
      ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const TextDialogWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  @override
  void initState() {
    super.initState();

    controllern = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: AlertDialog(
          title: Text(widget.title),
          content: TextField(
            keyboardType: TextInputType.phone,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 3,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 74, 197, 245),
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 80, 5, 21),
                  width: 2,
                ),
              ),
              //suffixText: 'username',
            ),
            controller: controllern,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurpleAccent,
              ),
              child: const Text('Change'),
              onPressed: () => Navigator.of(context).pop(controllern.text),
            )
          ],
        ),
      );
}
