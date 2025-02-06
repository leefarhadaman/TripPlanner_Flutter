class TravelFormData {
  final String destination;
  final String checkInDate;
  final String checkOutDate;
  final String category;
  final int adultsCount;
  final int childrenCount;
  final bool includeBreakfast;

  TravelFormData({
    required this.destination,
    required this.checkInDate,
    required this.checkOutDate,
    required this.category,
    required this.adultsCount,
    required this.childrenCount,
    required this.includeBreakfast,
  });

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'category': category,
      'guests': {
        'adults': adultsCount,
        'children': childrenCount,
      },
      'includeBreakfast': includeBreakfast,
    };
  }
}