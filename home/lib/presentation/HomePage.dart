import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const ROUTE_NAME = "/HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Discover \nPesona Indonesia",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 46,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade700,
                            ),
                            border: InputBorder.none,
                            hintText: "Temukan Wisata Impianmu",
                            hintStyle: TextStyle(color: Colors.grey.shade500)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: Center(),
      ),
    );
  }
}
