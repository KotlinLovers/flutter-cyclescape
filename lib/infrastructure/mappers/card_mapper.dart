import '../../domain/domain.dart';

class CardMapper {
  static CardPayment jsonToEntity(Map<String, dynamic> json) {
    return CardPayment(
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
