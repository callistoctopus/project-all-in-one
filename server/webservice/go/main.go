/*
*	auther:g
*	date:2019/10/3
 */
package main

import (
	"goweb/apis"

	"github.com/gin-gonic/gin"
	"go.etcd.io/bbolt"
)

var r *gin.Engine

func main() {

	if ret := webServiceInit(); ret == true {
		WebServiceStart()
	}
}

func webServiceInit() bool {

	ret := true

	db, err := bbolt.Open("demo.db", 0666, nil)

	if err != nil {
		ret = false
	}
	defer db.Close()

	if ret {
		r = gin.Default()
		requestMapInit()
	}

	return ret
}

func requestMapInit() {
	r.POST("/register", apis.Register)
	r.POST("/login", apis.Login)
	r.POST("/getUsers", apis.GetUsers)
	r.POST("/logout", apis.Logout)
}

func WebServiceStart() {
	r.Run(":8080")
}
