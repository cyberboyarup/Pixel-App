class WallpaperModel {
  late String url;
  late String photographer;
  late String photographerUrl;
  late int photographerId;
  late SrcModel src;

  WallpaperModel(
      {required this.url,
      required this.photographer,
      required this.photographerUrl,
      required this.photographerId,
      required this.src});
  factory WallpaperModel.fromMap(Map<String, dynamic> parsedJson) {
    return WallpaperModel(
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  late String portrait;
  late String large;
  late String landscape;
  late String medium;

  SrcModel(
      {required this.portrait,
      required this.landscape,
      required this.large,
      required this.medium});
  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}
