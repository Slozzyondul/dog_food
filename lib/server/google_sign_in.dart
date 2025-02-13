import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:http/http.dart' as http;

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'https://www.googleapis.com/auth/spreadsheets',
  ],
);

Future<void> submitDataToSheet(String name, String email, String mobile, String message) async {
  try {
    // Authenticate the user
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      print("User not signed in.");
      return;
    }
    // Get the authentication token
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final accessToken = googleAuth.accessToken;

    if (accessToken == null) {
      print("Access token is null.");
      return;
    }
    // Create an authenticated HTTP client
    final authClient = GoogleAuthClient(accessToken);
    // Initialize the Sheets API
    final sheetsApi = SheetsApi(authClient);
    // Define the spreadsheet ID and range
    const spreadsheetId = '1HprlT9vK5s6cJ1z6R8QfYYMEtOOkd11eLYsCeFOyXyM';
    const range = 'websiteSubmissions!A:C';
    // Prepare the data to be sent
    final valueRange = ValueRange.fromJson({
      'values': [
        [name, email, mobile, message],
      ],
    });
    // Append the data to the spreadsheet
    await sheetsApi.spreadsheets.values.append(
      valueRange,
      spreadsheetId,
      range,
      valueInputOption: 'USER_ENTERED',
    );
    print("Data submitted successfully!");
  } catch (e) {
    print("Error submitting data: $e");
  }
}

// Custom HTTP client for authentication
class GoogleAuthClient extends http.BaseClient {
  final String accessToken;
  final http.Client _client = http.Client();

  GoogleAuthClient(this.accessToken);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['Authorization'] = 'Bearer $accessToken';
    return _client.send(request);
  }
}
