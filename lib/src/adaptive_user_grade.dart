/// Represents the school grade of a user in the Adaptive SDK.
///
/// Values map to the integer sent over the platform channel, mirroring the
/// native `UserGrade` enum on Android and iOS.
enum UserGrade {
  // ── Primary school (grades 1–6) ───────────────────────────────────────────
  grade1Primary(1),
  grade2Primary(2),
  grade3Primary(3),
  grade4Primary(4),
  grade5Primary(5),
  grade6Primary(6),

  // ── Preparatory school (grades 7–9) ───────────────────────────────────────
  grade1Prep(7),
  grade2Prep(8),
  grade3Prep(9),

  // ── Secondary school (grades 10–12) ───────────────────────────────────────
  grade1Secondary(10),
  grade2Secondary(11),
  grade3Secondary(12);

  /// The integer value sent to the native platform.
  final int value;

  const UserGrade(this.value);
}
