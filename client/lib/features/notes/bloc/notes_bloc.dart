import 'package:client/features/notes/bloc/notes_event.dart';
import 'package:client/features/notes/bloc/notes_state.dart';
import 'package:client/features/notes/data/notes_model.dart';
import 'package:client/features/notes/repository/notes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository repository;

  NotesBloc(this.repository) : super(NotesInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<EditNote>(_onEditNote);
    on<DeleteNote>(_onDeleteNote);
    on<ShareNote>(_onShareNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final grpcNotes = await repository.getAllNotes();
      final notes = grpcNotes.map((note) => NotesModel.fromGrpc(note)).toList();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError("Failed to load Notes - $e"));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      await repository.addNote(event.title, event.content);
      emit(NoteAdded());
      add(LoadNotes());
    } catch (e) {
      emit(NotesError("Failed to add note - $e"));
    }
  }

  Future<void> _onEditNote(EditNote event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      await repository.editNote(event.id, event.title!, event.content!);
      emit(NoteEdited());
      add(LoadNotes());
    } catch (e) {
      emit(NotesError("Failed to edit note - $e"));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      await repository.deleteNote(event.id);
      emit(NoteDeleted());
      add(LoadNotes());
    } catch (e) {
      emit(NotesError("Failed to Delete note - $e"));
    }
  }

  Future<void> _onShareNote(ShareNote event, Emitter<NotesState> emit) async {
    final shareContent = '${event.title}\n\n${event.content}';
    try {
      await SharePlus.instance.share(ShareParams(text: shareContent));
    } catch (e) {
      emit(NotesError("Failed to share note - $e"));
    }
  }
}
