import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/app_components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  // there is a controller to many widgets and the benefit of these controllers
  // is to control the widget from other places than the default place
  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/on_boarding1.png',
        title: 'Title 1',
        body: 'body 1'),
    BoardingModel(
        image: 'assets/images/on_boarding1.png',
        title: 'Title 2',
        body: 'body 2'),
    BoardingModel(
        image: 'assets/images/on_boarding1.png',
        title: 'Title 3',
        body: 'body 3'),
  ];


  bool _isLast = false;

  void submit(BuildContext context){
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if(value){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(),
          ),
        );
      }});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: ()=>submit(context),
              text: 'SKIP',),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    _isLast = true;
                  } else {
                    _isLast = false;
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  // that changes the shape of indicator
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 3,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                // the spacer will take the remaining space between the two items
                Spacer(),

                FloatingActionButton(
                  onPressed: () {
                    if (_isLast) {
                      submit(context);
                    }
                    boardController.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );


  }
  


  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(model.image),
            ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
