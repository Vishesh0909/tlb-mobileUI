import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/event_card.dart';
import '../data/dummy_data.dart';

class SpotlightSection extends StatelessWidget {
  const SpotlightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Spotlight',
          onSeeAll: () {},
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 290,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: DummyData.spotlightEvents.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return EventCard(
                event: DummyData.spotlightEvents[index],
                width: 260,
                imageHeight: 210,
              );
            },
          ),
        ),
      ],
    );
  }
}
