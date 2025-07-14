// Package main initializes the application, sets up dependencies, and runs the controller.
// It serves as the entry point for the application.
package main

import (
	"context"

	"github.com/i7s7-ymp/go-layered/configs"
	"github.com/i7s7-ymp/go-layered/controller"
	"github.com/i7s7-ymp/go-layered/logger"
	"github.com/i7s7-ymp/go-layered/models"
	"github.com/i7s7-ymp/go-layered/repository"
	"github.com/i7s7-ymp/go-layered/usecase"
)

func main() {
	// Create a background context for the application
	ctx := context.Background()

	// Initialize configuration, logging, or other necessary components here
	cfg := configs.NewConfig()
	logger := logger.NewLogger(cfg)

	// Dependency Injection
	rs := repository.NewRepository()
	uc := usecase.NewUsecase(rs)
	ctl := controller.NewController(uc)

	// Example usage of the controller
	err := ctl.Function(ctx, models.Model{
		ID: 1,
	})
	if err != nil {
		logger.Error("Failed to execute usecase function", "error", err)
	}
}
