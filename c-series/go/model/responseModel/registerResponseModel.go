/*
*	auther:g
*	date:2019/10/3
 */
package responseModel

type RegisterResponseModel struct {
	Username string `json:"user"`
	Password string `json:"password"`
	Appid    string `json:"appid"`
}
