// Package controller defines the interface and implementation for the controller layer.
package controller

import (
	"context"

	"github.com/i7s7-ymp/go-layered/models"
	"github.com/i7s7-ymp/go-layered/usecase"
)

type IController interface {
	Function(ctx context.Context, model models.Model) error
}

type Controller struct {
	uc usecase.IUsecase
}

func NewController(uc usecase.IUsecase) IController {
	return &Controller{
		uc: uc,
	}
}

func (c *Controller) Function(ctx context.Context, model models.Model) error {
	// Call the usecase function
	return c.uc.Function(ctx, model)
}
