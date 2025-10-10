#!/bin/sh
flutter gen-l10n
flutter pub global run intl_utils:generate
# generate the hive adapters
flutter packages pub run build_runner build --delete-conflicting-outputs