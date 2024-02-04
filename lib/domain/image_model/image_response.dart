class ImageResponse {
  final String imageUrl;

  ImageResponse({required this.imageUrl});

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(imageUrl: json['message']);
  }
}
