import 'package:flutter/material.dart';
import 'package:shop_app/moduls/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  late String image;
  late String title;
  late String body;
  BoardingModel(this.image,this.title,this.body);
}
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast=false;
  List<BoardingModel>onBoarding=[
    BoardingModel(
      'assets/images/sss.png',
      'On Board 1 Title',
      'On Board 1 body',
    ),
    BoardingModel(
      'assets/images/sss.png',
      'On Board 2 Title',
      'On Board 2 body',
    ),
    BoardingModel(
      'assets/images/sss.png',
      'On Board 3 Title',
      'On Board 3 body',
    ),
  ];

  PageController pageController=PageController();
void submit(){
  CacheHelper.saveData(key: 'OnBoarding', value: true).then((value){
    navigateAndReplace(context, LoginScreen());
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              submit();
            },
            child: Text('SKIP',style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index== onBoarding.length-1){
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    isLast=false;
                  }

                },
                controller: pageController,
                itemBuilder: (context, index)=>buildOnBoardingItem(onBoarding[index]),
                itemCount: onBoarding.length,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count:onBoarding.length  ,
                  axisDirection: Axis.horizontal,
                  effect:  ExpandingDotsEffect(
                    expansionFactor:4,
                      offset: 3.0,
                      spacing:  5.0,
                      radius:  4.0,
                      dotWidth:  10.0,
                      dotHeight:  10.0,
                      strokeWidth:  1.5,
                      dotColor:  Colors.grey,
                      activeDotColor:  defaultColor,
                  ),
                ),
                  Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast==true){
                      submit();
                    }else{
                      pageController.nextPage(
                        duration:Duration(milliseconds: 750) ,
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                },
                child: Icon(Icons.arrow_forward_ios,color:Colors.white ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildOnBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image(
              image: AssetImage('${model.image}'))),
      SizedBox(height: 30.0,),
      Text('${model.title}',style: TextStyle(
          fontSize: 24.0
      ),),
      SizedBox(height: 15.0,),
      Text('${model.body }', style: TextStyle(
          fontSize: 14.0
      ))
    ],
  );
}
