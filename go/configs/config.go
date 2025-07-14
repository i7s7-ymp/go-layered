// Package configs provides configuration management for the application.
package configs

import "log/slog"

type Config struct {
	Logger LoggerConfig
}

type LoggerConfig struct {
	Level slog.Level
}

func NewConfig() *Config {
	return &Config{
		Logger: LoggerConfig{
			Level: slog.LevelInfo, // Default log level
		},
	}
}
