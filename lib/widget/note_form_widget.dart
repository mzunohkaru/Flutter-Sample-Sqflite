import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget(
      {Key? key,
      this.isImportant,
      this.title,
      this.description,
      required this.onChangedImportant,
      required this.onChangedTitle,
      required this.onChangedDescription})
      : super(key: key);

  // const NoteFormWidget({
  //   Key? key,
  //   this.isImportant = false,
  //   this.title = '',
  //   this.description = '',
  //   required this.onChangedImportant,
  //   required this.onChangedNumber,
  //   required this.onChangedTitle,
  //   required this.onChangedDescription,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Text(
                'Title',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              buildTitle(),
              SizedBox(height: 16),
              Text(
                'Description',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
              ListTile(
                leading: Text(
                  'Switch',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                title: Switch(
                  value: isImportant ?? false,
                  onChanged: onChangedImportant,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Title',
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Type something...',
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}
