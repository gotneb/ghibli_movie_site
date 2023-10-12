import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/styles.dart';

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
      maxLines: 1,
      onSubmitted: (value) {
        searchTerm = value;
      },
      decoration: InputDecoration(
        hintStyle: CustomStyle.hintText,
        hintText: "I'm looking for...",
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
        child: const Icon(Icons.search_sharp, color: Colors.white, fill: 1));

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
