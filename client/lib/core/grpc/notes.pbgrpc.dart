//
//  Generated code. Do not modify.
//  source: notes.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'notes.pb.dart' as $0;

export 'notes.pb.dart';

@$pb.GrpcServiceName('notes.NoteService')
class NoteServiceClient extends $grpc.Client {
  static final _$addNote = $grpc.ClientMethod<$0.AddNoteRequest, $0.NoteResponse>(
      '/notes.NoteService/AddNote',
      ($0.AddNoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.NoteResponse.fromBuffer(value));
  static final _$editNote = $grpc.ClientMethod<$0.EditNoteRequest, $0.NoteResponse>(
      '/notes.NoteService/EditNote',
      ($0.EditNoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.NoteResponse.fromBuffer(value));
  static final _$deleteNote = $grpc.ClientMethod<$0.DeleteNoteRequest, $0.DeleteResponse>(
      '/notes.NoteService/DeleteNote',
      ($0.DeleteNoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteResponse.fromBuffer(value));
  static final _$getAllNotes = $grpc.ClientMethod<$0.GetAllNotesRequest, $0.GetAllNotesResponse>(
      '/notes.NoteService/GetAllNotes',
      ($0.GetAllNotesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAllNotesResponse.fromBuffer(value));

  NoteServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.NoteResponse> addNote($0.AddNoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addNote, request, options: options);
  }

  $grpc.ResponseFuture<$0.NoteResponse> editNote($0.EditNoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$editNote, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteResponse> deleteNote($0.DeleteNoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteNote, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAllNotesResponse> getAllNotes($0.GetAllNotesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllNotes, request, options: options);
  }
}

@$pb.GrpcServiceName('notes.NoteService')
abstract class NoteServiceBase extends $grpc.Service {
  $core.String get $name => 'notes.NoteService';

  NoteServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AddNoteRequest, $0.NoteResponse>(
        'AddNote',
        addNote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddNoteRequest.fromBuffer(value),
        ($0.NoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EditNoteRequest, $0.NoteResponse>(
        'EditNote',
        editNote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EditNoteRequest.fromBuffer(value),
        ($0.NoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteNoteRequest, $0.DeleteResponse>(
        'DeleteNote',
        deleteNote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteNoteRequest.fromBuffer(value),
        ($0.DeleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAllNotesRequest, $0.GetAllNotesResponse>(
        'GetAllNotes',
        getAllNotes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAllNotesRequest.fromBuffer(value),
        ($0.GetAllNotesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.NoteResponse> addNote_Pre($grpc.ServiceCall $call, $async.Future<$0.AddNoteRequest> $request) async {
    return addNote($call, await $request);
  }

  $async.Future<$0.NoteResponse> editNote_Pre($grpc.ServiceCall $call, $async.Future<$0.EditNoteRequest> $request) async {
    return editNote($call, await $request);
  }

  $async.Future<$0.DeleteResponse> deleteNote_Pre($grpc.ServiceCall $call, $async.Future<$0.DeleteNoteRequest> $request) async {
    return deleteNote($call, await $request);
  }

  $async.Future<$0.GetAllNotesResponse> getAllNotes_Pre($grpc.ServiceCall $call, $async.Future<$0.GetAllNotesRequest> $request) async {
    return getAllNotes($call, await $request);
  }

  $async.Future<$0.NoteResponse> addNote($grpc.ServiceCall call, $0.AddNoteRequest request);
  $async.Future<$0.NoteResponse> editNote($grpc.ServiceCall call, $0.EditNoteRequest request);
  $async.Future<$0.DeleteResponse> deleteNote($grpc.ServiceCall call, $0.DeleteNoteRequest request);
  $async.Future<$0.GetAllNotesResponse> getAllNotes($grpc.ServiceCall call, $0.GetAllNotesRequest request);
}
