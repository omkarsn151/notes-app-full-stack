import 'package:client/core/grpc/notes.pbgrpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grpc/grpc.dart';

class GrpcClient {
  static final GrpcClient _singleton = GrpcClient._internal();
  late NoteServiceClient stub;
  late ClientChannel _channel;

  factory GrpcClient() => _singleton;

  GrpcClient._internal() {
    final IP = dotenv.env["IP"]!;
    final PORT = int.parse(dotenv.env["PORT"]!);

    _channel = ClientChannel(
      IP,
      port: PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.secure(), 
      ),
    );

    stub = NoteServiceClient(_channel);
  }

  Future<void> shutdown() async {
    await _channel.shutdown();
  }
}
