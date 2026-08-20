part of core;

class ApiConstants {
  const ApiConstants._();

  static const String apiBaseUrl = "https://api-zahab.dev-moltaqa.cloud";
  // static const String apiBaseUrl = "https://api-zahab-moltaqa.cloud";

  static String addToApiUrlPath(String url) {
    return "/api/v1/client/$url";
  }

  static String apiKey =
      "eyJpdiI6IjF3cUZNaEs1NVh3RUZNdlVJTDk3Y2c9PSIsInZhbHVlIjoiQzlndGhNSUVZeTRVUmwvZnR3WGZuaDNaTUxObVZ6RXBNbmFITkRKWUtsTDFXUUIrQkkxMzkvWG9KTDc1K2Z0NiIsIm1hYyI6IjNkNWVlYWI5NjBmMGYxZWU5YzIzYWQzZjk1YjRjMDA3NWFhMDVkMmU3NmExM2ExYzBmM2ExYzNhNmEwOTU4N2IiLCJ0YWciOiIifQ==";

  static const bool isDebug = kDebugMode;
  static const bool canLog = true;
}
