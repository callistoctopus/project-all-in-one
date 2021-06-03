/*
*	auther:g
*	date:2019/10/3
 */
package requestModel

type LoginRequestModel struct {
	Username string `json:"user"`
	Password string `json:"password"`
	Appid    string `json:"appid"`
}
