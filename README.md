# Go Layered Architecture Template

[![Go Version](https://img.shields.io/badge/Go-1.24.5-blue.svg)](https://golang.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Template](https://img.shields.io/badge/template-go--layered-green.svg)](https://github.com/i7s7-ymp/go-layered)

A clean, maintainable Go project template implementing layered architecture following Clean Architecture principles.

## 🚀 Quick Start

### Using this template

1. Click "Use this template" button on GitHub
2. Clone your new repository
3. Replace project name and module path in `go/go.mod`
4. Start building your application!

### Local Development

```bash
# Clone the repository
git clone https://github.com/i7s7-ymp/go-layered.git
cd go-layered

# Navigate to Go project
cd go

# Install dependencies
go mod tidy

# Run the application
go run cmd/main.go
```

## 📁 Project Structure

```
go-layered/
├── .devcontainer/          # Development container configuration
├── .github/               # GitHub workflows and templates
├── docs/                  # Project documentation
│   ├── README.md         # Documentation overview
│   ├── architecture.md   # Architecture details
│   ├── setup.md         # Setup and installation guide
│   ├── development.md   # Development guidelines
│   └── api.md           # API documentation
├── go/                   # Go project root
│   ├── cmd/             # Application entrypoints
│   ├── controller/      # HTTP handlers and routing
│   ├── usecase/        # Business logic layer
│   ├── repository/     # Data access layer
│   ├── models/         # Domain entities and DTOs
│   ├── configs/        # Configuration files
│   ├── logger/         # Logging utilities
│   ├── go.mod          # Go module definition
│   └── go.sum          # Go module dependencies
├── LICENSE              # MIT License
└── README.md           # This file
```

## 🏗️ Architecture

This template implements a **4-layer architecture**:

```
┌─────────────────┐
│   Controller    │  ← HTTP handlers, request validation, response formatting
├─────────────────┤
│    Usecase      │  ← Business logic, orchestration, application services
├─────────────────┤
│   Repository    │  ← Data access, database operations, external APIs
├─────────────────┤
│     Models      │  ← Domain entities, DTOs, data structures
└─────────────────┘
```

### Key Principles

- **Dependency Inversion**: Higher layers depend on interfaces, not concrete implementations
- **Single Responsibility**: Each layer has a clear, focused purpose
- **Testability**: Clean separation enables easy unit testing
- **Maintainability**: Organized structure scales with project complexity

## 📚 Documentation

- **[📖 Documentation Overview](docs/README.md)** - Start here for comprehensive guides
- **[🏛️ Architecture Guide](docs/architecture.md)** - Detailed architecture explanation
- **[⚙️ Setup Guide](docs/setup.md)** - Installation and configuration
- **[💻 Development Guide](docs/development.md)** - Development workflow and best practices
- **[🔌 API Reference](docs/api.md)** - API endpoints and usage examples

## 🛠️ Features

- ✅ **Clean Layered Architecture** - Well-organized, maintainable codebase
- ✅ **Development Container** - Ready-to-use dev environment with VS Code
- ✅ **Go Module Support** - Modern Go dependency management
- ✅ **Logging Framework** - Structured logging setup
- ✅ **Configuration Management** - Environment-based config handling
- ✅ **Code Quality Tools** - golangci-lint and staticcheck integration
- ✅ **Comprehensive Documentation** - Detailed guides and examples

## 🔧 Development Environment

### Using Dev Container (Recommended)

This project includes a complete development container configuration:

1. Install [Docker](https://www.docker.com/get-started) and [VS Code](https://code.visualstudio.com/)
2. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Open the project in VS Code
4. Click "Reopen in Container" when prompted

The dev container includes:
- Go 1.24.5
- All necessary development tools
- Pre-configured VS Code settings

### Manual Setup

See the [Setup Guide](docs/setup.md) for detailed manual installation instructions.

## 🧪 Testing

```bash
# Run all tests
go test ./...

# Run tests with coverage
go test -cover ./...

# Run tests with verbose output
go test -v ./...
```

## 📝 Code Quality

```bash
# Lint code
golangci-lint run

# Static analysis
staticcheck ./...

# Format code
go fmt ./...
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

See [Development Guide](docs/development.md) for detailed contributing guidelines.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

- 📚 Check the [documentation](docs/)
- 🐛 Report issues on [GitHub Issues](https://github.com/i7s7-ymp/go-layered/issues)
- 💡 Suggest features via [GitHub Discussions](https://github.com/i7s7-ymp/go-layered/discussions)

---

⭐ **Star this repository if you find it helpful!**


