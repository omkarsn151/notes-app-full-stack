//
//  Generated code. Do not modify.
//  source: notes.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use noteDescriptor instead')
const Note$json = {
  '1': 'Note',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `Note`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noteDescriptor = $convert.base64Decode(
    'CgROb3RlEg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSGAoHY29udGVudB'
    'gDIAEoCVIHY29udGVudA==');

@$core.Deprecated('Use addNoteRequestDescriptor instead')
const AddNoteRequest$json = {
  '1': 'AddNoteRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `AddNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNoteRequestDescriptor = $convert.base64Decode(
    'Cg5BZGROb3RlUmVxdWVzdBIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSGAoHY29udGVudBgCIAEoCV'
    'IHY29udGVudA==');

@$core.Deprecated('Use editNoteRequestDescriptor instead')
const EditNoteRequest$json = {
  '1': 'EditNoteRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `EditNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editNoteRequestDescriptor = $convert.base64Decode(
    'Cg9FZGl0Tm90ZVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZR'
    'IYCgdjb250ZW50GAMgASgJUgdjb250ZW50');

@$core.Deprecated('Use noteResponseDescriptor instead')
const NoteResponse$json = {
  '1': 'NoteResponse',
  '2': [
    {'1': 'note', '3': 1, '4': 1, '5': 11, '6': '.notes.Note', '10': 'note'},
  ],
};

/// Descriptor for `NoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noteResponseDescriptor = $convert.base64Decode(
    'CgxOb3RlUmVzcG9uc2USHwoEbm90ZRgBIAEoCzILLm5vdGVzLk5vdGVSBG5vdGU=');

@$core.Deprecated('Use deleteNoteRequestDescriptor instead')
const DeleteNoteRequest$json = {
  '1': 'DeleteNoteRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteNoteRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVOb3RlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use deleteResponseDescriptor instead')
const DeleteResponse$json = {
  '1': 'DeleteResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteResponseDescriptor = $convert.base64Decode(
    'Cg5EZWxldGVSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getAllNotesRequestDescriptor instead')
const GetAllNotesRequest$json = {
  '1': 'GetAllNotesRequest',
};

/// Descriptor for `GetAllNotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllNotesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRBbGxOb3Rlc1JlcXVlc3Q=');

@$core.Deprecated('Use getAllNotesResponseDescriptor instead')
const GetAllNotesResponse$json = {
  '1': 'GetAllNotesResponse',
  '2': [
    {'1': 'notes', '3': 1, '4': 3, '5': 11, '6': '.notes.Note', '10': 'notes'},
  ],
};

/// Descriptor for `GetAllNotesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllNotesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRBbGxOb3Rlc1Jlc3BvbnNlEiEKBW5vdGVzGAEgAygLMgsubm90ZXMuTm90ZVIFbm90ZX'
    'M=');

