# FITeens Mobile Application

A cross-platform mobile application built with Flutter for promoting physical activity and healthy lifestyle habits among teenagers.

## About the Project

FITeens is an Erasmus+ project that aims to raise teenagers' awareness on the importance of physical activity and healthy habits. The mobile application provides:

- **Activity Library** - Browse and participate in various physical activities and health challenges
- **Personalized Routines** - Create and follow custom exercise routines
- **Wellbeing Assessments** - Track health metrics through regular self-assessments
- **Progress Tracking** - Monitor achievements, badges, and activity history
- **Educational Content** - Access videos, articles, and resources on health and fitness
- **Calendar Integration** - Schedule and track planned activities
- **Social Features** - Share progress and participate in group challenges

## Technology Stack

- **Framework:** Flutter (Dart)
- **Platforms:** iOS, Android, Web
- **State Management:** Provider pattern
- **API Communication:** REST API with custom ApiClient
- **Localization:** Multi-language support (Finnish, English, Spanish, Dutch)
- **Video Playback:** Custom video player integration
- **Local Storage:** Hive for offline caching

## Recent Updates (Version 1.0.1)

### Major Improvements

#### 1. **Dependency Updates**
- Updated `package_info_plus` to ^9.0.0
- Updated all core dependencies to latest stable versions
- Resolved dependency conflicts between app and core module
- Improved compatibility with latest Flutter SDK

#### 2. **Backend API Compatibility**
- **Response Format Handling**: Enhanced ApiResponse to handle multiple response structures
  - Standard REST endpoints: Direct data responses
  - Dispatcher endpoints: Nested `json` structures
  - List endpoints: Array responses with proper type checking
  - Form endpoints: Complex nested data with validation

- **Flexible Data Extraction**: Implemented smart data extraction that falls back to `rawData` when `data` field is not present

- **Type Safety**: Added comprehensive type checking for List vs Map responses to prevent runtime crashes

#### 3. **Error Handling Improvements**

##### Network & API Errors
- **ClientException**: Graceful handling of network failures
- **TimeoutException**: Proper timeout handling with user feedback
- **SocketException**: Connection failure recovery
- **FormatException**: JSON parsing error handling
- **HTTP 500 Errors**: Server error handling with fallback messages
- **Null Safety**: Comprehensive null checking throughout the codebase

##### Image Loading
- **Network Image Error Handling**: All network images now have:
  - Loading indicators with progress tracking
  - Error fallbacks to placeholder images
  - Prevents crashes from failed image loads
  - Applied to: Activities, Badges, Webpages, User profiles, Routines

##### Form & Data Handling
- **Form Submission**: Improved validation and error reporting
- **Assessment Forms**: Better handling of nested response structures
- **Activity Registration**: Enhanced feedback on success/failure
- **Calendar Operations**: Clear status messages for all operations

##### UI/UX Improvements
- **Loading States**: Added proper loading indicators when switching between screens/categories
- **Stale Data Prevention**: No longer shows previous category data while loading new content
- **Empty States**: Informative messages when no data is available
- **Debug Mode**: Comprehensive logging for troubleshooting (development only)

#### 4. **Code Quality & Maintainability**
- **Type Safety**: Explicit type checking before casting operations
- **Null Safety**: Proper use of null-aware operators (`?.`, `??`)
- **Error Boundaries**: Try-catch blocks around all critical operations
- **Debug Logging**: Detailed logging with named loggers for easier debugging
- **Code Documentation**: Inline comments explaining complex logic

### Bug Fixes

- ✅ Fixed assessment form showing blank content
- ✅ Fixed activity recording not showing success messages
- ✅ Fixed routine calendar addition feedback
- ✅ Fixed library items showing "no activities" flash
- ✅ Fixed video player not displaying on webpages
- ✅ Fixed login error messages showing as null
- ✅ Fixed List vs Map type casting errors
- ✅ Fixed ListTile layout overflow errors
- ✅ Fixed image loading exceptions across the app

## Development Setup

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK (latest stable)
- iOS: Xcode (for iOS builds)
- Android: Android Studio with Android SDK

### Installation

```bash
# Get dependencies
flutter pub get

# Run code generation (if needed)
./generate.sh

# Run the app
flutter run

# Build for web
./buildweb.sh
```

### Project Structure

```
lib/
├── main.dart              # Application entry point
├── generated/             # Generated localization files
├── l10n/                  # Localization resources
└── src/
    ├── views/             # UI screens and components
    ├── widgets/           # Reusable widgets
    ├── util/              # Utility functions and constants
    └── config/            # App configuration

core/                      # Shared core module
├── lib/
│   ├── src/
│   │   ├── api/          # API client and authentication
│   │   ├── objects/      # Data models
│   │   ├── providers/    # State management providers
│   │   └── util/         # Core utilities
```

## Testing

Run tests with:
```bash
flutter test
```

## Deployment

### Web Build
```bash
./buildweb.sh
```

### iOS Build
```bash
flutter build ios --release
```

### Android Build
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

## Troubleshooting

### Common Issues

**Issue: Dependency conflicts**
```bash
flutter pub upgrade
flutter clean
flutter pub get
```

**Issue: Build errors after update**
```bash
flutter clean
flutter pub get
cd ios && pod install  # iOS only
flutter run
```

**Issue: Network images not loading**
- Check internet connection
- Verify API server is accessible
- Check debug logs for specific error messages

## Contributing

This is an *archived* development project. When contributing:
1. Follow Flutter best practices
2. Add proper error handling for all API calls
3. Include debug logging for troubleshooting
4. Test on multiple platforms before committing
5. Update localization files for all supported languages

## Funding & Acknowledgments

**Funded by The Erasmus+ programme of the European Union**

Development of this Application has been funded with support from the European Commission. This Application reflects the views only of the author, and the Commission cannot be held responsible for any use which may be made of the information contained therein.



---

**Version:** 1.0.1 (November 2025)  
**Platform:** Flutter - iOS, Android, Web  
**Languages:** Finnish, English, Spanish, Dutch, Estonian, Portuguese, Polish
