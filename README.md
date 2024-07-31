# flutter_chatgpt

A new Flutter project.

## Getting Started

1.flutter clean

2.flutter pub get

3.flutter gen-l10n

4.flutter pub run build_runner build --delete-conflicting-outputs



## Build
Android: flutter build apk --release
    tips: This APP not signed

IOS: Need ios account

MacOS: flutter build macos
    tips: default app. convert to dmg
    1.brew install create-dmg
    2.into Root project dir
        create-dmg --volname ChatGPT \
        --icon-size 100  \
        --window-pos 200 120 \
        --window-size 800 400 \
        --app-drop-link 600 185  \
        build/macos/Build/Products/Release/chatgpt.dmg \
        build/macos/Build/Products/Release/chatgpt.app

Windows: flutter build windows
    tips: use "Inno Setup" created Bootloader program
