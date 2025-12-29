import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, Object>>? breakfast =
        FakeDatabase.nutritionPlans['breakfasts'];
    final List<Map<String, Object>>? lunches =
        FakeDatabase.nutritionPlans['lunches'];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Header Section
              Text(
                AppLocalizations.of(context)!.nutrition,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.tipsAndHealthyRecipes,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),

              // Tip of the Day Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4CAF50),
                      Color(0xFF2E7D32)
                    ], // Premium Green Gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lightbulb_outline,
                            color: Colors.white, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.tipOfTheDay,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Drink a glass of water before each meal. It helps with digestion and can prevent overeating.",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildSectionHeader(
                  context, AppLocalizations.of(context)!.breakfasts, () {
                context.push('/viewMoreNutrition', extra: "breakfasts");
              }),
              const SizedBox(height: 16),
              CarouselSlider.builder(
                itemCount: breakfast?.length,
                itemBuilder: (context, index, realIndex) {
                  final String name = breakfast?[index]['name'] as String;

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
              const SizedBox(height: 10),
              _buildSectionHeader(
                  context, AppLocalizations.of(context)!.lunches, () {
                context.push('/viewMoreNutrition', extra: "lunches");
              }),
              const SizedBox(height: 16),
              CarouselSlider.builder(
                itemCount: lunches?.length,
                itemBuilder: (context, index, realIndex) {
                  final String name = lunches?[index]['name'] as String;

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
              const SizedBox(height: 40),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.push("/testPage");
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                  ),
                  child: const Text('Go to Test Page'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, VoidCallback onViewMore) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        InkWell(
          onTap: onViewMore,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.viewMore,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
