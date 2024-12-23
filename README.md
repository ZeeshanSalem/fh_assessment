# Finance House Technical Assessment

This project serves as a starting point for a Flutter application designed for mobile top-ups.

## Features

1. **User Wallet Recharge**: Users can recharge their wallet.
2. **Beneficiary Management**: Users can add up to 5 beneficiaries.
3. **Transaction Records**: Users can view all transaction records.
4. **Top-Up Limits**:
   - Verified users can top up beneficiaries up to **1000 AED** per month.
   - Unverified users can top up beneficiaries up to **500 AED** per month.
5. **Monthly Transfer Limit**: Users can transfer up to **3000 AED** to all beneficiaries per month.
6. **Transaction Fees**: A fee of **3 AED** is applied per transaction.

## Demo

[fh-TopUp Application Demo](https://www.youtube.com/watch?v=cOMhJ_YKKas) - Here is the application demo.

## Required Versions

| Variable | Value  |   |
|----------|--------| - |
| Flutter  | 3.27.1 | ✅ |
| Dart     | 3.6.0  | ✅ |

## Getting Started

To start the project, run the following commands:

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Build the project:
   ```bash
   dart run build_runner build
   # or
   flutter pub run build_runner build
   ```

## Running Test Cases

To run the test cases, use the following commands:

1. Run all tests:
   ```bash
   flutter test
   ```

2. Run a specific test case:
   ```bash
   flutter test test/features/home/data/data_source/home_local_data_source_test.dart
   ```

3. You can also run tests directly in your editor.
# Project Structure
fh-assignment/Project-Structure
│
├── android/                     # Contain android-specific files
│
├── ios/                         # Contain iOS-specific files
│
├── lib/                         # Main application code from where application start.
│   ├── core/                    # Core functionalities and widgets which will be used all over app.
│   │   ├── error/               # Contain error type and handling functionality
│   │   │   ├── exception.dart    # Contain exception type enum and Types of Exception.
│   │   │   └── model/           # Error response models
│   │   ├── network/             # Network-related utilities
│   │   │   ├── api_client.dart   # API client setup
│   │   │   └── network_info.dart  # Network connectivity checks
│   │   ├── utils/               # Utility functions and constants
│   │   │   ├── enums.dart        # Enums used across the app
│   │   │   └── preferences_utils.dart # Shared preferences utilities
│   │   ├── utils/               # Contain common widgets which is used all over the app.
│   │   ├── config/               # Contain configuration for flavor[dev, stage, prod].
│   │   └── logger/              # Logging utilities
│   │       └── app_logger.dart   # Logger setup from AbstractLogger.
│   │       └── base_logger.dart   # AbstractLogger method for display, error, and information.
│   │
│   ├── features/                # Feature-specific code
│   │   ├── home/                # In home feature we can change status of account, recharge walled and view all transactions.
│   │   │   ├── data/            # Data layer
│   │   │   │   ├── model/       # Data models: 1. transaction.dart, 2.user.dart
│   │   │   │   ├── repository/   # Repository Class: HomeRepositoryImpl
│   │   │   │   └── data_source/  # Data sources (HomeDataSource)
│   │   │   ├── domain/          # Domain layer
│   │   │   │   └── repository/   # Domain repositories: HomeRepository.
│   │   │   ├── presentation/     # Presentation layer
│   │   │   │   ├── cubit/       # State management (Cubit): HomeCubit and TransactionCubit
│   │   │   │   ├── screens/     # UI screens HomeScreen
│   │   │   │   └── widgets/     # Reusable widgets
│   │
│   ├── main.dart                 # Entry point of the application
│   └── routes.dart               # Route definitions
│
├── test/                         # Unit and widget tests
│   ├── core/                    # Tests for core functionalities
│   ├── features/                # Tests for features
│   │   ├── home/                # In home feature we can change status of account, recharge walled and view all transactions.
│   │   │   ├── data/            # Data layer
│   │   │   │   ├── model_test/       # Data models: 1. transaction_test.dart, 2.user_test.dart
│   │   │   │   ├── repository/   # Repository Class: home_repository_impl_test.dart
│   │   │   │   └── data_source/  # Data sources home_data_source_test.dart
│   │   │   ├── presentation/     # Presentation layer
│   │   │   │   ├── cubit/       # State management (Cubit): transaction_cubit_test.dart
│   │   │   │   ├── screens/     # UI screens HomeScreen
│   │   │   │   └── widgets/     # Reusable widgets
│
├── pubspec.yaml                  # Flutter package configuration
└── README.md                     # Project documentation


