# Setup Guide

## Prerequisites

- Go 1.24.5 or later
- Git
- Docker (optional, for containerized development)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/i7s7-ymp/go-layered.git
cd go-layered
```

2. Navigate to the Go project directory:
```bash
cd go
```

3. Install dependencies:
```bash
go mod tidy
```

4. Build the application:
```bash
go build ./cmd/main.go
```

5. Run the application:
```bash
./main
```

## Development Environment

### Using Dev Container (Recommended)

This project includes a Dev Container configuration for consistent development environments:

1. Open the project in VS Code
2. Install the "Dev Containers" extension
3. Press `Ctrl+Shift+P` and select "Dev Containers: Reopen in Container"

The dev container includes:
- Go 1.24.5
- Git
- Docker CLI
- Common development tools

### Local Development

If you prefer local development:

1. Install Go 1.24.5+
2. Set up your Go workspace
3. Install any additional tools as needed

## Configuration

The application uses a configuration system located in `configs/config.go`:

- **Logger**: Configurable log levels (Info, Debug, Error, etc.)
- **Environment**: Development, staging, production settings

## Project Structure

```
go/
├── cmd/
│   └── main.go          # Application entry point
├── configs/
│   └── config.go        # Configuration management
├── controller/
│   └── controller.go    # HTTP handlers
├── usecase/
│   └── usecase.go       # Business logic
├── repository/
│   └── repository.go    # Data access
├── models/
│   └── models.go        # Data structures
├── logger/
│   └── logger.go        # Logging utilities
├── utils/               # Utility functions
└── validator/           # Input validation
```
