# Flutter Minesweeper Game

Flutter-based cross-platform Minesweeper game supporting Android, iOS, Web, Windows, Linux, and macOS. The game features a complete BLoC architecture with Provider state management and is deployed to Google Play Store and GitHub Pages.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

**CRITICAL WARNINGS:**
- **NEVER CANCEL BUILD COMMANDS** - Flutter builds require patience and can take 15+ minutes
- Always set command timeouts to at least 25+ minutes for build operations
- Network access required for initial Flutter setup and pub get operations
- Some corporate networks may block Flutter/Dart SDK downloads

## Working Effectively

### Prerequisites and Setup
- Install Flutter SDK version 3.24.5 or later:
  - `git clone https://github.com/flutter/flutter.git -b stable --depth 1`
  - Add Flutter to PATH: `export PATH="$PATH:[path-to-flutter]/flutter/bin"`
  - Run `flutter doctor` to verify installation
- Install required tools:
  - `dart pub global activate pubversion` -- for version management in deployment
  - `sudo gem install fastlane` -- for Android deployment automation  
- Install platform-specific dependencies:
  - Android: Android Studio with Android SDK
  - iOS: Xcode and CocoaPods (`sudo gem install cocoapods`)
  - Web: Chrome browser
  - Linux: `sudo apt-get install build-essential libgtk-3-dev`
  - Coverage reports: `sudo apt-get install lcov` (for genhtml command)

### Build and Test Commands
- Verify Flutter setup: `flutter doctor -v` -- diagnoses installation issues (5-10 seconds)
- Bootstrap project dependencies:
  - `flutter pub get` -- installs all dependencies (30-60 seconds)
- Run unit tests:
  - `flutter test` -- runs game logic tests (15-30 seconds)
  - `flutter test --coverage` -- generates coverage report (30-45 seconds)
- Generate HTML coverage report:
  - `genhtml coverage/lcov.info -o coverage/html` -- requires lcov tool (5-10 seconds)
- Run static analysis:
  - `flutter analyze` -- checks code quality and lint rules (10-20 seconds)

### Platform-Specific Builds
**CRITICAL: NEVER CANCEL BUILD COMMANDS** - Flutter builds can take 2-15 minutes depending on platform and machine. Always set timeout to 25+ minutes minimum. Canceling builds can corrupt build cache and require full clean rebuild.

#### Web Development and Build
- Run web app locally: `flutter run -d chrome` -- starts dev server instantly
- Build for production: `flutter build web --release --base-href /minesweeper/` -- takes 2-5 minutes. NEVER CANCEL. Set timeout to 10+ minutes.

#### Android Development and Build  
- Clean build: `flutter clean && flutter pub get` -- takes 30-90 seconds
- Build APK: `flutter build apk` -- takes 3-8 minutes. NEVER CANCEL. Set timeout to 15+ minutes.
- Build App Bundle: `flutter build appbundle` -- takes 3-8 minutes. NEVER CANCEL. Set timeout to 15+ minutes.
- Deploy to Play Store (requires setup): `cd android && fastlane beta` -- takes 5-10 minutes. NEVER CANCEL. Set timeout to 20+ minutes.

#### iOS Development and Build (macOS only)
- Install pods: `cd ios && pod install` -- takes 2-5 minutes. NEVER CANCEL. Set timeout to 10+ minutes.
- Build iOS: `flutter build ios` -- takes 5-15 minutes. NEVER CANCEL. Set timeout to 25+ minutes.

#### Desktop Builds
- Linux: `flutter build linux` -- takes 3-8 minutes. NEVER CANCEL. Set timeout to 15+ minutes.
- Windows: `flutter build windows` -- takes 3-8 minutes. NEVER CANCEL. Set timeout to 15+ minutes.
- macOS: `flutter build macos` -- takes 5-12 minutes. NEVER CANCEL. Set timeout to 20+ minutes.

### Development Workflow
- Always run `flutter pub get` after changing pubspec.yaml
- Always run `flutter analyze` before committing changes
- Test on multiple platforms when changing core game logic
- Use `flutter run --hot-reload` for rapid development iterations

### Automated Deployment
- Use `./deploy.sh` for Android releases:
  - Increments version using `pubversion patch`
  - Builds app bundle with `flutter build appbundle` 
  - Deploys to Play Store beta track using `fastlane beta`
  - **Total time: 8-15 minutes. NEVER CANCEL. Set timeout to 25+ minutes.**
- Web deployment is automated via GitHub Actions on workflow dispatch

