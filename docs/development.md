# Development Guide

## Development Workflow

### 1. Feature Development

1. Create a feature branch:
```bash
git checkout -b feature/your-feature-name
```

2. Implement your changes following the layered architecture
3. Add tests for your changes
4. Update documentation if needed
5. Create a pull request

### 2. Code Structure Guidelines

#### Adding New Features

When adding new features, follow this pattern:

1. **Define Models**: Add data structures in `models/`
2. **Create Repository Interface**: Define data access methods
3. **Implement Repository**: Add concrete implementation
4. **Create Usecase Interface**: Define business logic methods
5. **Implement Usecase**: Add business logic implementation
6. **Create Controller Interface**: Define HTTP handler methods
7. **Implement Controller**: Add HTTP handlers

#### Example: Adding a User Feature

```go
// 1. models/user.go
type User struct {
    ID    int    `json:"id"`
    Name  string `json:"name"`
    Email string `json:"email"`
}

// 2. repository/user_repository.go
type IUserRepository interface {
    Create(ctx context.Context, user models.User) error
    GetByID(ctx context.Context, id int) (*models.User, error)
}

// 3. usecase/user_usecase.go
type IUserUsecase interface {
    CreateUser(ctx context.Context, user models.User) error
    GetUser(ctx context.Context, id int) (*models.User, error)
}

// 4. controller/user_controller.go
type IUserController interface {
    CreateUser(ctx context.Context, user models.User) error
    GetUser(ctx context.Context, id int) (*models.User, error)
}
```

### 3. Testing

#### Unit Testing

Create test files alongside your implementation:

```bash
# Test structure
repository/
├── repository.go
├── repository_test.go
usecase/
├── usecase.go
├── usecase_test.go
controller/
├── controller.go
├── controller_test.go
```

#### Test Example

```go
func TestRepository_Function(t *testing.T) {
    repo := NewRepository()
    ctx := context.Background()
    model := models.Model{ID: 1}
    
    err := repo.Function(ctx, model)
    assert.NoError(t, err)
}
```

### 4. Dependency Injection

Follow the dependency injection pattern established in `main.go`:

```go
// Create instances from bottom to top
repo := repository.NewRepository()
usecase := usecase.NewUsecase(repo)
controller := controller.NewController(usecase)
```

### 5. Error Handling

#### Standard Error Handling

```go
func (r *Repository) Function(ctx context.Context, model models.Model) error {
    if model.ID <= 0 {
        return fmt.Errorf("invalid model ID: %d", model.ID)
    }
    
    // Implementation
    if err := someOperation(); err != nil {
        return fmt.Errorf("operation failed: %w", err)
    }
    
    return nil
}
```

#### Custom Errors

For more sophisticated error handling, consider creating custom error types:

```go
type ValidationError struct {
    Field string
    Value interface{}
}

func (e ValidationError) Error() string {
    return fmt.Sprintf("validation failed for field %s with value %v", e.Field, e.Value)
}
```

### 6. Logging

Use the structured logger provided:

```go
logger.Info("Operation started", "user_id", userID)
logger.Error("Operation failed", "error", err, "user_id", userID)
```

### 7. Configuration

Add new configuration options in `configs/config.go`:

```go
type Config struct {
    Logger   LoggerConfig
    Database DatabaseConfig  // New configuration
}

type DatabaseConfig struct {
    Host     string
    Port     int
    Username string
    Password string
}
```

### 8. Best Practices

- Always pass `context.Context` as the first parameter
- Use interfaces for dependency injection
- Keep business logic in the usecase layer
- Keep data access logic in the repository layer
- Handle errors appropriately at each layer
- Write tests for all public methods
- Follow Go naming conventions
- Use meaningful variable and function names
- Add documentation comments for public interfaces
