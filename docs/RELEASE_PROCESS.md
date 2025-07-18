# Release Process

This document outlines the release process for the Masarat Mobile application.

## Version Numbering

We use [Semantic Versioning](https://semver.org/) for all releases:

- **Major version** (x.0.0): Significant changes that may include breaking changes
- **Minor version** (0.x.0): New features with backward compatibility
- **Patch version** (0.0.x): Bug fixes and small improvements

## Pre-Release Checklist

Before initiating a release, ensure the following:

1. All planned features for the release are complete
2. All tests are passing (unit, widget, integration)
3. Code coverage meets the minimum threshold (80%)
4. All pull requests for the release have been reviewed and merged
5. The app has been tested on multiple devices and screen sizes
6. Localization is complete for all supported languages
7. Performance benchmarks meet expected standards
8. Security audit has been conducted
9. Accessibility requirements are met

## Release Branches

We use the following branch structure for releases:

- `master`: Production-ready code
- `develop`: Development branch where features are integrated
- `release/x.y.z`: Release branches for preparing specific versions
- `feature/*`: Feature branches for ongoing development
- `hotfix/*`: Branches for critical fixes to production

## Release Steps

### 1. Create Release Branch

```bash
git checkout develop
git pull origin develop
git checkout -b release/x.y.z
```

### 2. Update Version Numbers

Update version in:


- `pubspec.yaml`
- `android/app/build.gradle`
- `ios/Runner/Info.plist`

### 3. Generate Release Notes


Create a changelog entry in `CHANGELOG.md` including:

- New features
- Bug fixes
- Performance improvements
- Breaking changes (if any)
- Contributors

### 4. Final Testing

1. Build release candidates for all platforms
2. Perform regression testing
3. Verify all critical paths work correctly

### 5. Merge Release Branch

```bash
git checkout master
git merge --no-ff release/x.y.z -m "Release x.y.z"
git tag -a vx.y.z -m "Version x.y.z"
git push origin master --tags
```

### 6. Update Development Branch

```bash
git checkout develop
git merge --no-ff release/x.y.z -m "Merge release x.y.z back into develop"
git push origin develop
```

## App Store Submission

### Google Play Store


1. Build signed app bundle:

```bash
flutter build appbundle --flavor production --target lib/main_production.dart
```

2. Upload to Google Play Console
3. Fill in release notes and marketing materials
4. Submit for review


### Apple App Store

1. Build iOS archive:

```bash
flutter build ios --flavor production --target lib/main_production.dart
```

2. Open Xcode and create archive
3. Upload to App Store Connect
4. Fill in release notes and marketing materials
5. Submit for review

## Post-Release

1. Monitor crash reports and user feedback
2. Prepare hotfixes if necessary
3. Start planning for the next release cycle
4. Update project roadmap

## Hotfix Process


For critical issues in production:

1. Create hotfix branch from master:

```bash
git checkout master
git checkout -b hotfix/x.y.(z+1)
```

2. Fix the issue
3. Update version numbers
4. Follow steps 5-6 from the normal release process
5. Create an additional tag for the hotfix

## Release Schedule

- **Major releases**: Every 6 months
- **Minor releases**: Every 1-2 months
- **Patch releases**: As needed for bug fixes
- **Hotfixes**: Immediately for critical issues
