class Book {
  String? bookId;
  String? userId;
  String? bookIsbn;
  String? bookTitle;
  String? bookDesc;
  String? bookAuthor;
  String? bookPrice;
  String? bookQty;
  String? bookDate;

  Book(
      {this.bookId,
      this.userId,
      this.bookIsbn,
      this.bookTitle,
      this.bookDesc,
      this.bookAuthor,
      this.bookPrice,
      this.bookQty,
      this.bookDate});

  Book.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    userId = json['user_id'];
    bookIsbn = json['book_isbn'];
    bookTitle = json['book_title'];
    bookDesc = json['book_desc'];
    bookAuthor = json['book_author'];
    bookPrice = json['book_price'];
    bookQty = json['book_qty'];
    bookDate = json['book_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['book_id'] = bookId;
    data['user_id'] = userId;
    data['book_isbn'] = bookIsbn;
    data['book_title'] = bookTitle;
    data['book_desc'] = bookDesc;
    data['book_author'] = bookAuthor;
    data['book_price'] = bookPrice;
    data['book_qty'] = bookQty;
    data['book_date'] = bookDate;
    return data;
  }
}
