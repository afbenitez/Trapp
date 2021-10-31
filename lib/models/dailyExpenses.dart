
class DailyExpenses{

  final int amount;
  final int  day;
  final String plansId;

  DailyExpenses({
    required this.amount,
    required this.day,
    required this.plansId
  });

  Map<String, dynamic> toJson(){
    return {
      'amount': amount,
      'dayNumber': day,
      'planId': plansId,
    };
  }
}