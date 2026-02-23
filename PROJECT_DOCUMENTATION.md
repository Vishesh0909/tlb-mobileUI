# The Little Broadway (TLB) — Project Documentation

## Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture & Design Pattern](#architecture--design-pattern)
3. [Application Flow](#application-flow)
4. [Directory Structure](#directory-structure)
5. [Dependencies](#dependencies)
6. [File-by-File Explanation](#file-by-file-explanation)
7. [Widget Tree Hierarchy](#widget-tree-hierarchy)
8. [Data Flow](#data-flow)
9. [Key Flutter Concepts Used](#key-flutter-concepts-used)

---

## Project Overview

**The Little Broadway (TLB)** is a Flutter-based event booking mobile application designed for kids' events and activities. It is inspired by platforms like BookMyShow. The app presents a single scrollable home screen showcasing various event categories, featured events, trending activities, and booking options — all themed with a warm golden/amber design language.

### What the App Does
- Displays a curated list of kids' events (parties, story telling, workshops)
- Organizes events into sections: Featured, Spotlight, Trending, Near You, Kids' Favorites
- Shows event details with images, venue info, pricing, and ratings
- Provides "Book Now" call-to-action buttons
- Includes category-based browsing (Creative Arts, Play & Adventure, etc.)

---

## Architecture & Design Pattern

The app follows a **component-based architecture** with clear separation of concerns:

```
┌─────────────────────────────────────────────┐
│                  main.dart                  │  ← Entry point
│              (TLBApp widget)                │
├─────────────────────────────────────────────┤
│              screens/                       │  ← Page-level widgets
│           home_screen.dart                  │
├─────────────────────────────────────────────┤
│              sections/                      │  ← Logical UI sections
│    (header, categories, spotlight, etc.)    │
├─────────────────────────────────────────────┤
│              widgets/                       │  ← Reusable UI components
│   (cards, carousels, headers, etc.)         │
├─────────────────────────────────────────────┤
│           models/ + data/                   │  ← Data layer
│     (EventModel, CategoryModel, DummyData)  │
├─────────────────────────────────────────────┤
│               core/                         │  ← App-wide configuration
│       (AppColors, AppTheme)                 │
└─────────────────────────────────────────────┘
```

**Key Design Decisions:**
- **StatelessWidget** is used wherever possible (sections, cards) for performance
- **StatefulWidget** is only used where state is needed (carousels with `PageController`, bottom nav with selected index)
- **Composition over inheritance** — small reusable widgets are composed into larger sections
- Data flows **top-down**: `DummyData` → `Sections` → `Widgets`

---

## Application Flow

### Startup Flow

```
1. main() is called
   │
   ├── WidgetsFlutterBinding.ensureInitialized()
   │     └── Ensures Flutter engine is ready before any platform calls
   │
   ├── SystemChrome.setSystemUIOverlayStyle()
   │     └── Makes status bar transparent with dark icons
   │
   └── runApp(TLBApp())
         │
         └── MaterialApp
               ├── theme: AppTheme.lightTheme (Poppins font, amber colors)
               ├── debugShowCheckedModeBanner: false
               └── home: HomeScreen()
```

### HomeScreen Rendering Flow

When `HomeScreen` builds, it creates a `Scaffold` with:

```
Scaffold
├── body: SingleChildScrollView
│   └── Column (vertical stack of all sections)
│       ├── 1. HomeHeader (golden gradient header)
│       │     ├── _buildGreetingRow()     → "Hello World 👋" + location + icons
│       │     ├── _buildSearchBar()       → Rounded search input
│       │     └── _buildCategoryTabs()    → Horizontal scrollable tabs
│       │
│       ├── 2. BannerCarousel            → PageView with dot indicators
│       │     └── Uses DummyData.bannerEvents
│       │
│       ├── 3. PopularCategoriesSection  → 3×2 GridView of CategoryCards
│       │     └── Uses DummyData.popularCategories
│       │
│       ├── 4. SpotlightSection          → Horizontal ListView of EventCards
│       │     └── Uses DummyData.spotlightEvents
│       │
│       ├── 5. BestForWeekSection        → 2-column Row of EventCardWithRating
│       │     └── Uses DummyData.bestForWeek
│       │
│       ├── 6. NearYouSection            → BannerCarousel (reused widget)
│       │     └── Uses DummyData.nearYouEvents
│       │
│       ├── 7. TrendingNowSection        → Warm bg + TrendingCard PageView
│       │     └── Uses DummyData.trendingNow
│       │
│       ├── 8. KidsFavoritesSection      → Horizontal ListView of EventCardWithPrice
│       │     └── Uses DummyData.kidsFavorites
│       │
│       ├── 9. FeaturedEventsSection     → Horizontal ListView of FeaturedEventCard
│       │     └── Uses DummyData.featuredEvents
│       │
│       └── 10. AppFooter               → "The Little Broadway" branding + logo
│
└── bottomNavigationBar: Custom animated bottom nav
      └── 4 nav items (Home, Explore, Bookings, Profile)
      └── Uses setState() to track _currentNavIndex
```

### User Interaction Flow

```
User scrolls vertically
  └── SingleChildScrollView handles the entire page scroll

User swipes horizontally on carousels
  └── PageView.builder handles horizontal swipe
  └── PageController tracks current page
  └── SmoothPageIndicator shows dot indicators

User taps bottom nav item
  └── GestureDetector.onTap triggers setState()
  └── _currentNavIndex updates
  └── AnimatedContainer smoothly transitions the highlight

User taps "Book Now" button
  └── ElevatedButton.onPressed (currently empty — placeholder for navigation)
```

---

## Directory Structure

```
lib/
├── main.dart                              # App entry point & MaterialApp setup
│
├── core/                                  # App-wide configuration
│   ├── app_colors.dart                    # All color constants
│   └── app_theme.dart                     # Material theme configuration
│
├── models/                                # Data models
│   ├── event_model.dart                   # Event data structure
│   └── category_model.dart                # Category data structure
│
├── data/                                  # Data providers
│   └── dummy_data.dart                    # Static mock data for all sections
│
├── widgets/                               # Reusable UI components
│   ├── section_header.dart                # "Title + See All >" pattern
│   ├── event_card.dart                    # Basic event card (image + title + venue)
│   ├── category_card.dart                 # Gradient category card with icon
│   ├── banner_carousel.dart               # Full-width image carousel with dots
│   ├── trending_card.dart                 # Horizontal card with description
│   ├── event_card_with_rating.dart        # Card with star ratings
│   ├── event_card_with_price.dart         # Card with ₹ price + Book Now
│   └── featured_event_card.dart           # Card with "Featured" badge
│
├── sections/                              # Home screen sections
│   ├── home_header.dart                   # Golden header with search & tabs
│   ├── popular_categories_section.dart    # 3×2 category grid
│   ├── spotlight_section.dart             # Horizontal event scroll
│   ├── best_for_week_section.dart         # 2-col grid with ratings
│   ├── near_you_section.dart              # Banner carousel
│   ├── trending_now_section.dart          # Warm bg + trending cards
│   ├── kids_favorites_section.dart        # Price cards with Book Now
│   ├── featured_events_section.dart       # Featured badge cards
│   └── app_footer.dart                    # TLB branding + logo
│
└── screens/                               # Full-page screens
    └── home_screen.dart                   # Main scrollable home page + bottom nav
```

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `google_fonts` | ^6.1.0 | Loads **Poppins** font from Google Fonts for consistent typography |
| `smooth_page_indicator` | ^1.1.0 | Provides animated **dot indicators** for PageView carousels |
| `flutter_rating_bar` | ^4.0.1 | Renders **star rating bars** (filled/unfilled) in event cards |

---

## File-by-File Explanation

### `lib/main.dart`
**Role:** Application entry point

**What it does:**
1. Calls `WidgetsFlutterBinding.ensureInitialized()` — required before any platform channel calls (like `SystemChrome`)
2. Sets the status bar to transparent with dark icons using `SystemChrome.setSystemUIOverlayStyle()` — this ensures the golden header extends behind the status bar seamlessly
3. Creates `TLBApp` — a `StatelessWidget` that returns a `MaterialApp` configured with:
   - App title: "The Little Broadway"
   - Debug banner hidden
   - Custom theme from `AppTheme.lightTheme`
   - `HomeScreen` as the landing page

**Key concept:** `MaterialApp` is the root widget that provides Material Design styling, navigation, and theming to the entire widget tree.

---

### `lib/core/app_colors.dart`
**Role:** Centralized color constants

**What it does:** Defines a utility class `AppColors` with a private constructor (`AppColors._()`) to prevent instantiation. All colors are `static const`, organized by purpose:

| Category | Colors | Usage |
|----------|--------|-------|
| **Primary** | `#F5A623`, `#FFCC02` | Buttons, headers, accent elements |
| **Background** | `#FFF8EE` (warm cream) | Scaffold background |
| **Text** | `#1A1A2E` (dark), `#6B7280` (grey) | Headlines, body text |
| **Category** | Orange, purple, pink, green, blue, red | Category card gradients |
| **Tags** | `tagProgram` (pink), `tagFeatured` (red) | Badge labels |

**Why a dedicated file?** Avoids hardcoded hex values scattered across widgets. When the design changes, you only update one file.

---

### `lib/core/app_theme.dart`
**Role:** Material Theme configuration

**What it does:** Creates a `ThemeData` object that configures:
- **Material 3** enabled (`useMaterial3: true`)
- **Scaffold background** → warm cream from `AppColors.background`
- **Color scheme** → seeded from primary amber color
- **Text theme** → Poppins font via `GoogleFonts.poppinsTextTheme()`
- **Card theme** → 16px rounded corners, elevation 2, white background
- **Button theme** → Amber background, white text, 24px rounded pill shape

**Key concept:** Flutter's `ThemeData` cascades styling down the widget tree, so individual widgets inherit consistent styling without repeating configuration.

---

### `lib/models/event_model.dart`
**Role:** Data class for events

**Fields:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | `String` | ✅ | Event name (e.g., "Kids Party") |
| `venue` | `String` | ✅ | Location name (e.g., "Embassy Int. Riding School") |
| `imagePath` | `String` | ✅ | Asset path to event image |
| `price` | `double?` | ❌ | Ticket price (used in Kids' Favorites) |
| `rating` | `double?` | ❌ | Star rating 0-5 (used in Best for Week) |
| `reviewCount` | `String?` | ❌ | e.g., "3.5k reviews" |
| `tag` | `String?` | ❌ | Badge text like "Program" or "Event" |
| `description` | `String?` | ❌ | Longer description (used in Trending Now) |
| `isFeatured` | `bool` | ❌ | Whether to show "Featured" badge |

**Why optional fields?** The same model is reused across different card types. A simple `EventCard` only needs title/venue/image, while `EventCardWithPrice` also needs `price`. Optional fields avoid creating multiple model classes.

---

### `lib/models/category_model.dart`
**Role:** Data class for categories

**Fields:**
- `name` (`String`) — Category label, uses `\n` for two-line display (e.g., "Creative\nArts")
- `icon` (`IconData`) — Material icon for the category
- `gradientColors` (`List<Color>`) — Two colors for the gradient background

---

### `lib/data/dummy_data.dart`
**Role:** Static mock data provider

**What it does:** Class with a private constructor containing `static const` lists of data for every section:

| List | Type | Section Used |
|------|------|--------------|
| `categoryTabs` | `List<Map>` | Header category tabs |
| `popularCategories` | `List<CategoryModel>` | Popular Categories grid |
| `bannerEvents` | `List<EventModel>` | Featured banner carousel |
| `spotlightEvents` | `List<EventModel>` | Spotlight section |
| `bestForWeek` | `List<EventModel>` | Best for This Week (with ratings) |
| `nearYouEvents` | `List<EventModel>` | Near You carousel |
| `trendingNow` | `List<EventModel>` | Trending Now (with descriptions) |
| `kidsFavorites` | `List<EventModel>` | Kids' Favorites (with prices) |
| `featuredEvents` | `List<EventModel>` | Featured Events (with badge) |

**Design note:** In a production app, this would be replaced with API calls, but the static data pattern makes the UI development independent of backend.

---

### `lib/widgets/section_header.dart`
**Role:** Reusable section heading pattern

**Layout:**
```
┌──────────────────────────────────────────┐
│  Popular Categories          See All >   │
│  Popular Categories Among Kids           │
└──────────────────────────────────────────┘
```

**Props:** `title` (required), `subtitle` (optional), `onSeeAll` callback (optional — if null, "See All" is hidden)

**Used by:** Every section file (Popular Categories, Spotlight, Best for Week, etc.)

---

### `lib/widgets/event_card.dart`
**Role:** Basic event card

**Layout:**
```
┌───────────────────┐
│                   │
│   Event Image     │
│                   │
├───────────────────┤
│ Event Title       │
│ 📍 Venue Name     │
└───────────────────┘
```

**Props:** `event` (EventModel), `width` (default 260), `imageHeight` (default 200)

**Features:**
- `ClipRRect` with top-only rounded corners for the image
- `errorBuilder` — shows a gradient placeholder if the image fails to load
- Shadow via `BoxShadow` for card elevation

**Used by:** `SpotlightSection`

---

### `lib/widgets/category_card.dart`
**Role:** Colorful gradient card for categories

**Layout:**
```
┌────────────────┐
│           [🎨] │  ← Icon in translucent container
│                │
│ Creative       │
│ Arts           │  ← Name at bottom-left
└────────────────┘
```

**How gradients work:** Uses `LinearGradient` with two colors from `CategoryModel.gradientColors`, going from `topLeft` to `bottomRight`.

**Used by:** `PopularCategoriesSection`

---

### `lib/widgets/banner_carousel.dart`
**Role:** Swipeable full-width image carousel

**Key mechanics:**
1. **`PageView.builder`** — renders pages lazily (only visible + adjacent pages)
2. **`PageController(viewportFraction: 0.92)`** — shows 92% of current page, revealing edges of adjacent pages for a peek effect
3. **`Stack`** — layers the image and a gradient overlay
4. **Bottom gradient** — `LinearGradient` from black(0.7 opacity) to transparent, making white text readable over any image
5. **`SmoothPageIndicator`** — synced with the `PageController`, uses `WormEffect` animation

**State management:** `StatefulWidget` because `PageController` must be created and disposed (lifecycle management).

**Used by:** Featured Banner (in `HomeScreen`), `NearYouSection`

---

### `lib/widgets/trending_card.dart`
**Role:** Horizontal layout card with description

**Layout:**
```
┌──────────┬──────────────────────┐
│          │ [Program]            │  ← Tag badge
│  Event   │ Story Telling        │  ← Title
│  Image   │ Fun stories that...  │  ← Description (3 lines max)
│  (130px) │                      │
│          │ [Book Now]           │  ← Amber button
└──────────┴──────────────────────┘
```

**Key mechanics:**
- `Row` layout: image on left (130px fixed width), content on right (`Expanded`)
- `PageView.builder` wraps multiple cards for swipe navigation
- Tag badge uses a translucent pink background with pink text
- `Expanded` on the description text ensures it fills available space

**Used by:** `TrendingNowSection`

---

### `lib/widgets/event_card_with_rating.dart`
**Role:** Event card with star ratings

**Extra elements vs basic EventCard:**
- Review count text (e.g., "3.5k reviews")
- `RatingBarIndicator` from `flutter_rating_bar` package — renders filled/unfilled stars based on `event.rating`

**Used by:** `BestForWeekSection`

---

### `lib/widgets/event_card_with_price.dart`
**Role:** Event card with pricing and booking

**Extra elements:**
- Price display using `RichText` with `TextSpan` — "₹200" is bold 22px, "/ Person" is regular 13px
- "Book Now" `ElevatedButton` — amber pill-shaped button

**Used by:** `KidsFavoritesSection`

---

### `lib/widgets/featured_event_card.dart`
**Role:** Event card with "Featured" badge

**Extra elements:**
- `Stack` with `Positioned` — places a red "Featured" badge at top-right corner over the image
- Badge only appears when `event.isFeatured == true`

**Used by:** `FeaturedEventsSection`

---

### `lib/sections/home_header.dart`
**Role:** Golden header section (most complex section)

**Structure:**
```
Container (golden gradient + bottom rounded corners)
└── SafeArea (avoids status bar overlap)
    └── Stack
        ├── Positioned clouds (decorative white circles)
        └── Column
            ├── _buildGreetingRow()     → Hello World + location + icons
            ├── _buildSearchBar()       → Rounded search input
            └── _buildCategoryTabs()    → Horizontal scrollable tabs
```

**Key details:**
- **Golden gradient:** Three-stop `LinearGradient` from `#FFD54F` → `#FFC107` → `#FFB300`
- **Decorative clouds:** Semi-transparent white rounded containers positioned with negative `top` values to peek from the top
- **Category tabs:** `ListView.separated` with horizontal scroll. Selected tab gets amber fill + white border + shadow. Unselected tabs get semi-transparent white fill
- **SafeArea:** `bottom: false` allows content below to extend to the bottom, while still protecting the top from status bar overlap

---

### `lib/sections/popular_categories_section.dart`
**Role:** 3×2 grid of category cards

**Key widget:** `GridView.builder` with `SliverGridDelegateWithFixedCrossAxisCount`:
- `crossAxisCount: 3` — 3 columns
- `childAspectRatio: 1.3` — wider than tall
- `shrinkWrap: true` — takes only needed height (since it's inside a `Column`)
- `NeverScrollableScrollPhysics()` — disables grid scrolling (parent `SingleChildScrollView` handles it)

---

### `lib/sections/spotlight_section.dart`
**Role:** Horizontal scrollable event cards

**Widget:** `SizedBox(height: 290)` containing a horizontal `ListView.separated` of `EventCard` widgets.

---

### `lib/sections/best_for_week_section.dart`
**Role:** Two-column event grid with ratings

**Layout:** A `Row` with `Expanded` children containing `EventCardWithRating`. Uses `Expanded` instead of `GridView` since there are exactly 2 items.

---

### `lib/sections/near_you_section.dart`
**Role:** Nearby events carousel

**Implementation:** Reuses the `BannerCarousel` widget with a different data list (`DummyData.nearYouEvents`) and smaller height (200px vs 220px).

---

### `lib/sections/trending_now_section.dart`
**Role:** Trending events with warm background

**Key detail:** Entire section wrapped in a `Container` with `AppColors.trendingBg` (`#FFF3E0` — warm orange tint), creating a visual break from the white/cream sections above and below.

---

### `lib/sections/kids_favorites_section.dart`
**Role:** Kids' favorite events with pricing

**Widget:** Horizontal `ListView.separated` with `EventCardWithPrice` cards (300px wide, 330px tall container).

---

### `lib/sections/featured_events_section.dart`
**Role:** Featured events with badge

**Widget:** Horizontal `ListView.separated` with `FeaturedEventCard` cards (200px wide).

---

### `lib/sections/app_footer.dart`
**Role:** Bottom branding

**Layout:**
```
─────────────────────────
  The Little Broadway      ← Faded text
─────────────────────────
       ● tlb ●            ← Amber circle with "tlb" text
    the little broadway    ← Tiny subtitle
```

---

### `lib/screens/home_screen.dart`
**Role:** Main page assembling all sections

**Widget type:** `StatefulWidget` — needs state for `_currentNavIndex` (bottom nav selection).

**Body:** `SingleChildScrollView` → `Column` → All 10 sections stacked vertically with `SizedBox` spacers between them.

**Bottom Navigation Bar:**
- Custom implementation (not Flutter's `BottomNavigationBar`) for design flexibility
- Uses `AnimatedContainer` for smooth selection transitions
- Selected item shows: amber background tint + icon + label
- Unselected items show: just the grey icon
- `GestureDetector` with `HitTestBehavior.opaque` ensures the full tap area works

---

## Widget Tree Hierarchy

```
MaterialApp
└── HomeScreen (StatefulWidget)
    └── Scaffold
        ├── body: SingleChildScrollView
        │   └── Column
        │       ├── HomeHeader (StatelessWidget)
        │       │   └── Container (gradient)
        │       │       └── SafeArea → Stack → Column
        │       │           ├── Row (greeting)
        │       │           ├── Container (search bar)
        │       │           └── ListView (category tabs)
        │       │
        │       ├── BannerCarousel (StatefulWidget)
        │       │   └── Column
        │       │       ├── PageView.builder → Stack[Image, Gradient overlay]
        │       │       └── SmoothPageIndicator
        │       │
        │       ├── PopularCategoriesSection → GridView → CategoryCard
        │       ├── SpotlightSection → ListView → EventCard
        │       ├── BestForWeekSection → Row → EventCardWithRating
        │       ├── NearYouSection → BannerCarousel (reused)
        │       ├── TrendingNowSection → TrendingCard (PageView)
        │       ├── KidsFavoritesSection → ListView → EventCardWithPrice
        │       ├── FeaturedEventsSection → ListView → FeaturedEventCard
        │       └── AppFooter
        │
        └── bottomNavigationBar: Container
            └── Row → GestureDetector → AnimatedContainer
```

---

## Data Flow

```
┌─────────────────┐
│   DummyData     │  Static const lists of EventModel / CategoryModel
│   (dummy_data)  │
└────────┬────────┘
         │ Referenced directly by sections
         ▼
┌─────────────────┐
│   Sections      │  Each section reads from a specific DummyData list
│   (sections/)   │  e.g., SpotlightSection reads DummyData.spotlightEvents
└────────┬────────┘
         │ Passes individual items to widgets
         ▼
┌─────────────────┐
│   Widgets       │  Receive a single EventModel or CategoryModel
│   (widgets/)    │  Render the visual card UI
└─────────────────┘
```

**No state management library** (Provider, Bloc, Riverpod) is needed at this stage since:
- All data is static/dummy
- Only local UI state exists (`PageController` page index, bottom nav index)
- Data flows one-way (top-down)

---

## Key Flutter Concepts Used

| Concept | Where Used | Why |
|---------|-----------|-----|
| `StatelessWidget` | All widgets, sections, footer | No internal state needed |
| `StatefulWidget` | `HomeScreen`, `BannerCarousel`, `TrendingCard` | Needs `PageController` or `setState` |
| `SingleChildScrollView` | `HomeScreen` body | Makes entire page scrollable |
| `PageView.builder` | Carousels, trending cards | Horizontal swipeable pages |
| `ListView.separated` | Category tabs, spotlight, favorites | Horizontal scrollable lists |
| `GridView.builder` | Popular categories | 2D grid layout |
| `Stack` + `Positioned` | Banner overlay, featured badge, header clouds | Layering widgets on top of each other |
| `ClipRRect` | All image containers | Clips images to rounded corners |
| `LinearGradient` | Header, category cards, image overlays | Smooth color transitions |
| `BoxShadow` | Cards | Elevation/depth effect |
| `RichText` + `TextSpan` | Price display | Mixed font sizes in single line |
| `AnimatedContainer` | Bottom nav items | Smooth selection animation |
| `SafeArea` | Header | Prevents content from going behind status bar |
| `GoogleFonts.poppins()` | All text | Consistent custom typography |
| `Image.asset` + `errorBuilder` | All image widgets | Graceful fallback if image fails to load |
