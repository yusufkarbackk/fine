part of 'Models.dart';

class FineUser extends ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final int amount;

  FineUser(this.id, this.email, {this.name = "No Name", this.amount = 0});
}
