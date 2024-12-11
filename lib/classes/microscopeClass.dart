class MicroscopePart {
  final String title;
  final List<String> descriptions;

  MicroscopePart(this.title, this.descriptions);

  factory MicroscopePart.fromJson(Map<String, dynamic> json) {
    return MicroscopePart(json['title'] as String, json['descriptions'] as List<String>);
  }
}