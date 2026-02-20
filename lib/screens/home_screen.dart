import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
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
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_rounded, 'Home'),
              _buildNavItem(1, Icons.explore_outlined, 'Explore'),
              _buildNavItem(2, Icons.bookmark_outline_rounded, 'Bookings'),
              _buildNavItem(3, Icons.person_outline_rounded, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentNavIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentNavIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
