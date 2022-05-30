import 'package:direct_link/direct_link.dart';
import 'package:flutter/material.dart';

abstract class YoutubeConvertService {
  // Obtem um link direto do youtube. /
  static Future<List> convertLinkYoutube(String linkYoutube) async {
    try {
      var check = await DirectLink.check('$linkYoutube');
      return check;
    } catch (e) {
      AlertDialog(
        title: e,
      );
    }
    return null;
  }
}
