/*
*	auther:g
*	date:2019/10/3
 */
package service

import (
	"demoService/model"
	"demoService/model/requestModel"
	"demoService/model/responseModel"
	"demoService/repository"
	"demoService/util"
	"errors"
	"unicode/utf8"
)

func Register(req requestModel.RegisterRequestModel) (responseModel.RegisterResponseModel, error) {
	var mRet responseModel.RegisterResponseModel
	var err error

	if bRet := checkParameter(req.Username, req.Password); bRet {
		if appidLen := utf8.RuneCountInString(req.Appid); appidLen == 0 {
			req.Appid = createAppid()
		}

		if bRet, err = userRepository.IsUserExist(req.Username); bRet == false {
			user := model.UserModel{req.Username, req.Password, req.Appid}
			if bRet, err = userRepository.RegisterUser(user); (err == nil) && (bRet == true) {
				mRet.Username = req.Username
				mRet.Password = req.Password
				mRet.Appid = req.Appid
			}
		} else if err == nil {
			err = errors.New("用户已存在")
		}
	}

	return mRet, err
}

func checkParameter(username string, password string) bool {
	ret := false

	usernameLen := utf8.RuneCountInString(username)
	passwordLen := utf8.RuneCountInString(password)
	if (usernameLen >= 8) &&
		(usernameLen <= 16) &&
		(passwordLen >= 8) &&
		(passwordLen <= 32) {
		ret = true

	}

	return ret
}

func createAppid() string {
	return util2020.UniqueId()
}
