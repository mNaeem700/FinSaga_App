class OnboardingPage {
  final String title;
  final String description;
  final String lottieAsset;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.lottieAsset,
  });
}

final onboardingPages = [
  OnboardingPage(
    title: 'Track Spending Easily',
    description: 'Monitor and manage your daily expenses effortlessly.',
    lottieAsset: 'assets/animations/wallet.json',
  ),
  OnboardingPage(
    title: 'AI-Powered Insights',
    description: 'Get smart spending suggestions tailored just for you.',
    lottieAsset: 'assets/animations/brain.json',
  ),
  OnboardingPage(
    title: 'Smart Goals & Budgets',
    description: 'Set your goals and stay on top of your savings.',
    lottieAsset: 'assets/animations/target.json',
  ),
  OnboardingPage(
    title: 'Secure & Synced',
    description: 'All your data stays safe and synced with the cloud.',
    lottieAsset: 'assets/animations/lock.json',
  ),
];
