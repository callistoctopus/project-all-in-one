/*
*	auther:g
*	date:2019/10/3
 */
package userRepository

import (
	"demoService/model"
	"demoService/util"
	"encoding/json"
	"errors"
	"log"

	"go.etcd.io/bbolt"
)

func IsUserExist(username string) (bool, error) {

	result := false

	db, err := bbolt.Open("demo.db", 0600, nil)

	if err != nil {
		return result, err
	}

	defer db.Close()

	err = db.View(func(tx *bbolt.Tx) error {

		bucket := tx.Bucket([]byte("user"))
		if bucket == nil {
			return nil
		}

		c := bucket.Cursor()
		for k, v := c.First(); k != nil; k, v = c.Next() {
			userTemp := parseUser(v)
			log.Println(userTemp.Username)
			if username == userTemp.Username {
				result = true
				break
			}
		}

		return nil
	})

	return result, err
}

func RegisterUser(mUser model.UserModel) (bool, error) {
	result := false

	db, err := bbolt.Open("demo.db", 0600, nil)

	if err != nil {
		log.Fatal(err)
		return result, err
	}

	defer db.Close()

	err = db.Update(func(tx *bbolt.Tx) error {

		bucket, err := tx.CreateBucketIfNotExists([]byte("user"))

		if err != nil {
			return err
		}

		uid := util2020.UniqueId()

		user := model.UserModel{
			mUser.Username, mUser.Password, mUser.Appid,
		}

		var byteArray []byte
		byteArray, err = createUser(user)

		err = bucket.Put([]byte(uid), byteArray)
		result = true

		return err

	})

	return result, err
}

func FindUserByUsername(name string) (bool, model.UserModel, error) {
	result := false
	var user model.UserModel

	db, err := bbolt.Open("demo.db", 0600, nil)

	if err != nil {
		return result, user, err
	}

	defer db.Close()

	err = db.View(func(tx *bbolt.Tx) error {

		bucket := tx.Bucket([]byte("user"))
		if bucket == nil {
			return nil
		}

		c := bucket.Cursor()
		for k, v := c.First(); k != nil; k, v = c.Next() {
			userTemp := parseUser(v)
			if name == userTemp.Username {
				result = true
				user.Username = userTemp.Username
				user.Password = userTemp.Password
				user.Appid = userTemp.Appid
				break
			}
		}

		return nil
	})

	if result != true {
		err = errors.New("该账号不存在")
	}

	return result, user, err
}

func GetUsers() (bool, []string, error) {

	ret := false
	result := []string{}

	db, err := bbolt.Open("demo.db", 0600, nil)

	if err != nil {
		return ret, result, err
	}

	defer db.Close()

	err = db.View(func(tx *bbolt.Tx) error {

		bucket := tx.Bucket([]byte("user"))
		if bucket == nil {
			return nil
		}

		c := bucket.Cursor()
		for k, v := c.First(); k != nil; k, v = c.Next() {
			userTemp := parseUser(v)
			result = append(result, userTemp.Username)
		}

		return nil
	})

	if err == nil {
		ret = true
	}

	return ret, result, err
}

func FindAppidByUsername(username string) (bool, string, error) {

	result := false
	appid := ""

	db, err := bbolt.Open("demo.db", 0600, nil)
	if err != nil {
		return result, appid, err
	}

	defer db.Close()

	err = db.View(func(tx *bbolt.Tx) error {

		bucket := tx.Bucket([]byte("user"))
		if bucket == nil {
			return nil
		}

		c := bucket.Cursor()
		for k, v := c.First(); k != nil; k, v = c.Next() {
			userTemp := parseUser(v)
			if username == userTemp.Username {
				appid = userTemp.Appid
				break
			}
		}

		return err
	})

	if appid != "" {
		result = true
	}

	return result, appid, err
}

func UpdateAppidByUsername(username string, appid string) (bool, error) {

	result := false

	db, err := bbolt.Open("demo.db", 0600, nil)
	if err != nil {
		return result, err
	}

	defer db.Close()

	err = db.Update(func(tx *bbolt.Tx) error {

		bucket := tx.Bucket([]byte("user"))
		if bucket == nil {
			return nil
		}

		c := bucket.Cursor()
		for k, v := c.First(); k != nil; k, v = c.Next() {
			userTemp := parseUser(v)
			if username == userTemp.Username {

				user := model.UserModel{
					userTemp.Username, userTemp.Password, appid,
				}

				var byteArray []byte
				byteArray, err = createUser(user)

				err = bucket.Delete(k)
				log.Println(err)
				err = bucket.Put(k, byteArray)
				break
			}
		}

		return err
	})

	if appid != "" {
		result = true
	}

	return result, err
}

func parseUser(userStr []byte) model.UserModel {
	var mUserModel model.UserModel

	json.Unmarshal(userStr, &mUserModel)

	return mUserModel
}

func createUser(userStr model.UserModel) ([]byte, error) {
	buf, err := json.Marshal(userStr)
	return buf, err
}
