package handler

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// IndexHandler handles the root route
// @Summary Index route
// @Description Index route
// @Tags index
// @Accept json
// @Produce json
// @Success 200 {object} map[string]string
// @Router / [get]
func IndexHandler(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": "Hello World",
	})
}
