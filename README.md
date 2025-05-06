## 🚀 Hero Animation App (Flutter)

This Flutter app displays a list of social media logos (e.g., Facebook, Instagram). Tapping a logo transitions to a detail screen using a smooth **Hero animation**.

### Flow of the App

1. `main.dart` launches `MyApp`, which sets the home to `LogoListScreen`.
2. `LogoListScreen` shows a `ListView` of logos using `Image.asset`, each wrapped in a `Hero` widget.
3. Tapping a logo adds a slight delay and navigates to `LogoDetailScreen`.
4. `LogoDetailScreen` also uses the same `Hero` tag to show an enlarged image with animation.

###  Key Concepts

- **Hero widget** for shared element transition.
- **ListView.builder** for rendering logo items.
- **Navigator.push** with delay for smooth UX.

###  Assets

Images are stored in the `/images` folder. Make sure to declare them in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - images/facebook.png
    - images/instagram.jpeg
```

