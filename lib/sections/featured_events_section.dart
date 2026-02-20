import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/featured_event_card.dart';
import '../data/dummy_data.dart';

class FeaturedEventsSection extends StatelessWidget {
  const FeaturedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Featured Events',
          subtitle: "Top picks you shouldn't miss!",
          onSeeAll: () {},
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: DummyData.featuredEvents.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return FeaturedEventCard(
                event: DummyData.featuredEvents[index],
                width: 200,
              );
            },
          ),
        ),
      ],
    );
  }
}
