import 'dart:ui';

import 'package:heyto/helpers/quick_help.dart';

class Config {
  static const String packageNameAndroid = "com.angopapo.heyto";
  static const String packageNameiOS = "com.angopapo.heyto";
  static const String iosAppStoreId = "1614015236";
  static const String appName = "Heyto";
  static const String appVersion = "1.2";
  static const String companyName = "Angopapo, Lda";
  static const String appOrCompanyUrl = "www.heyto.live";
  static const String mainAppWebsite = "https://heyto.live";
  static const String appInviteUrl = "https://invite.heyto.live";
  static const String initialCountry = 'US'; // United States

  //static const String serverUrl = "https://server_url/";
  static const String serverUrl = "https://heykissmeapp.b4a.app/";
  static const String liveQueryUrl = "wss://kissme.b4a.io";
  static const String appId = "5fKfVh2H7fTHod8Pzi9jqlL2VodCpIDYMZAKwE3e";
  static const String clientKey = "y81KFo2t61DTkgRrlSM4kUehae65CDNoO2I4dMr2";

  static const String giphyApiKey = "jJluKbA8cAZsWX3w7fOKYaY6Fr83r6bz";

  static const String facebookAppId = "123456789";

  static const String appleLoginClientId = "com.angopapo.heyto.login";
  static const String appleAndroidLoginRedirectUrl =
      "https://verify.heyto.live/apple/login";
  static const String appleWebLoginRedirectUrl = "https://heyto.live";

  static const String pushGcm = "123456789";
  static const String googleIosApiKeyGeo =
      "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  static const String googleAndroidApiKeyGeo =
      "AIzaSyCfbpc6C1DIYqK9CvNyEB2vT4LaDQQr-lY";
  static const String googleWebApiKeyGeo =
      "AIzaSyCfbpc6C1DIYqK9CvNyEB2vT4LaDQQr-lY";
  static const String webPushCertificate =
      "BIQ4K8M3DK5FoUtc4tbq4gKY4CI9tXGveZ9eUPF-TnkUS_VXzYD0CU9T5IsuAmnVLJIgadN3gQEWTMYrSPOjrY0";

  static const String agoraAppId = "ead335b9c8124839a8b4dc9e81c8bf9e";

  // Languages
  static String defaultLanguage = "en"; // English is default language.
  static List<Locale> languages = [
    Locale(defaultLanguage),
    Locale('tr'),
    Locale('ar')
  ];

  // Web payment config
  static const String primaryCurrencyCode = "USD";
  static const String primaryCurrencySymbol = "\$";

  static const double credit100Amount = 0.99;
  static const double credit200Amount = 1.99;
  static const double credit500Amount = 4.99;
  static const double credit1000Amount = 9.99;
  static const double credit2000Amount = 19.99;
  static const double credit5000Amount = 49.99;
  static const double credit10000Amount = 99.99;
  static const double subs1MonthAmount = 14.99;
  static const double subs3MonthAmount = 39.99;

  // Dynamic link
  static const String inviteSuffix = "invitee";
  static const String uriPrefix = "https://kissme.page.link";
  static const String link = "https://kissme.page.link";

  // Android Admob ad
  // static const String admobAndroidRewardedVideoAd =
  //     "ca-app-pub-1084112649181796/8947386305";
  static const String admobAndroidRewardedVideoAd = "";
  // static const String admobAndroidBannerAd =
  //     "ca-app-pub-1084112649181796/3692541266";
  static const String admobAndroidBannerAd = "";
  // static const String admobAndroidOpenAppAd =
  // "ca-app-pub-1084112649181796/7469440028";
  static const String admobAndroidOpenAppAd = "";

  // iOS Admob ad
  // static const String admobIOSRewardedVideoAd =
  //     "ca-app-pub-1084112649181796/1804744529";
  static const String admobIOSRewardedVideoAd = "";
  // static const String admobIOSBannerAd =
  //     "ca-app-pub-1084112649181796/7031669401";
  static const String admobIOSBannerAd = "";
  // static const String admobIOSOpenAppAd =
  //     "ca-app-pub-1084112649181796/3391142959";
  static const String admobIOSOpenAppAd = "";

  // Web links for help, privacy policy and terms of use.
  static const String helpCenterUrl = "https://heyto.live/help.html";
  static const String privacyPolicyUrl = "https://heyto.live/privacy.html";
  static const String termsOfUseUrl = "https://heyto.live/terms.html";
  static const String termsOfUseInAppUrl = "https://heyto.live/terms.html";
  static const String dataSafetyUrl = "https://heyto.live/safety.html";
  static const String dataCommunityUrl = "https://heyto.live/community.html";
  static const String appStoreUrl =
      "https://apps.apple.com/us/app/heyto-live/id1614015236";
  static const String playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.angopapo.heyto";
  static const String angopapoSupportUrl = "https://www.angopapo.com/support";

  // Google Play and Apple Pay In-app Purchases IDs
  static const String credit100 = "heyto.100.credits";
  static const String credit200 = "heyto.200.credits";
  static const String credit500 = "heyto.500.credits";
  static const String credit1000 = "heyto.1000.credits";
  static const String credit2000 = "heyto.2000.credits";
  static const String credit5000 = "heyto.5000.credits";
  static const String credit10000 = "heyto.10000.credits";

  //Google Play In-app Subscription IDs
  static const String subs1Month = "heyto.1.month";
  static const String subs3Months = "heyto.3.month";
}
