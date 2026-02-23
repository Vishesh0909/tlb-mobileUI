import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/event_model.dart';

class TicketBookingScreen extends StatefulWidget {
  final EventModel event;

  const TicketBookingScreen({super.key, required this.event});

  @override
  State<TicketBookingScreen> createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  final Map<int, int> _ticketCounts = {};

  final List<Map<String, dynamic>> _tickets = [
    {'name': 'GA Back - Phase 1', 'price': 4250, 'status': '', 'available': true},
    {'name': 'GA Front - Phase 1', 'price': 6500, 'status': 'Fast Filling', 'available': true},
    {'name': 'Early Bird Backstage', 'price': 15000, 'status': 'Fast Filling', 'available': true},
    {'name': 'Lounge Phase 2', 'price': 28000, 'status': '', 'available': true},
    {'name': 'Early Bird GA Back', 'price': 3500, 'status': 'Sold out', 'available': false},
    {'name': 'Early Bird GA Front', 'price': 5000, 'status': 'Sold out', 'available': false},
  ];

  int get _totalTickets =>
      _ticketCounts.values.fold(0, (sum, count) => sum + count);

  int get _totalPrice {
    int total = 0;
    _ticketCounts.forEach((index, count) {
      total += (_tickets[index]['price'] as int) * count;
    });
    return total;
  }

  void _addTicket(int index) {
    if (_totalTickets >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 6 tickets allowed per booking')),
      );
      return;
    }
    setState(() {
      _ticketCounts[index] = (_ticketCounts[index] ?? 0) + 1;
    });
  }

  void _removeTicket(int index) {
    if ((_ticketCounts[index] ?? 0) > 0) {
      setState(() {
        _ticketCounts[index] = _ticketCounts[index]! - 1;
        if (_ticketCounts[index] == 0) _ticketCounts.remove(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.event.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A2E),
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress stepper
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: const Color(0xFFF5F5F5),
            child: Row(
              children: [
                _buildStep(1, 'Ticket', true),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
                _buildStep(2, 'Ticket Mode', false),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
                Flexible(child: _buildStep(3, 'Review & Proceed to Pay', false)),
              ],
            ),
          ),

          // Venue + date info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFF9F9F9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.venue,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                Text(
                  'Sat 21 Nov | 04:00 PM',
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Select tickets header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Tickets',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You can add up to 6 tickets only',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Ticket list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _tickets.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final ticket = _tickets[index];
                final isAvailable = ticket['available'] as bool;
                final count = _ticketCounts[index] ?? 0;
                final status = ticket['status'] as String;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isAvailable ? Colors.grey.shade200 : Colors.grey.shade100,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ticket['name'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isAvailable
                                        ? const Color(0xFF1A1A2E)
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      '₹${ticket['price']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isAvailable
                                            ? const Color(0xFF1A1A2E)
                                            : Colors.grey,
                                      ),
                                    ),
                                    if (status.isNotEmpty) ...[
                                      Text(' | ', style: GoogleFonts.poppins(color: Colors.grey)),
                                      Text(
                                        status,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: status == 'Sold out'
                                              ? const Color(0xFFFF6B6B)
                                              : const Color(0xFFFFA726),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isAvailable)
                            count == 0
                                ? OutlinedButton(
                                    onPressed: () => _addTicket(index),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Color(0xFFFF6B6B)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                    ),
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFFF6B6B),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFFFF6B6B)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(Icons.remove, size: 18, color: Color(0xFFFF6B6B)),
                                          onPressed: () => _removeTicket(index),
                                        ),
                                        Text(
                                          '$count',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF1A1A2E),
                                          ),
                                        ),
                                        IconButton(
                                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(Icons.add, size: 18, color: Color(0xFFFF6B6B)),
                                          onPressed: () => _addTicket(index),
                                        ),
                                      ],
                                    ),
                                  ),
                        ],
                      ),
                      if (isAvailable)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                              Text(
                                'Know more',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFFFA726),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFFFFA726)),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom bar — shows when tickets are selected
          if (_totalTickets > 0)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$_totalTickets Ticket${_totalTickets > 1 ? 's' : ''} • ₹$_totalPrice',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Proceeding to payment...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B6B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      elevation: 0,
                    ),
                    child: Text(
                      'Proceed',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String label, bool isActive) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF1A1A2E) : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              '$number',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isActive ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? const Color(0xFF1A1A2E) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
