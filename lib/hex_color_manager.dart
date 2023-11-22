class ColorHexManager {
  static String previewHex = ''; // Initially empty strings
  static String matchesHex = '';

  static void setPreviewHex(String hex) {
    previewHex = hex;
  }

  static void setMatchesHex(String hex) {
    matchesHex = hex;
  }

  static String getPreviewHex() {
    return previewHex;
  }

  static String getMatchesHex() {
    return matchesHex;
  }
}
