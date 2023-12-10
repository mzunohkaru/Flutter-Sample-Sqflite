import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite_sample/db/notes_database.dart';
import 'package:sqflite_sample/model/note.dart';
import 'package:sqflite_sample/page/note_detail_page.dart';
import 'package:sqflite_sample/widget/note_card_widget.dart';

class NoteSearchPage extends StatefulWidget {
  const NoteSearchPage({super.key});

  @override
  State<NoteSearchPage> createState() => _NoteSearchPageState();
}

class _NoteSearchPageState extends State<NoteSearchPage> {
  late List<Note> notes;
  final _controller = TextEditingController();

  Future<List<Note>> _searchNotes() async {
    final query = _controller.text;
    final dbNotes = await NotesDatabase.instance.search(query);

    return dbNotes.map((item) => Note.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search...',
          ),
          onChanged: (value) {
            setState(() {
              _searchNotes();
            });
          },
        ),
      ),
      body: FutureBuilder<List<Note>>(
        future: _searchNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('An error has occurred!'));
          } else if (snapshot.hasData) {
            return MasonryGridView.count(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.length,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          NoteDetailPage(noteId: snapshot.data![index].id!),
                    ));

                    this.notes = await NotesDatabase.instance.readAllNotes();
                  },
                  child: NoteCardWidget(
                    note: snapshot.data![index],
                    index: index,
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
