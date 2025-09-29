import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppNetworkUrl {
  static const bool IS_APP_ENCRYPTED = true;
  static const bool IS_APP_LIVE = false;

  static const String iOS_VERSION = "1.1.3";
  static const String iOS_BUILD= "2";
  static const String ANDROID_VERSION =  "1.1.3";
  static const String ANDROID_BUILD = "2";

  static final String googleKey = dotenv.get('KEY_GOOGLE');
  static final String baseStUrl = IS_APP_LIVE ? dotenv.get('PRODUCTION_URL') : dotenv.get('DEVELOPMENT_URL');

}
