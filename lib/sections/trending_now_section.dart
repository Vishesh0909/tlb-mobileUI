import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/trending_card.dart';
import '../core/app_colors.dart';
import '../data/dummy_data.dart';

class TrendingNowSection extends StatelessWidget {
  const TrendingNowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.trendingBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Trending Now',
            subtitle: 'Best on our platform this week',
            onSeeAll: () {},
          ),
          const SizedBox(height: 14),
          TrendingCard(events: DummyData.trendingNow),
        ],
      ),
    );
  }
}
