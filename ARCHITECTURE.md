# Swift Chapter USA Finder - MVVM Architecture Guide

## Architecture Overview

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern with a test-driven development approach.

### Directory Structure

```
SwiftChapterUSA_finder/
├── Models/                      # Data models
│   ├── User.swift
│   ├── Chapter.swift
│   ├── University.swift
│   └── BlogPost.swift
├── Views/                       # SwiftUI Views
│   ├── AuthenticationView.swift
│   ├── ChaptersView.swift
│   ├── CreateChapterView.swift
│   ├── UniversitiesView.swift
│   ├── MembersView.swift
│   ├── BlogView.swift
│   ├── ProfileView.swift
│   ├── DisclaimerView.swift
│   ├── MainTabView.swift
│   └── ChapterDetailView.swift
├── ViewModels/                  # Business logic
│   ├── AuthenticationViewModel.swift
│   ├── ChaptersViewModel.swift
│   ├── CreateChapterViewModel.swift
│   ├── UniversitiesViewModel.swift
│   ├── MembersViewModel.swift
│   ├── BlogViewModel.swift
│   ├── CreatePostViewModel.swift
│   └── ProfileViewModel.swift
├── Services/                    # Data services
│   ├── AuthenticationManager.swift
│   └── ChapterManager.swift
├── Protocols/                   # Abstraction layers
│   ├── AuthenticationServiceProtocol.swift
│   └── ChapterServiceProtocol.swift
├── Data/                        # Sample data
│   ├── ChapterData.swift
│   └── UniversityData.swift
└── Tests/                       # Unit tests
    ├── ModelTests.swift
    ├── AuthenticationViewModelTests.swift
    ├── ChaptersViewModelTests.swift
    ├── CreateChapterViewModelTests.swift
    ├── UniversitiesViewModelTests.swift
    ├── BlogViewModelTests.swift
    ├── ProfileViewModelTests.swift
    ├── ServiceTests.swift
    ├── MockAuthenticationService.swift
    └── MockChapterService.swift
```

## MVVM Components

### 1. Models
Pure data structures that represent the domain objects:
- `User`: User account information
- `Chapter`: TPUSA chapter data
- `University`: University information
- `BlogPost`: Blog posts and replies

**Characteristics:**
- Conform to `Codable` for serialization
- No business logic
- Computed properties for derived data only

### 2. Views
SwiftUI views that display data and capture user interactions:
- Bind to ViewModels using `@ObservedObject` or `@StateObject`
- Handle UI layout and presentation
- Delegate user actions to ViewModels
- No business logic

**Example:**
```swift
struct ChaptersView: View {
    @StateObject private var viewModel: ChaptersViewModel
    
    var body: some View {
        // UI code
    }
}
```

### 3. ViewModels
Contains presentation logic and state management:
- Conform to `ObservableObject`
- Use `@Published` for observable properties
- Transform model data for view consumption
- Handle user actions
- Communicate with services via protocols

**Responsibilities:**
- Form validation
- Data filtering and searching
- State management
- User action handling

**Example:**
```swift
class ChaptersViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredChapters: [Chapter] = []
    
    private let chapterService: ChapterServiceProtocol
    
    init(chapterService: ChapterServiceProtocol) {
        self.chapterService = chapterService
    }
}
```

### 4. Services
Handle data operations and business logic:
- Implement protocol interfaces
- Manage data persistence
- API communication (future)
- Data transformation

### 5. Protocols
Define contracts for dependency injection:
- Enable testability through mocking
- Decouple ViewModels from concrete implementations
- Support multiple implementations

## Testing Strategy

### Unit Tests Coverage

#### Model Tests (`ModelTests.swift`)
- Model initialization
- Computed properties
- Codable conformance
- Data validation

#### ViewModel Tests
Each ViewModel has comprehensive tests:
- **AuthenticationViewModelTests**: Login/registration validation, form handling
- **ChaptersViewModelTests**: Filtering, searching, state management
- **CreateChapterViewModelTests**: Form validation, chapter creation
- **UniversitiesViewModelTests**: University filtering and grouping
- **BlogViewModelTests**: Post filtering, reply handling
- **ProfileViewModelTests**: Profile updates, data loading

#### Service Tests (`ServiceTests.swift`)
- AuthenticationManager: Register, login, logout, user updates
- ChapterManager: Data loading, searching, adding chapters/posts

### Mock Services
- `MockAuthenticationService`: Simulates authentication without UserDefaults
- `MockChapterService`: Provides test data without real data source

### Running Tests

```bash
# Run all tests
⌘ + U in Xcode

# Run specific test class
⌘ + U with test class selected

# Run single test method
Click diamond icon next to test method
```

## Dependency Injection

ViewModels receive dependencies through initializers:

```swift
// Production
let authService = AuthenticationManager()
let viewModel = AuthenticationViewModel(authService: authService)

// Testing
let mockAuthService = MockAuthenticationService()
let viewModel = AuthenticationViewModel(authService: mockAuthService)
```

## Best Practices

### ViewModels
1. **Single Responsibility**: Each ViewModel handles one feature
2. **Protocol-Oriented**: Depend on protocols, not concrete types
3. **Testable**: All dependencies injected via initializer
4. **Observable**: Use `@Published` for UI-bound properties

### Views
1. **Declarative**: Describe what to show, not how
2. **Thin**: Minimal logic, delegate to ViewModel
3. **Reusable**: Extract common components
4. **Readable**: Clear structure and naming

### Services
1. **Protocol First**: Define protocol before implementation
2. **Focused**: Single responsibility per service
3. **Stateless (when possible)**: Minimize mutable state
4. **Async-Ready**: Prepare for async/await patterns

### Testing
1. **Arrange-Act-Assert**: Clear test structure
2. **Isolated**: Each test independent
3. **Descriptive**: Test names describe what's tested
4. **Comprehensive**: Cover happy paths and edge cases

## Data Flow

```
User Action → View → ViewModel → Service → Model
                ↑         ↓
                └─────────┘
              @Published properties
```

1. User interacts with View
2. View calls ViewModel method
3. ViewModel validates/processes
4. ViewModel calls Service
5. Service updates Model
6. ViewModel publishes changes
7. View automatically updates

## Future Enhancements

### Backend Integration
- Replace UserDefaults with API calls
- Implement network layer with URLSession
- Add Combine publishers for async operations

### Advanced Testing
- UI tests with XCUITest
- Integration tests
- Performance tests
- Snapshot tests

### Additional Patterns
- Coordinator for navigation
- Repository pattern for data access
- Use cases for complex business logic

## Contributing

When adding new features:
1. Create protocol for new service
2. Implement service with protocol
3. Create ViewModel with injected dependencies
4. Write unit tests with mocks
5. Create View binding to ViewModel
6. Update documentation

## References

- [Apple's SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [MVVM Pattern](https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project)
- [Testing in Swift](https://developer.apple.com/documentation/xctest)
- [Protocol-Oriented Programming](https://developer.apple.com/videos/play/wwdc2015/408/)