## Validation

### Manual Testing Scenarios
After making changes, ALWAYS test these core user scenarios:
1. **Game Start**: Launch app, select difficulty level, verify grid generates correctly
2. **Basic Gameplay**: Click first square (should never be mine), verify numbers display correctly
3. **Flagging**: Right-click or long-press to flag suspected mines
4. **Win Condition**: Clear all non-mine squares, verify win screen appears
5. **Lose Condition**: Click a mine, verify game over screen and mine reveal
6. **Timer**: Verify timer starts on first click and stops on win/lose
7. **Score Counter**: Verify mine counter decreases when flagging

### Platform-Specific Validation
- Web: Test in Chrome using `flutter run -d chrome`
- Android: Test APK installation and gameplay on device/emulator
- Desktop: Verify mouse interactions work properly

### CI/CD Validation
- Always run `flutter test` and verify all tests pass
- Check that `flutter analyze` produces no errors or warnings
- The GitHub Actions workflow (.github/workflows/main.yml) will run tests automatically
- Web deployment workflow (.github/workflows/deploy-gh-pages.yml) handles version increment and deployment

## Project Structure

### Key Directories and Files
```
lib/
├── main.dart                 # App entry point with Provider setup
├── blocs/                    # Game state management
│   ├── game.bloc.dart        # Main game logic and state
│   └── game.config.dart      # Game configuration constants
├── pages/                    # Screen components
│   ├── splash.page.dart      # Initial loading screen
│   ├── home.page.dart        # Main menu/difficulty selection
│   ├── game.page.dart        # Mobile game interface
│   └── game.page.web.dart    # Web-optimized game interface
├── widgets/                  # Reusable UI components
└── themes/                   # App styling and theming

test/
├── blocs/
│   └── game.bloc._test.dart  # Core game logic tests
├── widget_test.dart          # UI widget tests (currently disabled)
└── version_footer_test.dart  # Component tests

android/                      # Android-specific configuration
├── fastlane/                 # Automated deployment scripts
│   ├── Fastfile             # Fastlane deployment configuration
│   └── README.md            # Fastlane documentation
└── app/build.gradle         # Android build configuration

assets/
├── images/                   # Game icons and graphics (SVG format)
└── fonts/                   # Custom fonts (BungeeShade, TickingTimebombBB)
```

### Important Files to Monitor
- `pubspec.yaml` -- Dependencies and app metadata. Always run `flutter pub get` after changes.
- `analysis_options.yaml` -- Lint rules. Changes here affect `flutter analyze` output.
- `lib/blocs/game.bloc.dart` -- Core game logic. Always test all difficulty levels after changes.
- `lib/blocs/game.config.dart` -- Game settings. Changes affect grid sizes and mine counts.

### Common Code Patterns
- State management uses Provider with ChangeNotifier pattern
- Game logic separated in BLoC classes for testability
- Platform-specific pages for optimal UX (mobile vs web)
- SVG assets for scalable graphics
- Timer management for game duration tracking

## Common Tasks

### Adding New Features
1. Update game logic in `lib/blocs/game.bloc.dart`
2. Add corresponding tests in `test/blocs/game.bloc._test.dart`
3. Update UI components in appropriate page files
4. Run validation scenarios to ensure functionality
5. Test across target platforms

### Debugging Build Issues
- Clean build artifacts: `flutter clean` (30-60 seconds)
- Reset dependencies: `rm pubspec.lock && flutter pub get` (30-90 seconds)  
- Check Flutter doctor: `flutter doctor -v` (5-10 seconds)
- For Android issues: `cd android && ./gradlew clean` (1-3 minutes)
- For web issues: clear browser cache and check console logs
- For iOS issues: `cd ios && rm -rf Pods && pod install` (3-8 minutes. NEVER CANCEL.)
- If builds consistently fail: delete build/ folder and retry

### Deployment Workflow
1. Test changes locally: `flutter test && flutter analyze`
2. For Android: Use `./deploy.sh` script (increments version, builds, deploys)
3. For web: GitHub Actions automatically deploys to GitHub Pages on workflow dispatch
4. Monitor deployment status in GitHub Actions tab

### Performance Considerations
- Game uses Provider for efficient state updates
- Timer runs only during active gameplay
- Grid generation optimized for large sizes (30x30 max)
- SVG assets provide sharp graphics at all scales
- Web build includes base-href for proper GitHub Pages routing

Remember: This is a complete, production-ready game. Always test thoroughly and never skip the validation scenarios when making changes.