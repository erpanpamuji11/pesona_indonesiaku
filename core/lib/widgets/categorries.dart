import 'package:flutter/material.dart';
import 'package:wisata/presentation/pages/list_wisata_by_category.dart';
import 'package:wisata/presentation/pages/list_wisata_page.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Text(
                "Kategori Wisata",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    _buildCategory(
                        Icon(
                          Icons.nature,
                          color: Colors.white,
                          size: 30,
                        ),
                        'Alam',
                        'Alam'),
                    SizedBox(
                      width: 15,
                    ),
                    _buildCategory(
                        Icon(
                          Icons.mosque,
                          color: Colors.white,
                          size: 30,
                        ),
                        'Religi',
                        'Religi'),
                    SizedBox(
                      width: 15,
                    ),
                    _buildCategory(
                        Icon(
                          Icons.holiday_village_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        'Budaya',
                        'Budaya'),
                    SizedBox(
                      width: 15,
                    ),
                    _buildCategory(
                        Icon(
                          Icons.sports,
                          color: Colors.white,
                          size: 30,
                        ),
                        'Sports',
                        'Sport'),
                    SizedBox(
                      width: 15,
                    ),
                    _buildCategory(
                        Icon(
                          Icons.cast_for_education,
                          color: Colors.white,
                          size: 30,
                        ),
                        'Edukasi',
                        'Edukasi'),
                    SizedBox(
                      width: 15,
                    ),
                    _buildCategory(
                        Icon(
                          Icons.apple,
                          color: Colors.white,
                          size: 30,
                        ),
                        'Botani',
                        'Botani'),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _buildCategory(
      Icon iconButton, String textButton, String categoryWisata) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListWisataByCategoryPage(
                    categoryName: categoryWisata,
                  )),
        );
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.lightBlue),
        child: Column(
          children: [
            Center(
              child: iconButton,
            ),
            Center(
              child: Text(
                textButton,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
