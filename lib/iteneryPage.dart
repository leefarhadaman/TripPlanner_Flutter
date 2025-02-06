import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItineraryPage extends StatelessWidget {
  final dynamic itineraryData;

  ItineraryPage({required this.itineraryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return _WideLayout(itineraryData: itineraryData);
            } else {
              return _NarrowLayout(itineraryData: itineraryData);
            }
          },
        ),
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  final dynamic itineraryData;

  _WideLayout({required this.itineraryData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _TripSummary(itineraryData: itineraryData),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // two columns on wide screens
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: itineraryData['activities'].length,
            itemBuilder: (context, index) {
              return _buildActivityItem(itineraryData['activities'][index], index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(dynamic activity, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Implement activity details view
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildActivityTimeCard(activity),
              SizedBox(height: 16),
              Text(
                activity['activity'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                activity['description'],
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTimeCard(dynamic activity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        activity['day'],
        style: TextStyle(
          color: Colors.blue[700],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  final dynamic itineraryData;

  _NarrowLayout({required this.itineraryData});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _TripSummary(itineraryData: itineraryData),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return _buildActivityItem(itineraryData['activities'][index], index);
              },
              childCount: itineraryData['activities'].length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(dynamic activity, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Implement activity details view
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildActivityTimeCard(activity),
              SizedBox(height: 16),
              Text(
                activity['activity'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                activity['description'],
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTimeCard(dynamic activity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        activity['day'],
        style: TextStyle(
          color: Colors.blue[700],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _TripSummary extends StatelessWidget {
  final dynamic itineraryData;

  _TripSummary({required this.itineraryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 32),
          _buildDestinationCard(),
          SizedBox(height: 16),
          _buildDateCard(),
          SizedBox(height: 16),
          _buildTripStats(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Trip Summary",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDestinationCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.location_on, color: Colors.blue, size: 32),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Destination",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    itineraryData['destination'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Icon(Icons.flight_land, color: Colors.green),
                  SizedBox(height: 8),
                  Text(
                    "Check-in",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(
                      DateTime.parse(itineraryData['dates']['check_in']),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: 1,
              color: Colors.grey[300],
            ),
            Expanded(
              child: Column(
                children: [
                  Icon(Icons.flight_takeoff, color: Colors.red),
                  SizedBox(height: 8),
                  Text(
                    "Check-out",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(
                      DateTime.parse(itineraryData['dates']['check_out']),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripStats() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trip Statistics",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.calendar_today,
                  label: "Duration",
                  value: "${_calculateDuration()} days",
                ),
                _buildStatItem(
                  icon: Icons.map,
                  label: "Activities",
                  value: "${itineraryData['activities'].length}",
                ),
                _buildStatItem(
                  icon: Icons.attach_money,
                  label: "Budget",
                  value: "\$${_calculateBudget()}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  int _calculateDuration() {
    final checkIn = DateTime.tryParse(itineraryData['dates']['check_in'] ?? '');
    final checkOut = DateTime.tryParse(itineraryData['dates']['check_out'] ?? '');
    if (checkIn != null && checkOut != null) {
      return checkOut.difference(checkIn).inDays;
    } else {
      return 0; // Return 0 or any default value if dates are missing or invalid
    }
  }

  double _calculateBudget() {
    if (itineraryData['activities'] == null || itineraryData['activities'].isEmpty) {
      return 0.0; // Return 0 if no activities are present
    }
    return itineraryData['activities']
        .fold(0.0, (total, activity) => total + (activity['cost'] ?? 0.0)); // Use null-aware operator
  }

}
