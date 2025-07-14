// Package usecase defines the interface and implementation for the use case layer.
package usecase

import (
	"context"

	"github.com/i7s7-ymp/go-layered/models"
	"github.com/i7s7-ymp/go-layered/repository"
)

type IUsecase interface {
	Function(ctx context.Context, model models.Model) error
}

type Usecase struct {
	ir repository.IRepository
}

func NewUsecase(ir repository.IRepository) IUsecase {
	return &Usecase{
		ir: ir,
	}
}

func (u *Usecase) Function(ctx context.Context, model models.Model) error {
	return u.ir.Function(ctx, model)
}
