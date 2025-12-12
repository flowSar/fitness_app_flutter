import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';


class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    final List<Map<String, Object>>? breakfast =
        FakeDatabase.nutritionPlans['breakfasts'];
    final List<Map<String, Object>>? lunches =
        FakeDatabase.nutritionPlans['lunches'];
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nutrition",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Tips & healthy recipes',
                style: TextStyle(color: Colors.grey.shade800),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.green, Colors.blueAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tip of the Day",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Drink a glass of water before each meal. It helps with digestion and can prevent overeating.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Breakfasts",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/viewMoreNutrition', extra: "breakfasts");
                    },
                    child: Text(
                      "View more",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CarouselSlider.builder(
                itemCount: breakfast?.length,
                itemBuilder: (context, index, realIndex) {
                  final String? name = breakfast?[index]['name'] as String;

                  return SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 6,
                      children: [
                        Container(
                          width: 180,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image:
                                    AssetImage("${breakfast?[index]['image']}"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Text(name!.length > 16
                            ? '${name.substring(0, 16)}...'
                            : name),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 0.4,
                  height: 154,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lunches",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/viewMoreNutrition', extra: "lunches");
                    },
                    child: Text(
                      "View more",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CarouselSlider.builder(
                itemCount: lunches?.length,
                itemBuilder: (context, index, realIndex) {
                  final String? name = lunches?[index]['name'] as String;

                  return SizedBox(
                    width: 180,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 180,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image:
                                    AssetImage("${lunches?[index]['image']}"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Text(name!.length > 16
                            ? '${name.substring(0, 16)}...'
                            : name),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 0.4,
                  height: 150,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.20,
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     context.push("/signUp");
              //   },
              //   child: Text('open Modal'),
              // ),
              TextButton(
                onPressed: () {
                  context.push("/testPage");
                },
                child: Text('test page'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
