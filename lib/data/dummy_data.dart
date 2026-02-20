import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../models/category_model.dart';

class DummyData {
  DummyData._();

  // Category tabs
  static const List<Map<String, dynamic>> categoryTabs = [
    {'icon': Icons.auto_awesome, 'label': 'For You', 'selected': true},
    {'icon': Icons.event, 'label': 'Events', 'selected': false},
    {'icon': Icons.school, 'label': 'Classes', 'selected': false},
    {'icon': Icons.calendar_month, 'label': 'Program', 'selected': false},
    {'icon': Icons.location_city, 'label': 'Spaces', 'selected': false},
  ];

  // Popular Categories
  static const List<CategoryModel> popularCategories = [
    CategoryModel(
      name: 'Creative\nArts',
      icon: Icons.brush,
      gradientColors: [Color(0xFFFFA726), Color(0xFFFF7043)],
    ),
    CategoryModel(
      name: 'Creative\nArts',
      icon: Icons.palette,
      gradientColors: [Color(0xFF9C7CF4), Color(0xFF7C4DFF)],
    ),
    CategoryModel(
      name: 'Play\n& Adventure',
      icon: Icons.park,
      gradientColors: [Color(0xFFF48FB1), Color(0xFFE91E63)],
    ),
    CategoryModel(
      name: 'Health\n& Wellness',
      icon: Icons.favorite,
      gradientColors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
    ),
    CategoryModel(
      name: 'Family\nTime',
      icon: Icons.family_restroom,
      gradientColors: [Color(0xFFAB47BC), Color(0xFF7B1FA2)],
    ),
    CategoryModel(
      name: 'Seasonal\nSpecial',
      icon: Icons.celebration,
      gradientColors: [Color(0xFF66BB6A), Color(0xFF388E3C)],
    ),
  ];

  // Banner carousel events
  static const List<EventModel> bannerEvents = [
    EventModel(
      title: 'Kids Party',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/kids_party.png',
    ),
    EventModel(
      title: 'Halloween Special',
      venue: 'City Convention Center',
      imagePath: 'assets/images/halloween_party.png',
    ),
    EventModel(
      title: 'World Book Day',
      venue: 'Central Library Hall',
      imagePath: 'assets/images/story_telling.png',
    ),
  ];

  // Spotlight events
  static const List<EventModel> spotlightEvents = [
    EventModel(
      title: 'Story Telling',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/story_telling.png',
    ),
    EventModel(
      title: 'Kids Party',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/kids_party.png',
    ),
    EventModel(
      title: 'Halloween Party',
      venue: 'City Convention Center',
      imagePath: 'assets/images/halloween_party.png',
    ),
  ];

  // Best for This Week
  static const List<EventModel> bestForWeek = [
    EventModel(
      title: 'Halloween Party',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/halloween_party.png',
      rating: 3.0,
      reviewCount: '3.5k reviews',
    ),
    EventModel(
      title: 'Story Telling',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/story_telling.png',
      rating: 4.0,
      reviewCount: '10k reviews',
    ),
  ];

  // Near You events (carousel)
  static const List<EventModel> nearYouEvents = [
    EventModel(
      title: 'Kids Party',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/kids_party.png',
    ),
    EventModel(
      title: 'Halloween Party',
      venue: 'City Convention Center',
      imagePath: 'assets/images/halloween_party.png',
    ),
  ];

  // Trending Now
  static const List<EventModel> trendingNow = [
    EventModel(
      title: 'Story Telling',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/story_telling.png',
      tag: 'Program',
      description:
          'Fun stories that spark imagination, build creativity, and make kids love listening and learning.',
    ),
    EventModel(
      title: 'Kids Party',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/kids_party.png',
      tag: 'Event',
      description:
          'Amazing party experience for kids with games, music, and fun activities.',
    ),
  ];

  // Kids Favorites
  static const List<EventModel> kidsFavorites = [
    EventModel(
      title: 'Halloween Party',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/halloween_party.png',
      price: 200,
    ),
    EventModel(
      title: 'Story Telling',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/story_telling.png',
      price: 150,
    ),
  ];

  // Featured Events
  static const List<EventModel> featuredEvents = [
    EventModel(
      title: 'Story Telling',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/story_telling.png',
      isFeatured: true,
    ),
    EventModel(
      title: 'Halloween Party',
      venue: 'Embassy Int. Riding School',
      imagePath: 'assets/images/halloween_party.png',
      isFeatured: true,
    ),
  ];
}
