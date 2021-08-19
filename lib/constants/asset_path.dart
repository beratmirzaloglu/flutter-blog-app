final String imageAssetsRoot = "assets/images/";
final String twitterLogo = _getImagePath("twitter-logo.png");
final String facebookLogo = _getImagePath("facebook-logo.png");
final String stockPhoto1 = _getImagePath("stockphoto1.png");
final String stockPhoto2 = _getImagePath("stockphoto2.png");
final String stockPhoto3 = _getImagePath("stockphoto3.png");
final String personStock1 = _getImagePath("personstock1.png");
final String personStock2 = _getImagePath("personstock2.png");
final String personStock3 = _getImagePath("personstock3.png");

final String testImage =
    "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg";

final String testImage2 = 'https://i.hizliresim.com/61d3bb1.png';

String _getImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}
