import '../../../../../services/network/request.dart';

class NotionPublisherRequest extends PostRequest {
  const NotionPublisherRequest({
    required this.name,
    required this.amount,
    required this.type,
    required this.dateTime,
  }) : super(
          path: 'v1/pages',
          domain: 'api.notion.com',
        );

  final String name;
  final double amount;

  /// Credit or debit
  final String type;

  final DateTime dateTime;
}
