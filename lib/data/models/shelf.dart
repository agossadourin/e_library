class Shelf {
  final String id;
  final String slug;
  final double lastModified;
  final String title;
  final User user;
  int bookCount;
  List<String> booksIds = [];

  Shelf({
    required this.id,
    required this.slug,
    required this.lastModified,
    required this.title,
    required this.user,
    this.bookCount = 0,
  });

  factory Shelf.fromJson(Map<String, dynamic> json) {
    return Shelf(
      id: json['id'],
      slug: json['slug'],
      lastModified: json['last_modified'],
      title: json['title'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'last_modified': lastModified,
      'title': title,
      'user': user.toJson(),
      'book_count': bookCount,
    };
  }
}

class User {
  final String id;
  final String name;
  final String username;
  final String? cover;
  final String image;

  User({
    required this.id,
    required this.name,
    required this.username,
    this.cover,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      cover: json['cover'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'cover': cover,
      'image': image,
    };
  }
}
