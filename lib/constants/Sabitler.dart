import 'dart:ui';

class sabitler {
//colors
  static const Color clr_purple = Color(0xFF9C27B0);
  static const Color clr_blue = Color(0xFF548CFF);
  static const Color clr_red = Color(0xFFF44336);
  static const Color clr_orange = Color(0xFFFF682D);
  static const Color clr_light_grey = Color(0xAAD3D3D3);

  //static const String url = "http://172.22.20.255/mobilservice";
  static const String url = "http://api.kocaeli.bel.tr";
  static const String urlGetSeans = "/TiyatroApi/api/GetSeansList";
  static const String urlBiletNo = "/TiyatroApi/api/GetBiletDetay?BiletNo=";
  // static const String loginApi = url + "/api/CheckUser";
  static const String urlSalonGiris = "/TiyatroApi/api/BiletSalonGiris";

  static String userData = "USER_DATA";
  static String isOnBoard = "IS_ONBOARD";
  static String isLoggedIn = "IS_LOGGED_IN";

  //Validations REGEX
  static const String PATTERN_EMAIL =
      "^([0-9a-zA-Z]([-.+\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})\$";
  static const String PATTERN_GSM = "([(+]*[0-9]+[()+. -]*)";

  //URL For list of photos
  // static const String accessKey =
  //     "f9a49fde-8b0a-4a1f-bd13-0a49749226e1";

  // static const String accessToken = "D9D39CBB-7EE9-46E8-80A1-3A64F589AA29";

  static const String authorization = "b44ef1e1-e03e-43cc-9391-29906ec77977";
}
