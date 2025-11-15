# Quick Start Guide

## Overview
SwiftChapter USA Finder - A SwiftUI app for finding Turning Point USA chapters with MVVM architecture and comprehensive test coverage.

## 🚀 Quick Setup

### 1. Clone & Open
```bash
git clone https://github.com/bholsinger09/Swift_Finda_Chapter_TurningPoint_Helper.git
cd Swift_Finda_Chapter_TurningPoint_Helper
open SwiftChapterUSA_finder.xcodeproj
```

### 2. Run the App
- Select iPhone simulator or device
- Press `⌘R`

### 3. Run Tests
- Press `⌘U` to run all tests
- View test coverage in Report Navigator

## 📁 Project Structure Quick Reference

```
Models/          → Data structures (User, Chapter, etc.)
Views/           → SwiftUI UI components
ViewModels/      → Business logic (testable)
Services/        → Data management
Protocols/       → Service abstractions
Tests/           → Unit tests (43+ tests)
```

## 🧪 Test-Driven Development

### Writing a New Feature

**1. Define Protocol**
```swift
protocol NewServiceProtocol {
    func doSomething()
}
```

**2. Create Mock**
```swift
class MockNewService: NewServiceProtocol {
    var doSomethingCalled = false
    func doSomething() { doSomethingCalled = true }
}
```

**3. Write Tests**
```swift
func testFeature() {
    let mock = MockNewService()
    let viewModel = NewViewModel(service: mock)
    
    viewModel.performAction()
    
    XCTAssertTrue(mock.doSomethingCalled)
}
```

**4. Implement**
```swift
class NewViewModel: ObservableObject {
    private let service: NewServiceProtocol
    
    func performAction() {
        service.doSomething()
    }
}
```

## 📚 Key Files

- **README.md** - Complete documentation
- **ARCHITECTURE.md** - Architecture details
- **CONTRIBUTING.md** - How to contribute
- **MVVM_REFACTORING.md** - MVVM transformation details

## 🎯 Common Tasks

### Add New Chapter
1. Navigate to Chapters tab
2. Tap + icon
3. Fill form and submit

### Run Specific Tests
```bash
# All tests
⌘ + U

# Specific test class
Click diamond next to class name

# Test coverage
Product → Test → Enable "Gather coverage data"
```

### Debug
- Set breakpoints in ViewModels (not Services)
- Use `print()` for quick debugging
- Check Console for errors

## 📊 Test Coverage

| Component | Tests | Coverage |
|-----------|-------|----------|
| Models | 15+ | >90% |
| ViewModels | 43+ | >85% |
| Services | 10+ | >80% |

## 🔧 Build Configuration

### Debug
- Enable assertions
- Verbose logging
- Mock data

### Release
- Optimized build
- Minimal logging
- Production data

## 📱 Supported Platforms

- iOS 13.0+
- macOS (via Catalyst)
- iPhone 11-16
- iPad (universal)

## 🐛 Troubleshooting

**Build fails?**
- Clean build folder: `⌘ + Shift + K`
- Reset simulators
- Update Xcode

**Tests fail?**
- Check UserDefaults is cleared in setup
- Verify mock data
- Run tests individually

**App crashes?**
- Check Console for errors
- Verify data models
- Check environment objects

## 📖 Learning Resources

- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [MVVM Pattern](https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project)
- [Unit Testing](https://developer.apple.com/documentation/xctest)

## 💡 Tips

1. **Always write tests first** (TDD approach)
2. **Keep Views simple** - logic goes in ViewModels
3. **Use protocols** for all services
4. **Mock for testing** - never test with real services
5. **Document complex logic** with comments

## 🤝 Contributing

1. Fork the repo
2. Create feature branch
3. Write tests
4. Implement feature
5. Ensure all tests pass
6. Submit PR

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## ⚠️ Important Notes

- **Not official TPUSA app** - See disclaimer
- **Sample data only** - Implement real backend
- **Local storage** - UserDefaults (replace with API)
- **Basic auth** - Add proper authentication

## 📞 Support

- Issues: [GitHub Issues](https://github.com/bholsinger09/Swift_Finda_Chapter_TurningPoint_Helper/issues)
- Discussions: [GitHub Discussions](https://github.com/bholsinger09/Swift_Finda_Chapter_TurningPoint_Helper/discussions)
- Official TPUSA: [www.tpusa.com](https://www.tpusa.com)

---

**Ready to build?** 🎉

```bash
git clone https://github.com/bholsinger09/Swift_Finda_Chapter_TurningPoint_Helper.git
cd Swift_Finda_Chapter_TurningPoint_Helper
open SwiftChapterUSA_finder.xcodeproj
# Press ⌘R to run!
```
