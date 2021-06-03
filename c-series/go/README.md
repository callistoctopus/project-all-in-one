# xldemo
## 简介
  本项目采用gin框架，结合jwt及bbolt嵌入式数据库，实现了包含token及appid验证的简单api接口。<br>

## 运行环境
云平台： aws<br>
访问地址：http://18.222.130.42:8080/<api名称><br>
操作系统：Windows Server 2019 Datacenter<br>
运行内存：1Gb<br>
CPU:英特尔 E8

## 开发环境
操作系统：macOS 10.12.2<br>
运行内存：8Gb<br>
开发语言：go<br>
IDE：LiteIDE<br>

## 软件构成
web框架："github.com/gin-gonic/gin"<br>
数据库："go.etcd.io/bbolt"<br>
jwt："github.com/dgrijalva/jwt-go"<br>

## API简介
### 注册api：
名称：register<br>
访问方式：POST<br>
功能：提供用户注册功能<br>
说明:该API注册用户信息并绑定设备ID<br>
参数：<br>
`user`:用户名<br>
`password`:密码<br>
`appid`:设备ID[可选]<br>
返回值：<br>
`result`:调用结果<br>
`data`:调用成功返回的数据（用户名、密码、设备ID）<br>
`err`:调用失败返回的数据<br>
备注：1.如果参数中不含appid，该API将在返回数据中携带自动生成的appid。<br>
2.用户名要求8~16位，用户密码要求8~32位<br>

### 登陆api：
名称：login<br>
访问方式：POST<br>
功能：提供用户登陆功能<br>
说明:该API将验证用户信息，更新绑定设备ID并生成令牌<br>
参数：<br>
`user`:用户名<br>
`password`:密码<br>
`appid`:设备ID<br>
返回值：<br>
`result`:调用结果<br>
`token`:调用成功返回的数据<br>
`err`:调用失败返回的数据<br>
备注：令牌有效期为25秒，一个用户只允许一台设备登录<br>

### 业务功能api：
名称：getUsers<br>
访问方式：POST<br>
功能：提供公共功能<br>
说明:该API将验证令牌有效性及设备ID是否合法，然后返回请求的数据<br>
参数：<br>
`token`:令牌<br>
返回值：<br>
`result`:调用结果<br>
`data`:调用成功返回的数据（用户名列表）<br>
`err`:调用失败返回的数据<br>

### 注销api<功能暂未实现>：
名称：logout<br>
访问方式：POST<br>
功能：提供注销登陆功能<br>
说明:该API将验证令牌有效性及设备ID是否合法，然后销毁该令牌[加入令牌黑名单]。<br>
参数：<br>
`token`:令牌<br>
返回值：<br>
`result`:调用结果<br>
`data`:调用成功返回的数据<br>
`err`:调用失败返回的数据<br>

### 示例
测试工具：Postman<br>
访问接口：http://18.222.130.42:8080/register<br>
参数：<br>
{<br>
	"user":"12345678",<br>
	"password":"12345678"<br>
}<br>
返回值：<br>
{<br>
    "data": {<br>
        "user": "12345678",<br>
        "password": "12345678",<br>
        "appid": "c936362486b95009816d5621afea029a"<br>
    },<br>
    "err": "",<br>
    "result": true<br>
}<br>


## 参考资料：
Gin框架中文文档 https://www.jianshu.com/p/98965b3ff638/<br>
Go语言入门教程  http://c.biancheng.net/golang/<br>
gin基于JWT实现token令牌功能 https://www.jianshu.com/p/1f9915818992<br>
