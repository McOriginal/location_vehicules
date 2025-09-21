// import 'package:http/http.dart' as http;
// import '../utils/constants.dart';

// class ApiClient {
//   final http.Client client;

//   ApiClient({http.Client? client}) : client = client ?? http.Client();

//   Future<http.Response> get(String path, {Map<String, String>? headers}) {
//     return client.get(Uri.parse('$BASE_URL$path'),
//         headers: headers ?? defaultHeaders);
//   }

//   Future<http.Response> post(String path,
//       {Map<String, String>? headers, Object? body}) {
//     return client.post(Uri.parse('$BASE_URL$path'),
//         headers: headers ?? defaultHeaders, body: body);
//   }

//   Future<http.Response> put(String path,
//       {Map<String, String>? headers, Object? body}) {
//     return client.put(Uri.parse('$BASE_URL$path'),
//         headers: headers ?? defaultHeaders, body: body);
//   }

//   Future<http.Response> delete(String path, {Map<String, String>? headers}) {
//     return client.delete(Uri.parse('$BASE_URL$path'),
//         headers: headers ?? defaultHeaders);
//   }
// }

// const defaultHeaders = {'Content-Type': 'application/json'};
