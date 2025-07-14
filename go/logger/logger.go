// Package logger provides a logger that outputs JSON formatted logs to stdout.
package logger

import (
	"log/slog"
	"os"

	"github.com/i7s7-ymp/go-layered/configs"
)

func NewLogger(cfg *configs.Config) *slog.Logger {
	return slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
		Level: cfg.Logger.Level,
	}))
}
