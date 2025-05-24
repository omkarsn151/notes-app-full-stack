import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:client/features/notes/bloc/notes_state.dart';
import 'package:client/features/notes/helper/notes_selection_helper.dart';
import 'package:client/features/notes/presentation/widgets/add_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/delete_note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with NotesSelectionHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selectedNoteIds.isEmpty 
                ? Text("Notes")
                : Row(
                  children: [
                    IconButton(onPressed: clearSelection, icon: Icon(Icons.close_rounded)),
                    Text("${selectedNoteIds.length} selected"),
                  ],
                ),
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

