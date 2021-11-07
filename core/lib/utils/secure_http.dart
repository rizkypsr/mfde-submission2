import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

Future<SecurityContext> get globalContext async {
  final sslCert1 = await rootBundle.load('certificates/certificate.pem');
  SecurityContext sc = SecurityContext(withTrustedRoots: false);
  sc.setTrustedCertificatesBytes(sslCert1.buffer.asInt8List());
  return sc;
}

createClient() async {
  HttpClient _client = HttpClient(context: await globalContext);
  _client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient _ioClient = IOClient(_client);

  return _ioClient;
}

class SecureHttp {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createClient();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();
  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
