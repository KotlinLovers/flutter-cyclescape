class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String token;
  final String phone;
  final String bithDate;
  final double latitude;
  final double longitude;
  final String imageData;

  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.token,
      required this.phone,
      required this.bithDate,
      required this.latitude,
      required this.longitude,
      required this.imageData});

}
