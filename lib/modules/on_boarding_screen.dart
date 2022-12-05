import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
{
  var boardController = PageController();
  bool isLast = false;

  void submit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigateAndReplace(context, ShopLoginScreen());
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'On Board 1 title',
        image: 'assests/images/onbord.jpg',
        body: 'On Board 1 body'),
    BoardingModel(
        title: 'On Board 2 title',
        image: 'assests/images/onbord.jpg',
        body: 'On Board 2 body'),
    BoardingModel(
        title: 'On Board 3 title',
        image: 'assests/images/onbord.jpg',
        body: 'On Board 3 body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.brightness_4_outlined)),
          TextButton(onPressed: submit, child: const Text('Skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) => buildBoarding(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        expansionFactor: 3, dotWidth: 10, dotHeight: 10)),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.linearToEaseOut);
                    }
                  },
                  child: const Icon(Icons.arrow_circle_right),
                )

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoarding(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(model.image))),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(model.body),
        ],
      );
}
