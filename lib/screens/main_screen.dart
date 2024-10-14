import 'package:flutter/material.dart';
import 'package:word_book/data/database_helper.dart';
import 'package:word_book/models/book_item.dart';
import 'package:word_book/screens/add_screen.dart';
import 'package:word_book/screens/update_screen.dart';
import 'package:word_book/widgets/list_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<BookItem> data = [];

  final DatabaseHelper helper = DatabaseHelper();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Book"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: data.isEmpty
                    ? const Center(child: Text("Add your first word"))
                    : ListWidget(
                        data: data,
                        onDismissed: (entity) {
                          _deleteSingleRecord(entity).then((onValue) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(onValue
                                          ? "Deleted"
                                          : "An error occurred!")));
                            }
                          });
                        },
                        onLongPressed: (entity) {
                          _navigateUpdateScreen(context, entity);
                        },
                      )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAddScreen(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _initData() async {
    List<BookItem> items = await getAllBookItems();

    setState(() {
      data = items;
    });
  }

  Future<List<BookItem>> getAllBookItems() async {
    return await helper.getAll();
  }

  void _navigateAddScreen(BuildContext context) async {
    bool? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddScreen()));

    if (result != null && result) {
      _initData();
    }
  }

  Future<bool> _deleteSingleRecord(BookItem entity) async {
    int result = await helper.delete(entity.id!);
    return (result > 0) ? true : false;
  }

  void _navigateUpdateScreen(BuildContext context, BookItem entity) async {
    bool? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => UpdateScreen(entity: entity)));
    if (result != null && result) {
      _initData();
    }
  }
}
