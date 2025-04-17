package handler

import (
	"go-gin-gorm-example/model"
	"net/http"

	"github.com/gin-gonic/gin"
)

// Find All Users godoc
// @Summary Find all users
// @Description Find all users
// @Tags users
// @Accept json
// @Produce json
// @Success 200 {array} model.User
// @Router /users [get]
func FindAllUsersHandler(c *gin.Context) {
	var users []model.User
	result := model.DB.Find(&users)
	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"message": "Find all users failed",
		})
		return
	}
	c.JSON(http.StatusOK, users)
}

// Create User godoc
// @Summary Create a new user
// @Description Create a new user
// @Tags users
// @Accept json
// @Produce json
// @Success 200 {object} model.User
// @Router /users [post]
func CreateUserHandler(c *gin.Context) {
	user := model.User{
		Username: "Tim",
		Password: "123456",
	}
	result := model.DB.Create(&user)
	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"message": "Create user failed",
		})
		return
	}
	c.JSON(http.StatusOK, user)
}
