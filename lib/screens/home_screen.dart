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
  final ScrollController _scrollController = ScrollController();
  Color _statusBarColor = const Color(0xFFFFC107);

  // Match the header overlay gradient
  static const Color _colorTop = Color(0xFFFFC107);
  static const Color _colorBottom = Color(0xFFFFB300);

  // Approximate height of the golden header section
  static const double _headerHeight = 250.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final double t = (offset / _headerHeight).clamp(0.0, 1.0);
    final newColor = Color.lerp(_colorTop, _colorBottom, t)!;

    if (newColor != _statusBarColor) {
      setState(() {
        _statusBarColor = newColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with search and category tabs
                const HomeHeader(),

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
          // Dynamic status bar background (rendered on top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).padding.top,
              color: _statusBarColor,
            ),
          ),
        ],
      ),
    );
  }
}
