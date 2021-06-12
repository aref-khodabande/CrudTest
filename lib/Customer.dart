class Customer {
  String firstName;
  String lastName;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String bankAccountNumber;

  Customer(
      {this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.phoneNumber,
      this.email,
      this.bankAccountNumber});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
      'email': email,
      'bankAccountNumber': bankAccountNumber
    };
  }

  @override
  String toString() {
    return 'Customer{firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth ,phoneNumber: $phoneNumber, email: $email, bankAccountNumber: $bankAccountNumber}';
  }
}
