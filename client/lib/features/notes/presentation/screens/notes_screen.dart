import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:client/features/notes/bloc/notes_state.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:client/features/notes/presentation/widgets/add_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/delete_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/edit_note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesLoaded) {
            final notes = state.notes;
            if (notes.isEmpty) {
              return const Center(child: Text("Empty"));
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NotesBloc>().add(LoadNotes());
                },
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ListTile(
                      onTap: () => showSelectedNoteDialog(context, note),
                      title: Text(note.title),
                      subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      trailing: IconButton(onPressed: (){showDeleteConfirmationDialog(context, note.id);}, icon: Icon(Icons.delete_rounded)),
                    );
                  },
                ),
              );
            }
          } else if (state is NotesError) {
            return Center(child: Text("Error - ${state.message}"));
          } else {
            return Center(child: Text("Error - Something went wrong"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {addNoteDialog(context);},
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}

Future showSelectedNoteDialog(BuildContext context, NotesModel note){
  return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(note.title),
                IconButton(onPressed: ()=> editNoteDialog(context, note.id, note.title, note.content), icon: Icon(Icons.edit_note_rounded))
              ],
            ),
            content: SingleChildScrollView(
              child: Text(note.content),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
              TextButton(
                onPressed: () => showDeleteConfirmationDialog(context, note.id),
                child: Text('Delete'),
              ),
              
            ],
          ),
        );
}