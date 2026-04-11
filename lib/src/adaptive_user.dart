/// Represents an authenticated user in the Adaptive SDK.
class AdaptiveUser {
  /// The unique identifier of the user (e.g., Moodle user ID).
  final String userId;

  /// The display name of the user.
  final String userName;

  /// The email address of the user.
  final String userEmail;
  /// The phone number of the user.
  final String phoneNumber;

  const AdaptiveUser({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.phoneNumber,
  });

  /// Serializes the user to a map for the platform channel.
  Map<String, dynamic> toMap() => {
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'phoneNumber': phoneNumber,
      };

  @override
  String toString() =>
      'AdaptiveUser(userId: $userId, userName: $userName, userEmail: $userEmail, phoneNumber: $phoneNumber)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdaptiveUser &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          userName == other.userName &&
          phoneNumber == other.phoneNumber &&
          userEmail == other.userEmail;

  @override
  int get hashCode => userId.hashCode ^ userName.hashCode ^ userEmail.hashCode ^ phoneNumber.hashCode;
}
