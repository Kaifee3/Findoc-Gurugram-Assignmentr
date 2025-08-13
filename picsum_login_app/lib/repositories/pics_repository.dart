import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/picture.dart';

class PicsRepository {
  final http.Client client;
  PicsRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<Picture>> fetchPics({int limit = 10}) async {
    final uri = Uri.parse('https://picsum.photos/v2/list?limit=$limit');
    final resp = await client.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Failed to load pictures');
    }
    final List<dynamic> data = jsonDecode(resp.body);
    return data.map((e) => Picture.fromJson(e)).toList();
  }
}
