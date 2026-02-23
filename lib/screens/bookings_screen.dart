import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFC107),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Your Bookings',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: const Color(0xFF1A1A2E),
            unselectedLabelColor: Colors.grey.shade600,
            labelStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            indicatorColor: const Color(0xFF1A1A2E),
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Ongoing'),
              Tab(text: 'Past Booking'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBookingsList(isOngoing: true),
            _buildBookingsList(isOngoing: false),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsList({required bool isOngoing}) {
    final bookings = isOngoing
        ? [
            {
              'title': 'Halloween Party',
              'venue': 'City Convention Center',
              'date': 'Oct 31, 2026 • 7:00 PM',
              'status': 'Confirmed',
              'statusColor': const Color(0xFF4CAF50),
            },
            {
              'title': 'World Storytelling Day',
              'venue': 'Embassy Int. Riding School',
              'date': 'Mar 20, 2026 • 10:00 AM',
              'status': 'Pending',
              'statusColor': const Color(0xFFFFC107),
            },
          ]
        : [
            {
              'title': 'Kids Party',
              'venue': 'Fun Zone Park',
              'date': 'Jan 15, 2026 • 3:00 PM',
              'status': 'Completed',
              'statusColor': Colors.grey,
            },
            {
              'title': 'Summer Fete',
              'venue': 'Central Park Arena',
              'date': 'Dec 20, 2025 • 11:00 AM',
              'status': 'Completed',
              'statusColor': Colors.grey,
            },
          ];

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'No bookings yet',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final b = bookings[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      b['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (b['statusColor'] as Color).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      b['status'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: b['statusColor'] as Color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    b['venue'] as String,
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    b['date'] as String,
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
