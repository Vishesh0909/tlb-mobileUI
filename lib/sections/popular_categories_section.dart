import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/category_card.dart';
import '../data/dummy_data.dart';

class PopularCategoriesSection extends StatelessWidget {
  const PopularCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Popular Categories',
          subtitle: 'Popular Categories Among Kids',
          onSeeAll: () {},
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.95,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: DummyData.popularCategories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                category: DummyData.popularCategories[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
