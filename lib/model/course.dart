class Course {
  String number;
  String title;
  String prereq;
  String imageURL;

  Course({
    this.imageURL,
    this.number,
    this.title,
    this.prereq,
  });
}

var courseList = [
  Course(
    number: 'CMSC 1613',
    title: 'Programming I',
    prereq: 'CMSC 1513',
    imageURL: 'https://m.media-amazon.com/images/I/517rMbNEp+L._AC_UY218_.jpg',
  ),
  Course(
    number: 'CMSC 2613',
    title: 'Programming II',
    prereq: 'CMSC 1613',
    imageURL: 'https://m.media-amazon.com/images/I/71AjIOiBfbL._AC_UY218_.jpg',
  ),
  Course(
    number: 'CMSC 3613',
    title: 'Data Structures and Algorithms',
    prereq: 'CMSC 2613',
    imageURL: 'https://m.media-amazon.com/images/I/81yKcOgvLyL._AC_UL320_.jpg',
  ),
  Course(
    number: 'CMSC 4003',
    title: 'Applications of Database Management Systems',
    prereq: 'CMSC 2613',
    imageURL: 'https://m.media-amazon.com/images/I/61Ujgsyoo0L._AC_UY218_.jpg',
  ),
  Course(
    number: 'CMSC 4023',
    title: 'Programming Languages',
    prereq: 'CMSC 3613',
    imageURL: 'https://m.media-amazon.com/images/I/51T5KoQZqNL._AC_UL320_.jpg',
  ),
  Course(
    number: 'CMSC 4173',
    title: 'Translator Design',
    prereq: 'CMSC 3613',
    imageURL: 'https://m.media-amazon.com/images/I/41yj7k3l45L._AC_UL320_.jpg',
  ),
];
