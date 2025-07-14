# API Reference

## Controller Interface

### IController

Main controller interface for handling business operations.

```go
type IController interface {
    Function(ctx context.Context, model models.Model) error
}
```

#### Methods

##### Function
Executes the main business operation.

**Parameters:**
- `ctx context.Context`: Request context for timeout and cancellation
- `model models.Model`: Input data model

**Returns:**
- `error`: Error if operation fails, nil on success

**Example:**
```go
ctx := context.Background()
model := models.Model{ID: 1}
err := controller.Function(ctx, model)
if err != nil {
    // Handle error
}
```

## Usecase Interface

### IUsecase

Business logic interface.

```go
type IUsecase interface {
    Function(ctx context.Context, model models.Model) error
}
```

## Repository Interface

### IRepository

Data access interface.

```go
type IRepository interface {
    Function(ctx context.Context, model models.Model) error
}
```

## Models

### Model

Basic data structure for the application.

```go
type Model struct {
    ID int
}
```

**Fields:**
- `ID int`: Unique identifier

## Error Handling

All methods return standard Go errors. Handle errors appropriately:

```go
if err != nil {
    log.Printf("Operation failed: %v", err)
    // Handle error appropriately
}
```

## Context Usage

All methods accept `context.Context` as the first parameter:

- Use `context.Background()` for background operations
- Use `context.WithTimeout()` for operations with timeouts
- Use `context.WithCancel()` for cancellable operations

**Example with timeout:**
```go
ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
defer cancel()

err := controller.Function(ctx, model)
```
