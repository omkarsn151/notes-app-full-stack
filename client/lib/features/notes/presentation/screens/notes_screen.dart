import 'package:client/features/notes/bloc/notes_bloc.dart';
import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:client/features/notes/bloc/notes_state.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:client/features/notes/helper/notes_selection_helper.dart';
import 'package:client/features/notes/presentation/widgets/add_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/delete_note_dialog.dart';
import 'package:client/features/notes/presentation/widgets/empty_widget.dart';
import 'package:client/features/notes/presentation/widgets/error_widget.dart';
import 'package:client/features/notes/presentation/widgets/notes_card.dart';
import 'package:client/features/notes/presentation/widgets/selected_note_dialog.dart';
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
      appBar: _buildAppBar(),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesLoaded) {
            final notes = state.notes;
            if (notes.isEmpty) {
              return const EmptyStateWidget();
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NotesBloc>().add(LoadNotes());
                },
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return NoteCard(
                      note: note,
                      isSelected: selectedNoteIds.contains(note.id),
                      onTap: () {
                        if (selectedNoteIds.isNotEmpty) {
                          toggleSelection(note.id);
                        } else {
                          _showNoteDetailsDialog(note);
                        }
                      },
                      onLongPress: () => toggleSelection(note.id),
                      onDelete:
                          () => showDeleteConfirmationDialog(context, note.id),
                      isSelectionMode: selectedNoteIds.isNotEmpty,
                    );
                  },
                ),
              );
            }
          } else if (state is NotesError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: _refreshNotes,
            );
          } else {
            return Center(child: Text("Error - Something went wrong"));
          }
        },
      ),
      floatingActionButton: selectedNoteIds.isEmpty ? _buildFAB() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title:
          selectedNoteIds.isEmpty
              ? const Text("My Notes")
              : Row(
                children: [
                  IconButton(
                    onPressed: clearSelection,
                    icon: const Icon(Icons.close_rounded),
                  ),
                  Text("${selectedNoteIds.length} selected"),
                ],
              ),
      actions:
          selectedNoteIds.isNotEmpty
              ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed:
                      () => showMultipleDeleteConfirmationDialog(context),
                  tooltip: 'Delete selected',
                ),
                const SizedBox(width: 8),
              ]
              : null,
    );
  }

  void _showNoteDetailsDialog(NotesModel note) {
    showDialog(
      context: context,
      builder:
          (context) => NoteDetailsDialog(
            note: note,
            onEdit: () {
              Navigator.pop(context);
              showEditNoteDialog(context, note);
            },
            onDelete: () {
              Navigator.pop(context);
              showDeleteConfirmationDialog(context, note.id);
            },
          ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () => showAddNoteDialog(context),
      icon: const Icon(Icons.add_rounded),
      label: const Text('New Note'),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
    );
  }

  Future<void> _refreshNotes() async {
    context.read<NotesBloc>().add(LoadNotes());
  }
}
