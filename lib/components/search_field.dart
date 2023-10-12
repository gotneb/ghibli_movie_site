import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController();

  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final textField = TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      onSubmitted: (value) {
        searchTerm = value;
      },
      decoration: InputDecoration(
        fillColor: const Color(0xFF202020),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          borderSide: BorderSide(color: Colors.grey[400]!, width: .5),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          borderSide: BorderSide(color: Colors.grey[400]!, width: .5),
        ),
      ),
    );

    final iconField = Container(
        height: 120,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.redAccent[700],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            )),
        child: Icon(Icons.search, color: Colors.white, fill: 1));

    return Stack(
      children: [
        Row(children: [
          const SizedBox(width: 60),
          Flexible(child: textField),
        ]),
        Row(children: [const SizedBox(width: 1), iconField])
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
