import 'package:flutter/material.dart';
import 'package:word_book/constants/options.dart';
import 'package:word_book/data/database_helper.dart';
import 'package:word_book/models/book_item.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _turkishInputController = TextEditingController();
  final TextEditingController _englishInputController = TextEditingController();

  final DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New")),
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
    return FilledButton(
        onPressed: () {
          addToDatabase(context);
        },
        child: const Text('Save'));
  }

  void addToDatabase(BuildContext context) async {
    BookItem entity = BookItem(null,
        turkish: _turkishInputController.text,
        english: _englishInputController.text);

    int result = await helper.add(entity);

    if (context.mounted) {
      Navigator.pop(context, (result > 0) ? true : false);
    }
  }
}
