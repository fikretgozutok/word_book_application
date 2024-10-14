import 'package:flutter/material.dart';
import 'package:word_book/models/book_item.dart';

class ListWidget extends StatelessWidget {
  final List<BookItem> data;
  final void Function(BookItem) onDismissed;
  final void Function(BookItem) onLongPressed;

  const ListWidget({required this.data, required this.onDismissed, required this.onLongPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction){
          onDismissed(data[index]);
        },
          key: Key(data[index].id.toString()),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white,),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15)
            ),
            child: ListTile(
              title: Text(data[index].turkish!),
              subtitle: Text(data[index].english!),
              onLongPress: (){
                onLongPressed(data[index]);
              },
            ),
          )),
      itemCount: data.length,
    );
  }
}
