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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  /// Precache banner and event images to avoid jank on first scroll
  void _precacheImages() {
    for (final event in DummyData.bannerEvents) {
      precacheImage(AssetImage(event.imagePath), context);
    }
    for (final event in DummyData.spotlightEvents) {
      precacheImage(AssetImage(event.imagePath), context);
    }
  }

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
              key: ValueKey(_selectedTab),
              physics: const BouncingScrollPhysics(),
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
          RepaintBoundary(child: BannerCarousel(events: DummyData.bannerEvents, height: 220)),
          const SizedBox(height: 24),
          const RepaintBoundary(child: PopularCategoriesSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: SpotlightSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: BestForWeekSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: NearYouSection()),
          const SizedBox(height: 4),
          const RepaintBoundary(child: TrendingNowSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: KidsFavoritesSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: FeaturedEventsSection()),
          const AppFooter(),
        ];

      case 1: // Events
        return [
          const SizedBox(height: 20),
          RepaintBoundary(child: BannerCarousel(events: DummyData.bannerEvents, height: 220)),
          const SizedBox(height: 24),
          const RepaintBoundary(child: SpotlightSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: NearYouSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: FeaturedEventsSection()),
          const AppFooter(),
        ];

      case 2: // Classes
        return [
          const SizedBox(height: 20),
          RepaintBoundary(child: BannerCarousel(events: DummyData.bannerEvents, height: 220)),
          const SizedBox(height: 24),
          const RepaintBoundary(child: BestForWeekSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: TrendingNowSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: KidsFavoritesSection()),
          const AppFooter(),
        ];

      case 3: // Program
        return [
          const SizedBox(height: 20),
          RepaintBoundary(child: BannerCarousel(events: DummyData.bannerEvents, height: 220)),
          const SizedBox(height: 24),
          const RepaintBoundary(child: TrendingNowSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: SpotlightSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: FeaturedEventsSection()),
          const AppFooter(),
        ];

      case 4: // Spaces
        return [
          const SizedBox(height: 20),
          RepaintBoundary(child: BannerCarousel(events: DummyData.bannerEvents, height: 220)),
          const SizedBox(height: 24),
          const RepaintBoundary(child: NearYouSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: BestForWeekSection()),
          const SizedBox(height: 28),
          const RepaintBoundary(child: PopularCategoriesSection()),
          const AppFooter(),
        ];

      default:
        return [];
    }
  }
}
