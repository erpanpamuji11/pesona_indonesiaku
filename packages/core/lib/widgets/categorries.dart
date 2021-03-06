import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisata/presentation/pages/list_wisata_by_category.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: const Text(
                "Kategori Wisata",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 75,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  _buildCategory('assets/icons/nature.svg', 'Alam', 'Alam'),
                  const SizedBox(
                    width: 16,
                  ),
                  _buildCategory('assets/icons/mosque.svg', 'Religi', 'Religi'),
                  const SizedBox(
                    width: 16,
                  ),
                  _buildCategory(
                      'assets/icons/necklace.svg', 'Budaya', 'Budaya'),
                  const SizedBox(
                    width: 16,
                  ),
                  _buildCategory('assets/icons/soccer.svg', 'Sports', 'Sport'),
                  const SizedBox(
                    width: 16,
                  ),
                  _buildCategory(
                      'assets/icons/learning.svg', 'Edukasi', 'Edukasi'),
                  const SizedBox(
                    width: 16,
                  ),
                  _buildCategory('assets/icons/sprout.svg', 'Botani', 'Botani'),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildCategory(
      String iconButton, String textButton, String categoryWisata) {
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
        width: 75,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.lightBlueAccent),
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                iconButton,
                width: 38,
                height: 38,
              ),
            ),
            Center(
              child: Text(
                textButton,
                style: const TextStyle(
                    fontSize: 12,
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
