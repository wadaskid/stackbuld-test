# Product Catalog App

## Overview

The Product Catalog App is a Flutter application designed for browsing, filtering, and managing products. Built using Firebase Firestore and Firebase Storage, this app provides a seamless user experience with a focus on performance and responsive design. The app uses Flutter’s animation capabilities to enhance interactions and visual appeal.

## Features

- **Product Browsing:** View a list of products with detailed information.
- **Filtering:** Filter products by category and price range.
- **Image Handling:** Upload and display product images.
- **Responsive Design:** Adaptable to various screen sizes and orientations.
- **Smooth Animations:** Includes animations for transitions and loading indicators.

## Setting Up and Running Locally

### Prerequisites

- Flutter (version 3.0 or higher)
- Dart (version 2.17 or higher)
- Firebase project with Firestore and Firebase Storage enabled

### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/your-username/product-catalog-app.git
   cd product-catalog-app
Install Dependencies:

Ensure Flutter is installed and then run:

bash
Copy code
flutter pub get
Configure Firebase:

Create a Firebase project at Firebase Console.
Add an Android and/or iOS app to your Firebase project and follow the setup instructions.
Download the google-services.json (for Android) and/or GoogleService-Info.plist (for iOS) files.
Place these files in the appropriate directories:
android/app/ for google-services.json
ios/Runner/ for GoogleService-Info.plist
Run the App:

Connect your device or start an emulator, then execute:

bash
Copy code
flutter run
Design Decisions, Optimizations, and Trade-offs
State Management: The app uses GetX for state management, providing a reactive programming model that simplifies state management and reduces boilerplate code.

Performance Optimization:

Image Caching: Utilizes CachedNetworkImage to cache images and minimize network usage.
Firestore Streams: Implements real-time updates via Firestore streams to keep the UI synchronized with the backend.
Responsive Design:

Layout Widgets: Employs Flutter’s layout widgets and media queries to ensure responsiveness across different devices.
Adaptive UI: Ensures a consistent user experience on both small and large screens.
Animations:

Loading Indicators: Uses CircularProgressIndicator for displaying loading states.
Transitions: Implements smooth transitions and interactive animations to enhance user experience.
State Management Solution
GetX is employed for state management in this app, offering:

Reactive State Management: Automatically updates the UI when state changes.
Dependency Injection: Efficiently manages controllers and their lifecycles.
Routing: Simplifies navigation and route management.
GetX provides a streamlined approach to state management with minimal boilerplate, ensuring a clean and scalable codebase.

Code Samples
AddProductDialog
dart
Copy code
// AddProductDialog code provided above
EditProductDialog
dart
Copy code
// EditProductDialog code provided above
ProductDetailsView
dart
Copy code
// ProductDetailsView code provided above
ProductController
dart
Copy code
// ProductController code provided above
Additional Information
Flutter Version: Ensure that you use Flutter 3.0 or higher for compatibility.
Firebase Integration: Make sure Firebase is properly configured as per the Firebase setup guide.
For further details, refer to the GetX documentation and Flutter’s official documentation.

Feel free to open an issue or submit a pull request if you encounter any problems or have suggestions for improvements.