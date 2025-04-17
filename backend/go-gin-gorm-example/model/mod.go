package model

import (
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var dsn string = "host=127.0.0.1 user=root password=example dbname=test port=5432 sslmode=disable TimeZone=Asia/Shanghai"

var DB *gorm.DB

func init() {
	db_, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}
	DB = db_
	err = DB.AutoMigrate(&User{})
	if err != nil {
		panic("failed to migrate table")
	}

}
