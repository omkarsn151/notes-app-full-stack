import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
  @override
  List<Object?> get props => [];
}

class LoadNotes extends NotesEvent {
  const LoadNotes();
  @override
  List<Object?> get props => [];
}

class AddNote extends NotesEvent {
  final String title;
  final String content;
  const AddNote(this.title, this.content);

  @override
  List<Object?> get props => [title, content];
}

class EditNote extends NotesEvent {
  final String id;
  final String? title;
  final String? content;
  const EditNote({required this.id, this.title, this.content});
  @override
  List<Object?> get props => [id, title, content];
}

class DeleteNote extends NotesEvent {
  final String id;
  const DeleteNote({required this.id});
  @override
  List<Object?> get props => [id];
}

