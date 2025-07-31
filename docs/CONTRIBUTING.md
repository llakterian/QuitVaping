# Contributing to QuitVaping

Thank you for your interest in contributing to QuitVaping! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Code Style Guidelines](#code-style-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)
- [Branch Naming Conventions](#branch-naming-conventions)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:

- Be respectful and inclusive
- Focus on constructive feedback
- Help create a welcoming environment for all contributors
- Report any unacceptable behavior to the maintainers

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/llakterian/QuitVaping.git
   cd QuitVaping
   ```
3. **Set up the development environment** following the [Setup Guide](SETUP.md)
4. **Create a new branch** for your contribution:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Workflow

### 1. Before You Start
- Check existing issues to avoid duplicate work
- Create an issue to discuss major changes before implementing
- Ensure you understand the project structure and architecture

### 2. Making Changes
- Write clean, readable code following our style guidelines
- Add tests for new functionality
- Update documentation as needed
- Test your changes thoroughly on multiple devices/platforms

### 3. Before Submitting
- Run all tests: `flutter test`
- Check code formatting: `dart format .`
- Run static analysis: `flutter analyze`
- Build the app: `flutter build apk --debug`
- Test on both Android and iOS if possible

## Code Style Guidelines

### Dart/Flutter Code Style

#### General Principles
- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Keep functions small and focused
- Add comments for complex logic
- Use const constructors where possible

#### Formatting
- Use `dart format .` to automatically format code
- Line length: 80 characters maximum
- Use 2 spaces for indentation
- Place opening braces on the same line

#### Example:
```dart
class BreathingExercise {
  const BreathingExercise({
    required this.name,
    required this.duration,
    this.description,
  });

  final String name;
  final Duration duration;
  final String? description;

  // Good: Clear, descriptive method name
  bool isLongExercise() {
    return duration.inMinutes > 10;
  }
}
```

#### Widget Structure
- Use const constructors for stateless widgets
- Extract complex widgets into separate files
- Use meaningful widget names that describe their purpose
- Prefer composition over inheritance

#### State Management
- Use Provider for state management
- Keep business logic separate from UI code
- Use services for data operations
- Follow the established architecture patterns

### File Organization
- Group related files in feature folders
- Use descriptive file names
- Keep files focused on a single responsibility
- Follow the existing project structure:
  ```
  lib/
  ├── features/
  │   └── feature_name/
  │       ├── screens/
  │       ├── widgets/
  │       ├── models/
  │       └── services/
  ```

## Pull Request Process

### 1. Before Creating a PR
- Ensure your branch is up to date with main:
  ```bash
  git checkout main
  git pull origin main
  git checkout your-branch
  git rebase main
  ```
- Run all tests and checks
- Update documentation if needed

### 2. Creating the PR
- Use a clear, descriptive title
- Fill out the PR template completely
- Reference related issues using keywords (e.g., "Fixes #123")
- Add screenshots for UI changes
- Request review from maintainers

### 3. PR Requirements
- [ ] Code follows style guidelines
- [ ] Tests pass (`flutter test`)
- [ ] Code analysis passes (`flutter analyze`)
- [ ] App builds successfully
- [ ] Documentation updated (if applicable)
- [ ] Screenshots included (for UI changes)
- [ ] Breaking changes documented

### 4. Review Process
- Address reviewer feedback promptly
- Make requested changes in new commits
- Engage in constructive discussion
- Be patient - reviews take time

### 5. After Approval
- Maintainers will merge your PR
- Your branch will be deleted automatically
- Thank you for your contribution!

## Issue Reporting

### Bug Reports
When reporting bugs, please include:

- **Clear title** describing the issue
- **Steps to reproduce** the bug
- **Expected behavior** vs actual behavior
- **Screenshots or videos** if applicable
- **Device information**:
  - Device model
  - Operating system version
  - App version
- **Console logs** if available

### Feature Requests
For new features, please provide:

- **Clear description** of the feature
- **Use case** - why is this needed?
- **Proposed solution** (if you have one)
- **Alternative solutions** considered
- **Additional context** or mockups

### Issue Labels
We use the following labels:
- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Improvements to documentation
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed
- `priority: high/medium/low` - Issue priority

## Branch Naming Conventions

Use descriptive branch names that indicate the type of work:

### Branch Types
- `feature/` - New features
- `bugfix/` - Bug fixes
- `hotfix/` - Critical fixes for production
- `docs/` - Documentation updates
- `refactor/` - Code refactoring
- `test/` - Adding or updating tests

### Examples
- `feature/breathing-exercise-timer`
- `bugfix/progress-tracking-crash`
- `docs/update-setup-guide`
- `refactor/breathing-service-cleanup`

### Branch Naming Rules
- Use lowercase letters
- Use hyphens to separate words
- Be descriptive but concise
- Include issue number if applicable: `feature/123-add-dark-mode`

## Testing Guidelines

### Test Types
1. **Unit Tests** - Test individual functions and classes
2. **Widget Tests** - Test individual widgets
3. **Integration Tests** - Test complete user flows

### Writing Tests
- Write tests for new functionality
- Maintain or improve test coverage
- Use descriptive test names
- Follow the AAA pattern (Arrange, Act, Assert)

### Example Test
```dart
void main() {
  group('BreathingExercise', () {
    test('should identify long exercises correctly', () {
      // Arrange
      final exercise = BreathingExercise(
        name: 'Deep Breathing',
        duration: Duration(minutes: 15),
      );

      // Act
      final isLong = exercise.isLongExercise();

      // Assert
      expect(isLong, isTrue);
    });
  });
}
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/breathing_exercise_test.dart

# Run tests with coverage
flutter test --coverage
```

## Documentation

### Code Documentation
- Add dartdoc comments for public APIs
- Document complex algorithms or business logic
- Keep comments up to date with code changes

### README Updates
- Update README.md for significant changes
- Add new features to the features list
- Update screenshots if UI changes significantly

### Changelog
- Add entries to CHANGELOG.md for notable changes
- Follow semantic versioning principles
- Include migration notes for breaking changes

## Getting Help

### Communication Channels
- **GitHub Issues** - For bugs and feature requests
- **GitHub Discussions** - For questions and general discussion
- **Pull Request Comments** - For code-specific discussions

### Resources
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Project Setup Guide](SETUP.md)
- [Features Documentation](FEATURES.md)

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes for significant contributions
- Special thanks in documentation

## Questions?

If you have questions about contributing, please:
1. Check existing documentation
2. Search closed issues for similar questions
3. Create a new issue with the `question` label
4. Be patient and respectful when asking for help

Thank you for contributing to QuitVaping! Your efforts help people on their journey to quit vaping. 🌟