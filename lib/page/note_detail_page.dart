import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_sample/db/notes_database.dart';
import 'package:sqflite_sample/model/note.dart';
import 'package:sqflite_sample/page/edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({Key? key, required this.noteId}) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    note.isImportant
                        ? ListTile(
                            title: Text(
                              '重要',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : const SizedBox(),
                    ListTile(
                      leading: Text('保存した日時'),
                      title: Text(
                        DateFormat('yyyy年M月d日').format(note.createdTime),
                      ),
                    ),
                    ListTile(
                      leading: Text('Title'),
                      title: Text(
                        note.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                        leading: Text('Description'),
                        title: Text(
                          note.description,
                          style: TextStyle(fontSize: 18),
                        )),
                    SizedBox(height: 8),
                    SizedBox(height: 8),
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
