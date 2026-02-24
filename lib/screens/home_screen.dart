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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Fixed header at top — never scrolls
          HomeHeader(
            selectedTab: _selectedTab,
            onTabChanged: (index) => setState(() => _selectedTab = index),
          ),

          // Scrollable content below — changes based on selected tab
          Expanded(
            child: SingleChildScrollView(
              key: ValueKey(_selectedTab), // reset scroll on tab change
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContentForTab(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContentForTab() {
    switch (_selectedTab) {
      case 0: // For You — show everything
        return [
          const SizedBox(height: 20),
          BannerCarousel(events: DummyData.bannerEvents, height: 220),
          const SizedBox(height: 24),
          const PopularCategoriesSection(),
          const SizedBox(height: 28),
          const SpotlightSection(),
          const SizedBox(height: 28),
          const BestForWeekSection(),
          const SizedBox(height: 28),
          const NearYouSection(),
          const SizedBox(height: 4),
          const TrendingNowSection(),
          const SizedBox(height: 28),
          const KidsFavoritesSection(),
          const SizedBox(height: 28),
          const FeaturedEventsSection(),
          const AppFooter(),
        ];

      case 1: // Events
        return [
          const SizedBox(height: 20),
          BannerCarousel(events: DummyData.bannerEvents, height: 220),
          const SizedBox(height: 24),
          const SpotlightSection(),
          const SizedBox(height: 28),
          const NearYouSection(),
          const SizedBox(height: 28),
          const FeaturedEventsSection(),
          const AppFooter(),
        ];

      case 2: // Classes
        return [
          const SizedBox(height: 20),
          BannerCarousel(events: DummyData.bannerEvents, height: 220),
          const SizedBox(height: 24),
          const BestForWeekSection(),
          const SizedBox(height: 28),
          const TrendingNowSection(),
          const SizedBox(height: 28),
          const KidsFavoritesSection(),
          const AppFooter(),
        ];

      case 3: // Program
        return [
          const SizedBox(height: 20),
          BannerCarousel(events: DummyData.bannerEvents, height: 220),
          const SizedBox(height: 24),
          const TrendingNowSection(),
          const SizedBox(height: 28),
          const SpotlightSection(),
          const SizedBox(height: 28),
          const FeaturedEventsSection(),
          const AppFooter(),
        ];

      case 4: // Spaces
        return [
          const SizedBox(height: 20),
          BannerCarousel(events: DummyData.bannerEvents, height: 220),
          const SizedBox(height: 24),
          const NearYouSection(),
          const SizedBox(height: 28),
          const BestForWeekSection(),
          const SizedBox(height: 28),
          const PopularCategoriesSection(),
          const AppFooter(),
        ];

      default:
        return [];
    }
  }
}
