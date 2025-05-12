import 'package:client/core/grpc/notes.pb.dart';
import 'package:equatable/equatable.dart';

class NotesModel extends Equatable {
  final String id;
  final String title;
  final String content;

  const NotesModel({
    required this.id,
    required this.title,
    required this.content,
  });

  /// Factory constructor to create a model from gRPC-generated Note object.
  factory NotesModel.fromGrpc(Note note) {
    return NotesModel(
      id: note.id,
      title: note.title,
      content: note.content,
    );
  }

  /// Converts model back to gRPC Note object.
  Note toGrpc() {
    return Note()
      ..id = id
      ..title = title
      ..content = content;
  }

  /// Support copyWith pattern
  NotesModel copyWith({String? id, String? title, String? content}) {
    return NotesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props => [id, title, content];
}
