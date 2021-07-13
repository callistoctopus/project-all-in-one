/*
*	auther:g
*	date:2019/10/3
 */
package service

import (
	"goweb/model"
	"goweb/model/common"
	"goweb/repository"
	"errors"
	"time"

	"github.com/dgrijalva/jwt-go"
)

const (
	demoTokenSignKey string = "1QaZ@wSx"
)

func generateToken(user model.UserModel) (string, error) {
	mySigningKey := []byte(demoTokenSignKey)

	// Create the Claims
	claims := claimsModel.JwtClaimsModel{
		user.Appid,
		jwt.StandardClaims{
			ExpiresAt: int64(time.Now().Unix() + 25), //60s
			Issuer:    user.Username,
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	ss, err := token.SignedString(mySigningKey)

	return ss, err
}

func VerifyToken(sToken string) (bool, *claimsModel.JwtClaimsModel, error) {
	result := false
	token, err := jwt.ParseWithClaims(sToken, &claimsModel.JwtClaimsModel{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(demoTokenSignKey), nil
	})

	claims, ok := token.Claims.(*claimsModel.JwtClaimsModel)

	if (err == nil) && ok && token.Valid {
		result = true
	} else {
		err = errors.New("无效令牌")
	}

	return result, claims, err
}

func VerifyAppid(lander string, appid string) (bool, error) {
	ret, retAppid, err := userRepository.FindAppidByUsername(lander)

	if ret && (retAppid == appid) {
		err = nil
	} else {
		ret = false
		err = errors.New("非法设备")
	}

	return ret, err
}
