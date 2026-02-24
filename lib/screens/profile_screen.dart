import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bookings_screen.dart';
import 'saved_events_screen.dart';
import 'help_centre_screen.dart';
import 'account_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Hi!',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A2E),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Color(0xFFFFC107), size: 22),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          // Menu items
          _buildMenuItem(
            context,
            icon: Icons.shopping_bag_outlined,
            title: 'Your Bookings',
            subtitle: 'View all your bookings & purchases',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookingsScreen()),
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildMenuItem(
            context,
            icon: Icons.bookmark_border,
            title: 'Saved Events',
            subtitle: 'Events you\'ve bookmarked',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SavedEventsScreen()),
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildMenuItem(
            context,
            icon: Icons.help_outline,
            title: 'Help Centre',
            subtitle: 'Need help or have questions?',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HelpCentreScreen()),
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildMenuItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Accounts & Settings',
            subtitle: 'Location, Payments, Permissions\n& More',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountSettingsScreen()),
            ),
          ),

          const Spacer(),

          // Footer links
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _footerLink('Share'),
                    _footerDivider(),
                    _footerLink('Rate Us'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _footerLink('Terms & Conditions'),
                    _footerDivider(),
                    _footerLink('Privacy Policy'),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'App Version: 1.0.0',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(icon, color: const Color(0xFF1A1A2E), size: 26),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1A1A2E),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _footerLink(String text) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2196F3),
        ),
      ),
    );
  }

  Widget _footerDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '|',
        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
      ),
    );
  }
}
