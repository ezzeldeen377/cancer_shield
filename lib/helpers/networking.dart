import 'dart:convert';
import 'package:cancer_shield/models/prediction_response.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HttpService {
  final String baseUrl = "http://10.0.2.2:5281/api/";
  final String skin = "https://a9b7-34-125-160-118.ngrok-free.app/predict";
  final String colon = "https://1ea8-34-125-135-186.ngrok-free.app/predict";
  static final HttpService instance = HttpService._internal();

  factory HttpService() => instance;

  HttpService._internal();

  /// Performs a GET request
  Future<Either<String, Map<String, dynamic>?>> get(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
      return _handleResponse(response);
    } on Exception catch (e) {
      print("GET Error: $e");
      return Left(e.toString());
    }
  }

  /// Performs a POST request
  Future<Either<String, Map<String, dynamic>?>> post(String endpoint,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    try {
      print('hgfhgf');
      final response = await http.post(Uri.parse('$baseUrl$endpoint'),
          headers: headers ?? _defaultHeaders, body: jsonEncode(body));
      return _handleResponse(response);
    } on Exception catch (e) {
      print("POST Error: $e");
      return Left(e.toString());
    }
  }

  /// Performs a PUT request
  Future<Either<String, Map<String, dynamic>?>> put(String endpoint,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl$endpoint'),
          headers: headers ?? _defaultHeaders, body: jsonEncode(body));
      return _handleResponse(response);
    } on Exception catch (e) {
      print("PUT Error: $e");
      return Left(e.toString());
    }
  }

  /// Performs a DELETE request
  Future<Either<String, Map<String, dynamic>?>> delete(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
      return _handleResponse(response);
    } on Exception catch (e) {
      print("DELETE Error: $e");
      return Left(e.toString());
    }
  }

  /// Handles the API response
  Either<String, Map<String, dynamic>?> _handleResponse(
      http.Response response) {
    final contentType = response.headers['content-type'] ?? '';

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        // Check if the response body contains JSON
        if (contentType.contains('application/json')) {
          final decodedBody = jsonDecode(response.body);

          if (decodedBody is Map<String, dynamic>) {
            return Right(decodedBody);
          } else {
            return Right({'data': decodedBody});
          }
        } else {
          return Right({'message': response.body}); // Treat as plain string
        }
      } catch (e) {
        return Right({'message': response.body}); // Handle non-JSON response
      }
    } else {
      try {
        // Check if the response body contains JSON
        if (contentType.contains('application/json')) {
          return Left(
              (jsonDecode(response.body) as Map<String, dynamic>)['error']);
        } else {
          return Left(response.body); // Treat as plain string
        }
      } catch (e) {
        return Left(response.body); // Treat as plain string
      }
    }
  }

  /// Default headers for JSON requests
  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Either<String, PredictionResponse>> requestPredict(
      int selected, XFile image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(selected == 0 ? skin : colon),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
      ),
    );

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return Right(PredictionResponse.fromJson(response.body));
    } else {
      return Left(
          "Failed to upload image. Status Code: ${response.statusCode}");
    }
  }
}
