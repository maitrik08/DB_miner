class ModelClass {
  String quote = '';
  String author = '';
  String category = '';

  ModelClass({required this.quote,required this.author,required this.category});
  ModelClass.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote'] = this.quote;
    data['author'] = this.author;
    data['category'] = this.category;
    return data;
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ModelClass &&
              runtimeType == other.runtimeType &&
              quote == other.quote &&
              author == other.author &&
              category == other.category;

  @override
  int get hashCode => quote.hashCode ^ author.hashCode ^ category.hashCode;
}
