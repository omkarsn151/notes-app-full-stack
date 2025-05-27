import 'package:client/common/app_colors.dart';
import 'package:client/common/custom_text.dart';
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
    return BlocListener<NotesBloc, NotesState>(
      listener: (context, state) {
        if (state is NoteAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Note added successfully!')),
          );
        } else if (state is NoteEdited) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Note edited successfully!')),
          );
        } else if (state is NoteDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Note deleted successfully!')),
          );
        } else if (state is NotesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
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
                return _builNotesScreenContent(notes);
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
      ),
    );
  }

  Widget _builNotesScreenContent(List<NotesModel> notes) {
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
            onDelete: () => showDeleteConfirmationDialog(context, note.id),
            isSelectionMode: selectedNoteIds.isNotEmpty,
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.bgColor,
      title:
          selectedNoteIds.isEmpty
              ? CustomText(
                text: "Notes",
                fontSize: 24,
                fontWeight: FontWeight.w400,
              )
              : Row(
                children: [
                  IconButton(
                    onPressed: clearSelection,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textColor,
                    ),
                  ),
                  CustomText(
                    text: "${selectedNoteIds.length} selected",
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
      centerTitle: true,
      actions:
          selectedNoteIds.isNotEmpty
              ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed:
                      () => showMultipleDeleteConfirmationDialog(context),
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
            onShare: () {
              context.read<NotesBloc>().add(
                ShareNote(title: note.title, content: note.content),
              );
            },
          ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () => showAddNoteDialog(context),
      backgroundColor: AppColors.saveButtonColor,
      foregroundColor: AppColors.bgColor,
      child: Icon(Icons.add_rounded),
    );
  }

  Future<void> _refreshNotes() async {
    context.read<NotesBloc>().add(LoadNotes());
  }
}
