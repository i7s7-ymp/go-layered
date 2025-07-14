# Architecture Overview

## Layered Architecture Pattern

This project follows the Clean Architecture principles with a layered approach:

```
┌─────────────────┐
│   Controller    │  ← HTTP handlers, request/response
├─────────────────┤
│    Usecase      │  ← Business logic, application services
├─────────────────┤
│   Repository    │  ← Data access, persistence layer
├─────────────────┤
│     Models      │  ← Domain entities, data structures
└─────────────────┘
```

## Layer Responsibilities

### Controller Layer
- Handles HTTP requests and responses
- Input validation and sanitization
- Authentication and authorization
- Request routing

### Usecase Layer
- Contains business logic
- Coordinates between different repositories
- Implements application services
- Handles business rules and validations

### Repository Layer
- Data access and persistence
- Database operations
- External API integrations
- Data mapping and transformation

### Models Layer
- Domain entities
- Data transfer objects (DTOs)
- Value objects
- Data structures

## Context Flow

Each layer accepts `context.Context` as the first parameter to enable:
- Request timeout handling
- Cancellation propagation
- Request-scoped values (user ID, trace ID, etc.)
- Graceful shutdown

## Dependencies

Dependencies flow inward (dependency inversion):
- Controller depends on Usecase interface
- Usecase depends on Repository interface
- Repository implements concrete data access
