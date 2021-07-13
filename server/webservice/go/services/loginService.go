/*
*	auther:g
*	date:2019/10/3
 */
package service

import (
	"goweb/model/requestModel"
	"goweb/repository"
	"errors"
)

func Login(req requestModel.LoginRequestModel) (bool, string, error) {
	ret, user, err := userRepository.FindUserByUsername(req.Username)
	token := ""

	if ret {
		if user.Password == req.Password {
			if user.Appid == req.Appid {
				// token, err = generateToken(user)
			} else if req.Appid != "" {
				user.Appid = req.Appid
				ret, err = userRepository.UpdateAppidByUsername(user.Username, user.Appid)
				if ret && err == nil {
					// token, err = generateToken(user)
				}
			} else {
				err = errors.New("无效设备")
			}

			if err != nil {
				ret = false
			}
		} else {
			ret = false
			err = errors.New("密码错误")
		}

	} else if err == nil {
		err = errors.New("登录失败")
	}

	return ret, token, err
}
