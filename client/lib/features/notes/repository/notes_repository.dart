import 'package:client/core/grpc/notes.pbgrpc.dart';
import 'package:client/core/utils/grpc_client.dart';

class NotesRepository {
  final NoteServiceClient client = GrpcClient().stub;

  Future<List<Note>> getAllNotes() async {
    try {
      final response = await client.getAllNotes(GetAllNotesRequest());
      return response.notes;
    } on Exception catch (e) {
      throw Exception("Failed to fetch notes - $e");
    }
  }

  Future<Note> addNote(String title, String content) async {
    try {
      final response = await client.addNote(
        AddNoteRequest()
          ..title = title
          ..content = content,
      );
      return response.note;
    } on Exception catch (e) {
      throw Exception("Failed to add note - $e");
    }
  }

  Future<Note> editNote(String id, String title, String content) async {
    try {
      final response = await client.editNote(
        EditNoteRequest()
          ..id = id
          ..title = title
          ..content = content,
      );
      return response.note;
    } on Exception catch (e) {
      throw Exception("Failed to edit note - $e");
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await client.deleteNote(DeleteNoteRequest()..id = id);
    } on Exception catch (e) {
      throw Exception("Failed to delete note - $e");
    }
  }
}
