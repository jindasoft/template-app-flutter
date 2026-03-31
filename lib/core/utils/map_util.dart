import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMap(double lat, double lon) async {
  final url = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=$lat,$lon',
  );
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
