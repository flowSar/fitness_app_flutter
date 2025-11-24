import 'package:flutter/material.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';

class ViewMoreNutrition extends StatelessWidget {
  final String category;
  const ViewMoreNutrition({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>>? lunches =
        FakeDatabase.nutritionPlans[category];
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                category,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: MediaQuery.sizeOf(context).height,
                child: ListView.builder(
                  itemCount: lunches?.length,
                  itemBuilder: (context, index) {
                    final String name = lunches?[index]['name'] as String;
                    final String description =
                        lunches?[index]['description'] as String;
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        spacing: 10,
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.length > 16
                                      ? '${name.substring(0, 16)}...'
                                      : name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  softWrap: true,
                                ),
                                Text(
                                  description.length > 20
                                      ? '${description.substring(0, 20)}...'
                                      : description,
                                  style: TextStyle(fontSize: 14),
                                  softWrap: true,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                    ;
                  },
                ),
              ),
            )));
  }
}
