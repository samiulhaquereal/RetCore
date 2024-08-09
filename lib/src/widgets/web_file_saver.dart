import 'dart:html' as html;
import 'dart:typed_data' as type;

Future<void> saveFileWeb(type.Uint8List fileResponse, String baseFileName, String extension) async {
  final blob = html.Blob([fileResponse]);
  final blobUrl = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: blobUrl)
    ..setAttribute('download', '$baseFileName.$extension')
    ..click();
  html.Url.revokeObjectUrl(blobUrl);
}
