package com.callistoctopus.springboot;

import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value="/bingo")
public class TestController {

    @Value("${appname:AppName(default)}")
    private String appname;

    @Value("${apptype:AppType(default)}")
    private String apptype;

    @RequestMapping(value="", method=RequestMethod.GET)
    public String getMetaInfo() {
        HashMap<String, String> infoMap = new HashMap<>();

        String ipaddr = "unknow";

        try {
			ipaddr = Inet4Address.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}

        infoMap.put("server ip", ipaddr);
        infoMap.put("app name", appname);
        infoMap.put("app type", apptype);

        return infoMap.toString();
    }

    @RequestMapping(value="/{user}/customers", method=RequestMethod.GET)
    List<User> getUserCustomers(@PathVariable Long user) throws Exception {
        throw new Exception();
        // return new ArrayList<>();
    }

    @RequestMapping(value="/{user}", method=RequestMethod.GET)
    public User deleteUser(@PathVariable Long user) {
        return new User("name-test", "sex-test");
    }

}

class User {
    private String name;
    private String sex;
    /**
     * @param name
     * @param sex
     */
    public User(String name, String sex) {
        this.name = name;
        this.sex = sex;
    }
    /**
     * @return the name
     */
    public String getName() {
        return name;
    }
    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * @return the sex
     */
    public String getSex() {
        return sex;
    }
    /**
     * @param sex the sex to set
     */
    public void setSex(String sex) {
        this.sex = sex;
    }

    //setter,getter...
}
