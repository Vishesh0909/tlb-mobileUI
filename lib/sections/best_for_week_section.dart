import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/event_card_with_rating.dart';
import '../data/dummy_data.dart';

class BestForWeekSection extends StatelessWidget {
  const BestForWeekSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Best for This Week',
          subtitle: 'Top picks you shouldn\'t miss!',
          onSeeAll: () {},
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: DummyData.bestForWeek.map((event) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: event == DummyData.bestForWeek.last ? 0 : 10,
                  ),
                  child: EventCardWithRating(event: event),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
