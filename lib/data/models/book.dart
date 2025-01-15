class Author {
  final String id;
  final String name;
  final String slug;

  Author({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}

class BookDetails {
  final String id;
  final String slug;

  BookDetails({
    required this.id,
    required this.slug,
  });

  factory BookDetails.fromJson(Map<String, dynamic> json) {
    return BookDetails(
      id: json['id'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
    };
  }
}

class Can {
  final bool print;
  //final bool access;

  Can({
    required this.print,
    //required this.access,
  });

  factory Can.fromJson(Map<String, dynamic> json) {
    return Can(
      print: json['print'],
      //access: json['access'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'print': print,
      //'access': access,
    };
  }
}

class Extents {
  final int glPages;

  Extents({
    required this.glPages,
  });

  factory Extents.fromJson(Map<String, dynamic> json) {
    return Extents(
      glPages: json['gl_pages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gl_pages': glPages,
    };
  }
}

class Book {
  final String id;
  final List<Author> authors;
  final BookDetails bookDetails;
  //final Can can;
  final String form;
  final String language;
  final String shortTitle;
  final String title;
  final String description;
  final Extents extents;
  final String isbn;
  final String publisher;
  final List<String> tags;
  final String image;
  //final bool adult;
  //final bool isFree;

  Book({
    required this.id,
    required this.authors,
    required this.bookDetails,
    //required this.can,
    required this.form,
    required this.language,
    required this.shortTitle,
    required this.title,
    required this.description,
    required this.extents,
    required this.isbn,
    required this.publisher,
    required this.tags,
    required this.image,
    // required this.adult,
    //required this.isFree,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      authors:
          (json['authors'] as List).map((i) => Author.fromJson(i)).toList(),
      bookDetails: BookDetails.fromJson(json['book']),
      //can: Can.fromJson(json['can']),
      form: json['form'],
      language: json['language'],
      shortTitle: json['short_title'],
      title: json['title'],
      description: json['description'] ?? '',
      extents: Extents.fromJson(json['extents'] ?? {"gl_pages": 0}),
      isbn: json['isbn'] ?? '',
      publisher: json['publisher'],
      tags: List<String>.from(json['tags']),
      image: json['image'] ?? '',
      //adult: json['adult'],
      //isFree: json['is_free'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authors': authors.map((author) => author.toJson()).toList(),
      'book': bookDetails.toJson(),
      //'can': can.toJson(),
      'form': form,
      'language': language,
      'short_title': shortTitle,
      'title': title,
      'description': description,
      'extents': extents.toJson(),
      'isbn': isbn,
      'publisher': publisher,
      'tags': tags,
      'image': image,
      //'adult': adult,
      //'is_free': isFree,
    };
  }
}
