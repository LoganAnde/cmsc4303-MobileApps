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
    imageURL: 'https://www.amazon.com/Big-C-2nd-Cay-Horstmann/dp/0470383283/ref=sr_1_2?dchild=1&keywords=big+c%2B%2B&qid=1613443416&s=books&sr=1-2',
  ),
  Course(
    number: 'CMSC 2613',
    title: 'Programming II',
    prereq: 'CMSC 1613',
    imageURL:
        'https://www.amazon.com/Professional-C-Marc-Gregoire/dp/1119421306/ref=sr_1_7?dchild=1&keywords=big+c%2B%2B&qid=1613443899&s=books&sr=1-7',
  ),
  Course(
    number: 'CMSC 3613',
    title: 'Data Structures and Algorithms',
    prereq: 'CMSC 2613',
    imageURL:
        'https://www.amazon.com/Data-Structures-Algorithms-Michael-Goodrich/dp/1118771338/ref=sr_1_5?crid=MM0784XDMVSM&dchild=1&keywords=data+structures+and+algorithms&qid=1613443869&s=books&sprefix=data+str%2Cstripbooks%2C230&sr=1-5',
  ),
  Course(
    number: 'CMSC 4003',
    title: 'Applications of Database Management Systems',
    prereq: 'CMSC 2613',
    imageURL:
        'https://www.amazon.com/Database-Management-Systems-Raghu-Ramakrishnan/dp/0072465638/ref=sr_1_1?crid=1PS34YTO8N3DX&dchild=1&keywords=database+management+systems&qid=1613443922&s=books&sprefix=database+mana%2Cstripbooks%2C183&sr=1-1',
  ),
  Course(
    number: 'CMSC 4023',
    title: 'Programming Languages',
    prereq: 'CMSC 3613',
    imageURL:
        'https://www.amazon.com/Concepts-Programming-Languages-Robert-Sebesta/dp/013394302X/ref=sr_1_6?dchild=1&keywords=programming+languages&qid=1613443936&s=books&sr=1-6',
  ),
  Course(
    number: 'CMSC 4173',
    title: 'Translator Design',
    prereq: 'CMSC 3613',
    imageURL:
        'https://www.amazon.com/Compilers-Principles-Techniques-Tools-2nd/dp/0321486811/ref=sr_1_1?dchild=1&keywords=compilers&qid=1613444026&s=books&sr=1-1',
  ),
];
