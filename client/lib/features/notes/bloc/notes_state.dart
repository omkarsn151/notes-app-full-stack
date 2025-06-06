import 'package:client/features/notes/data/notes_model.dart';
import 'package:equatable/equatable.dart';

abstract class NotesState extends Equatable {
  const NotesState();
  @override
  List<Object?> get props => [];
} 

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NotesModel> notes;
  const NotesLoaded(this.notes);
  @override
  List<Object?> get props => [notes];
}

class NoteAdded extends NotesState {}

class NoteEdited extends NotesState {}

class NoteDeleted extends NotesState {}

class NotesError extends NotesState {
  final String message;
  const NotesError(this.message);
  @override
  List<Object?> get props => [message];
}

class NotesException extends NotesState {
  final String message;
  const NotesException(this.message);
  @override
  String toString() => message;
}