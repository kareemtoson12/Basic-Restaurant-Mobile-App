# Flutter Restaurant Mobile App

A modern restaurant mobile application built with Flutter, featuring user authentication, menu display, and cart functionality. This app demonstrates clean architecture principles and follows Flutter best practices.

## Features

- **User Authentication**
  - Email/password login with Firebase Authentication
  - Secure form validation for login and signup
  - Clean error handling and user feedback

- **Menu Display**
  - Beautifully designed food item cards
  - Display of food name, price, image, and rating
  - Categorized menu sections (Sushi, Chicken, Spaghetti, Sandwich)
  - Smooth scrolling and intuitive navigation

- **Cart Management**
  - Add/remove items functionality
  - Item quantity management
  - Real-time total price calculation
  - Persistent cart state

## Project Structure

```
lib/
├── app/
│   ├── constants/      # App-wide constants (colors, typography)
│   ├── di/            # Dependency injection
│   └── routing/       # Navigation and routing
├── data/
│   ├── data source/   # Data providers and API clients
│   └── repo/          # Repository implementations
├── domain/
│   ├── models/        # Business logic models
│   ├── repo/          # Repository interfaces
│   └── usecases/      # Business logic use cases
└── presentation/
    ├── auth/          # Authentication screens
    ├── cart/          # Cart management
    ├── home/          # Home and menu screens
    └── onboarding/    # Onboarding experience
```

## Technologies Used

- **Flutter SDK**: UI framework
- **Firebase Auth**: User authentication
- **flutter_bloc**: State management
- **flutter_screenutil**: Responsive design
- **google_fonts**: Typography

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Firebase project setup
- Android Studio/VS Code with Flutter plugins

### Installation

1. Clone the repository:
   ```bash
   git clone [repository-url]
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Add `google-services.json` to `android/app`
   - Add `GoogleService-Info.plist` to `ios/Runner`
   - Update Firebase configuration in `lib/firebase_options.dart`

4. Run the app:
   ```bash
   flutter run
   ```

## Development Status

- ✅ Authentication implementation
- ✅ Menu display with static data
- ✅ Cart functionality
- ⏳ Firestore integration (planned)
- ⏳ CI/CD setup (planned)

## Future Improvements

- Implement Firestore for dynamic menu data
- Add user profile management
- Integrate payment processing
- Set up CI/CD with GitHub Actions
- Add unit and widget tests

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
