class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String city;
  final String street;
  final int streetNumber;
  final String zipcode;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.city,
    required this.street,
    required this.streetNumber,
    required this.zipcode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['name']['firstname'],
      lastName: json['name']['lastname'],
      phone: json['phone'],
      city: json['address']['city'],
      street: json['address']['street'],
      streetNumber: json['address']['number'],
      zipcode: json['address']['zipcode'],
    );
  }
}