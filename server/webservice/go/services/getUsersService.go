/*
*	auther:g
*	date:2019/10/3
 */
package service

import (
	"goweb/repository"
)

func GetUsers() (bool, []string, error) {
	result, mUsers, err := userRepository.GetUsers()
	return result, mUsers, err
}
