package main

import (
	"context"
	"go-gin-gorm-example/handler"
	"log"
	"net/http"
	"os"
	"os/signal"
	"time"

	_ "go-gin-gorm-example/docs"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

// @title Go Gin Gorm Example API
// @version 1.0
// @description This is a sample server for Go Gin Gorm Example API.
// @termsOfService http://swagger.io/terms/
// @contact.name API Support
// @contact.url API Support URL
// @license.name Apache 2.0
// @license.url https://xxx
// @host localhost:3000
// @BasePath /
func main() {
	r := gin.Default()

	r.Use(cors.Default())

	r.Static("/static", "./public")

	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	r.GET("/", handler.IndexHandler)
	r.POST("/users", handler.CreateUserHandler)
	r.GET("/users", handler.FindAllUsersHandler)

	srv := &http.Server{
		Addr:    ":3000",
		Handler: r,
	}

	go func() {
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("listen: %s\n", err)
		}
	}()

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt)
	<-quit

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := srv.Shutdown(ctx); err != nil {
		log.Fatal("Server shutdown:", err)
	}
	log.Println("Server exiting")
}
