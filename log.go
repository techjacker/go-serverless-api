package main

// Logger is the logger interface
type Logger interface {
	Print(v ...interface{})
	Printf(format string, v ...interface{})
}
