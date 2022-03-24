


class Book{
  late String imageUrl;
  late String title;
  late String summary;
  late String ratingStar;
  late String bookGenre;

  Book({
    required this.imageUrl,
    required this.title,
    required this.bookGenre,
    required this.ratingStar,
    required this.summary
});

}
List<Book> bookData = [
  Book(
      imageUrl: 'https://media1.popsugar-assets.com/files/thumbor/-jnzfrck7Q1Oy2p2wfAuQylfWw4/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2021/03/12/723/n/47737404/bfa03b7753108d76_71TobjVb6BL/i/best-ya-fantasy-books-with-black-main-characters.jpg',
      title: 'Blood Like Magic',
      bookGenre: 'horror, fantasy',
      ratingStar: '⭐⭐⭐⭐',
      summary: 'Set in the year 2049 in Toronto, Voya Thomas is called by her ancestors and given a challenge in order to receive her magic. Afraid of being banished and humiliated because she refused her calling, her ancestor Mama Jova force her to witness her execution...'
  ),
  Book(
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0ZSd-grNn2bcfLUbUrlCkbp7ishAsrvbdcg&usqp=CAU',
      title: 'The She was Gone',
      bookGenre: 'Romance, thriller',
      ratingStar: '⭐⭐⭐',
      summary: 'Set in the year 2049 in Toronto, Voya Thomas is called by her ancestors and given a challenge in order to receive her magic. Afraid of being banished and humiliated because she refused her calling, her ancestor Mama Jova force her to witness her execution...'
  ),
  Book(
      imageUrl: 'https://m.media-amazon.com/images/I/51pSjsxUgEL.jpg',
      title: 'Chariots of Gods',
      bookGenre: 'fantasy',
      ratingStar: '⭐⭐⭐⭐⭐',
      summary: 'Set in the year 2049 in Toronto, Voya Thomas is called by her ancestors and given a challenge in order to receive her magic. Afraid of being banished and humiliated because she refused her calling, her ancestor Mama Jova force her to witness her execution...'
  ),
  Book(
      imageUrl: 'https://media1.popsugar-assets.com/files/thumbor/JWgHnBeDTd9SDUmjXKr4oYvqELs/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2021/05/19/856/n/1922283/2130104860a567e911deb2.99901336_/i/best-books-on-booktok.jpg',
      title: 'The House in the sea',
      bookGenre: 'horror, fantasy',
      ratingStar: '⭐⭐',
      summary: 'Set in the year 2049 in Toronto, Voya Thomas is called by her ancestors and given a challenge in order to receive her magic. Afraid of being banished and humiliated because she refused her calling, her ancestor Mama Jova force her to witness her execution...'
  ),
];