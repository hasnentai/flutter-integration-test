# GitHub Actions for Flutter Integration Tests

This directory contains GitHub Actions workflows for running Flutter integration tests automatically.

## Available Workflows

### 1. Basic Integration Tests (`integration-tests.yml`)
- Simple workflow that runs integration tests on push/PR to main/develop branches
- Uses Flutter 3.32.8 (stable)
- Runs on Ubuntu latest
- Basic error handling and artifact upload

### 2. Advanced Integration Tests (`integration-tests-advanced.yml`)
- More comprehensive workflow with matrix testing
- Tests multiple Flutter versions
- Includes caching for better performance
- Better error handling and debugging
- Manual trigger with custom Flutter version input

## How to Use

### Automatic Triggers
- **Push to main/develop**: Automatically runs tests
- **Pull Request to main/develop**: Automatically runs tests
- **Manual trigger**: Use "workflow_dispatch" to run manually

### Manual Trigger (Advanced Workflow)
1. Go to Actions tab in your GitHub repository
2. Select "Flutter Integration Tests (Advanced)"
3. Click "Run workflow"
4. Optionally specify a custom Flutter version
5. Click "Run workflow"

## Configuration

### Flutter Version
- Basic workflow: Fixed at 3.32.8
- Advanced workflow: Matrix testing with 3.32.8 and 3.32.0

### Test Command
Both workflows use:
```bash
flutter drive \
  --driver test_driver/integration_test.dart \
  --target integration_test/test.dart \
  -d web-server \
  --headless \
  --timeout 120
```

### Why Web-Server Device?
- More reliable in CI/CD environments
- Exits cleanly after tests complete
- No hanging issues
- Better suited for automated testing

## Customization

### Add More Flutter Versions
Edit the matrix in `integration-tests-advanced.yml`:
```yaml
flutter_version: ['3.32.8', '3.32.0', '3.31.0']
```

### Change Test Timeout
Modify the `--timeout` value and environment variables:
```yaml
--timeout 180
env:
  FLUTTER_TEST_TIMEOUT: 180
  FLUTTER_DRIVE_TIMEOUT: 180
```

### Add More Branches
Edit the trigger branches:
```yaml
on:
  push:
    branches: [ main, develop, feature/* ]
  pull_request:
    branches: [ main, develop ]
```

## Troubleshooting

### Tests Hanging
- The `--timeout` flag ensures tests don't hang indefinitely
- Web-server device is more reliable than Chrome for CI/CD

### Flutter Version Issues
- Use the advanced workflow to test multiple Flutter versions
- Check `flutter doctor` output in the workflow logs

### Performance Issues
- The advanced workflow includes caching for better performance
- Consider reducing the number of Flutter versions in matrix testing 