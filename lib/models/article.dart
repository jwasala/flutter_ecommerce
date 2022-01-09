class Article {
  final int articleId;
  final String name;
  final String? description;
  final String imagePath;
  final double price;
  final int categoryId;

  Article(this.articleId, this.name, this.description, this.imagePath,
      this.price, this.categoryId);
}
