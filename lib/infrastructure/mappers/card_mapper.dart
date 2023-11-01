import '../../domain/domain.dart';

class CardMapper {
  static Card jsonToEntity(Map<String, dynamic> json) {
    return Card(
        id: json['id'],
        cardNumber: json['cardNumber'],
        cardType: json['cardType'],
        cardCvv: json['cardCvv'],
        cardExpirationDate: json['cardExpirationDate'],
        cardAmount: json['cardAmount'],
        cardHolder: json['cardHolder'],
        cardMain: json['cardMain']
    );
  }
}
