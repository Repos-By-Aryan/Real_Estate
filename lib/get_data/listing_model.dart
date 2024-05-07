class ListingModel{
  final Map<String,dynamic> address;
  final int area;
  final String category;
  final Map<String,bool> facilities;
  final Map<String,int> features;
  final String id;
  final List<String> image_urls;
  final Map<String,int> price;
  final String title;
  final Map<String,bool> type;
  final double rating;

  ListingModel({
    required this.title,
    required this.id,
    required this.address,
    required this.area,
    required this.category,
    required this.facilities,
    required this.features,
    required this.image_urls,
    required this.price,
    required this.type,
  required this.rating,
});
}