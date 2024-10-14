import 'package:flutter/material.dart';

import '../data/database_helper.dart';
import '../models/book_item.dart';

class UpdateScreen extends StatefulWidget {
  final BookItem entity;
  const UpdateScreen({required this.entity, super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController _turkishInputController = TextEditingController();
  final TextEditingController _englishInputController = TextEditingController();

  final DatabaseHelper helper = DatabaseHelper();

  @override
  void initState() {
    _turkishInputController.text = widget.entity.turkish!;
    _englishInputController.text = widget.entity.english!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update ${widget.entity.turkish}")),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            buildTurkishInput(),
            const SizedBox(height: 25.0),
            buildEnglishInput(),
            const SizedBox(height: 25.0),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  Widget buildTurkishInput() {
    return TextField(
        decoration: const InputDecoration(labelText: 'Turkish'),
        controller: _turkishInputController);
  }

  Widget buildEnglishInput() {
    return TextField(
      decoration: const InputDecoration(labelText: 'English'),
      controller: _englishInputController,
    );
  }

  Widget buildSaveButton() {
    return ElevatedButton(
        onPressed: () {
          updateEntry(context);
        },
        child: const Text('Update'));
  }

  void updateEntry(BuildContext context) async {
    BookItem entity = BookItem(widget.entity.id,
        turkish: _turkishInputController.text,
        english: _englishInputController.text);

    int result = await helper.update(entity);

    if (context.mounted) {
      Navigator.pop(context, (result > 0) ? true : false);
    }
  }
}