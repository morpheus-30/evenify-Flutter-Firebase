import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();
  static Future<void> openMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$address";
    var uri=Uri.parse(googleUrl);
    // final googleUrl='geo:28.9604367,77.7271909';
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,mode: LaunchMode.externalNonBrowserApplication);
    }
  }
}
