final String imageAssetsRoot = "assets/images/";
final String twitterLogo = _getImagePath("twitter-logo.png");
final String facebookLogo = _getImagePath("facebook-logo.png");
final String stockPhoto1 = _getImagePath("stockphoto1.png");
final String stockPhoto2 = _getImagePath("stockphoto2.png");
final String stockPhoto3 = _getImagePath("stockphoto3.png");
final String personStock1 = _getImagePath("personstock1.png");

String _getImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}
