import 'package:authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = '/onBoardingPage';
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            // buildOnboardingPage(Colors.amberAccent, 'assets/images/wisata.png', 'Wisata Indonesia', 'Ribuan Wisata menarik dan Populer di Seluruh Indonesia hanya dalam satu genggaman'),
            // buildOnboardingPage(Colors.green, 'assets/images/umkm2.png', 'UMKM Indonesia', 'Temukan UMKM terbaik di Sekitar Wisata dengan berbagai bidang bisnis dan terpercaya'),
            // buildOnboardingPage(Colors.lightBlue, 'assets/images/travel.png', 'Jelajahi Pesona Indonesia \nSekarang Juga', 'Rakyat Makmur Indonesia Jaya'),
            buildOnboardingPage('assets/images/wisata.png', 'Wisata Indonesia', 'Ribuan Wisata menarik dan Populer di Seluruh Indonesia hanya dalam satu genggaman'),
            buildOnboardingPage('assets/images/umkm.png', 'UMKM Indonesia', 'Temukan UMKM terbaik di Sekitar Wisata dengan berbagai bidang bisnis dan terpercaya'),
            buildOnboardingPage('assets/images/travel.png', 'Jelajahi Pesona Indonesia \nSekarang Juga', 'Rakyat Makmur Indonesia Jaya'),
          ],

        ),
      ),
      bottomSheet: isLastPage ?
      TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.lightBlue,
          minimumSize: const Size.fromHeight(80)
        ),
        child: const Text('Get Started',
        style: TextStyle(fontSize: 24),),
        onPressed: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage())
          );
        },
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              controller.jumpToPage(2);
            }, child: Text('SKIP', style: TextStyle(fontWeight: FontWeight.w900),)),
            Center(child: SmoothPageIndicator(
              count: 3, controller: controller,
              effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.lightBlue
              ),
              onDotClicked: (index) => controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn),
            ),),
            TextButton(onPressed: (){
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            }, child: const Text('NEXT', style: TextStyle(fontWeight: FontWeight.w900),))
          ],
        ),
      ),
    );
  }
  
  Widget buildOnboardingPage(String urlImg, String title, String subtitle) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 64,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(urlImg, fit: BoxFit.cover, width: double.infinity,),
          ),
          const SizedBox(height: 64,),
          Text(title, style: TextStyle(color: Colors.lightBlue, fontSize: 32, fontWeight: FontWeight.bold),),
          const SizedBox(height: 24,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              subtitle,
              style: const TextStyle(color: Colors.lightBlue, fontSize: 22),
            ),
          )
        ],
      ),
    );
  }
}
