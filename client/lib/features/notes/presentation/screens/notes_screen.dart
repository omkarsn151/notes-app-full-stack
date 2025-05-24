import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:client/features/notes/bloc/notes_state.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:client/features/notes/presentation/widgets/add_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/delete_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/edit_note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final Set<String> selectedNoteIds = {};

  void toggleSelection(String id) {
    setState(() {
      if (selectedNoteIds.contains(id)) {
        selectedNoteIds.remove(id);
      } else {
        selectedNoteIds.add(id);
      }
    });
  }

  void clearSelection() {
    setState(() {
      selectedNoteIds.clear();
    });
  }

  void deleteSelectedNotes() {
    for (final id in selectedNoteIds) {
      context.read<NotesBloc>().add(DeleteNote(id: id));
    }
    clearSelection();
  }

  void showMultipleDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete ${selectedNoteIds.length} notes"),
          content: Text("Are you sure you want to delete the selected notes?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            TextButton(
              onPressed: () {
                deleteSelectedNotes();
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedNoteIds.isEmpty ? "Notes" : "${selectedNoteIds.length} selected"),
        actions: selectedNoteIds.isNotEmpty
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed:()=> showMultipleDeleteConfirmationDialog(context),
                ),
              ]
            : null,
      ),
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
                    final isSelected = selectedNoteIds.contains(note.id);
                    return ListTile(
                      onTap: () {
                        if (selectedNoteIds.isNotEmpty) {
                          toggleSelection(note.id);
                        } else {
                          showSelectedNoteDialog(context, note);
                        }
                      },
                      onLongPress: () => toggleSelection(note.id),
                      title: Text(note.title),
                      subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      trailing: selectedNoteIds.isEmpty
                          ? IconButton(
                              icon: Icon(Icons.delete_rounded),
                              onPressed: () => showDeleteConfirmationDialog(context, note.id),
                            )
                          : Icon(
                              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            ),
                      tileColor: isSelected ? Colors.grey[300] : null,
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