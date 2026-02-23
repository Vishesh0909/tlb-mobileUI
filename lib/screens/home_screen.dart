import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../data/dummy_data.dart';
import '../widgets/banner_carousel.dart';
import '../sections/home_header.dart';
import '../sections/popular_categories_section.dart';
import '../sections/spotlight_section.dart';
import '../sections/best_for_week_section.dart';
import '../sections/near_you_section.dart';
import '../sections/trending_now_section.dart';
import '../sections/kids_favorites_section.dart';
import '../sections/featured_events_section.dart';
import '../sections/app_footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Fixed header at top — never scrolls
          const HomeHeader(),

          // Scrollable content below
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Featured Banner Carousel
                  BannerCarousel(
                    events: DummyData.bannerEvents,
                    height: 220,
                  ),

                  const SizedBox(height: 24),

                  // Popular Categories
                  const PopularCategoriesSection(),

                  const SizedBox(height: 28),

                  // Spotlight
                  const SpotlightSection(),

                  const SizedBox(height: 28),

                  // Best for This Week
                  const BestForWeekSection(),

                  const SizedBox(height: 28),

                  // Near You
                  const NearYouSection(),

                  const SizedBox(height: 4),

                  // Trending Now
                  const TrendingNowSection(),

                  const SizedBox(height: 28),

                  // Kids' Favorites
                  const KidsFavoritesSection(),

                  const SizedBox(height: 28),

                  // Featured Events
                  const FeaturedEventsSection(),

                  // Footer
                  const AppFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
