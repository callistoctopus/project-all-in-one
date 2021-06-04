/*
*	auther:g
*	date:2019/10/3
 */
package apis

import (
	"demoService/model/common"
	"demoService/model/requestModel"
	"demoService/model/responseModel"
	"demoService/services"
	"errors"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func Register(c *gin.Context) {

	var err error
	var mRegisterReq requestModel.RegisterRequestModel
	var mRegisterRes responseModel.RegisterResponseModel

	code := http.StatusOK
	ret := false

	if c.BindJSON(&mRegisterReq) == nil {
		mRegisterRes, err = service.Register(mRegisterReq)
		if err == nil {
			ret = true
		}
	} else {
		err = errors.New("参数错误")
	}

	if err == nil {
		err = errors.New("")
	}

	c.JSON(code, gin.H{
		"result": ret,
		"data":   mRegisterRes,
		"err":    err.Error(),
	})

	return
}

func Login(c *gin.Context) {

	var err error
	var mLoginReq requestModel.LoginRequestModel
	var mLoginRes string

	code := http.StatusOK
	ret := false

	if c.BindJSON(&mLoginReq) == nil {
		ret, mLoginRes, err = service.Login(mLoginReq)
	} else {
		err = errors.New("参数错误")
	}

	if err == nil {
		err = errors.New("")
	}

	c.JSON(code, gin.H{
		"result": ret,
		"token":  mLoginRes,
		"err":    err.Error(),
	})

	return
}

func GetUsers(c *gin.Context) {

	var err error
	var mGetUsersReq requestModel.GetUsersRequestModel
	var mGetUsersRes []string

	code := http.StatusOK
	ret := false

	if c.BindJSON(&mGetUsersReq) == nil {

		var isValid bool = false
		var claims *claimsModel.JwtClaimsModel
		isValid, claims, err = service.VerifyToken(mGetUsersReq.Token)
		if isValid {
			ret, err = service.VerifyAppid(claims.StandardClaims.Issuer, claims.Appid)
			if ret {
				ret, mGetUsersRes, err = service.GetUsers()
			}
		}
	} else {
		err = errors.New("参数错误")
	}

	if err == nil {
		err = errors.New("")
	}

	c.JSON(code, gin.H{
		"result": ret,
		"data":   mGetUsersRes,
		"err":    err.Error(),
	})

	return
}

func Logout(c *gin.Context) {

	var err error
	var mLogoutReq requestModel.LogoutRequestModel

	code := http.StatusOK
	ret := false

	if c.BindJSON(&mLogoutReq) == nil {
		log.Println("Logout: destory the token : + " + mLogoutReq.Token)
		//add the token to invalid list
		ret = true
	} else {
		err = errors.New("参数错误")
	}

	if err == nil {
		err = errors.New("")
	}

	c.JSON(code, gin.H{
		"result": ret,
		"data":   "",
		"err":    err.Error(),
	})

	return
}
