class MockUser {
  final String name;
  final String email;
  final String? avatarUrl;

  const MockUser({required this.name, required this.email, this.avatarUrl});
}

class Settings {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final String language;
  final bool aiInsightsEnabled;

  const Settings({
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.language,
    required this.aiInsightsEnabled,
  });
}

// Mock data for development
class MockData {
  static const user = MockUser(
    name: 'Muhammad Naeem',
    email: 'naeem@example.com',
    avatarUrl: null, // Using placeholder for now
  );

  static const settings = Settings(
    isDarkMode: true,
    notificationsEnabled: true,
    language: 'English',
    aiInsightsEnabled: true,
  );

  static const availableLanguages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Arabic',
  ];
}
