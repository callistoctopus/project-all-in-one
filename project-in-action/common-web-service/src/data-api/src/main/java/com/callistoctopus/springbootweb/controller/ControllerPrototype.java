package com.callistoctopus.springbootweb.controller;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;
import java.util.UUID;

import com.alibaba.fastjson.JSONObject;
// import com.callistoctopus.springbootweb.dao.HeroDao;
import com.callistoctopus.springbootweb.model.po.Hero;
import com.fasterxml.jackson.databind.util.JSONPObject;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

// import io.swagger.annotations.Api;

// @Api(value = "desc of class")
@RestController
@RequestMapping(value="/api")
public class ControllerPrototype {

    // private List<Pic> picList = new ArrayList<Pic>();
    Stack<Pic> picList = new Stack<Pic>();

    // @Autowired
    // HeroDao heroDao;

    synchronized void push(Pic pic){
        picList.push(pic);
    }

    synchronized Pic pop(){
        return picList.pop();
    }

    // @RequestMapping(value="/heroes", method=RequestMethod.GET)
    // List<Hero> getCustomers() throws Exception {
    //     List<Hero> list = new ArrayList<>();
    //     Iterable<Hero> geted = heroDao.findAll();
    //     geted.forEach(single -> {list.add(single);});
    //     return list;
    // }

    @RequestMapping(value="/outer_system/getDataListOfElectronicReport", method=RequestMethod.POST)
    public JSONObject getUser() {

        String resStr = "{\"success\":true,\"code\":\"200\",\"timestamp\":1662717276517,\"message\":{\"messageNo\":\"MSG-00001\",\"messageInfo\":\"处理正常。\",\"detaileInfo\":\"\"},\"result\":{\"pageNo\":1,\"pageSize\":2,\"total\":2,\"isFirstPage\":true,\"isLastPage\":true,\"pages\":1,\"dataList\":[{\"shipOwner\":\"徐伟\",\"updateDatetime\":\"2022-09-1510:10:00\",\"applyPersonTel\":\"13456822179\",\"shipName\":\"浙安吉货1361\",\"applyPerson\":\"徐伟\",\"deleteFlag\":\"0\",\"createDatetime\":\"2022-09-1510:10:00\",\"uid\":\"990000001\",\"boundType\":\"进港\",\"registPort\":\"湖州\",\"berth\":\"湖州市菱城建设工程有限公司\",\"reportDatetime\":\"2022-05-0115:29:00\",\"reportNo\":\"CBBG202204941788\"},{\"shipOwner\":\"王小明\",\"updateDatetime\":\"2022-09-0706:14:00\",\"applyPersonTel\":\"13967299156\",\"shipName\":\"浙湖州货2955\",\"applyPerson\":\"朱兰海\",\"deleteFlag\":\"0\",\"createDatetime\":\"2022-09-0706:14:00\",\"uid\":\"990000002\",\"boundType\":\"出港\",\"registPort\":\"湖州\",\"berth\":\"湖州鹿山坞建材科技有限公司码头\",\"reportDatetime\":\"2022-05-0115:22:00\",\"reportNo\":\"CBBG202204941480\"}]}}";
        // String picData = pic.getData();
        // picData = picData.substring(30);
        // try {
        //     picData = URLDecoder.decode(picData,"UTF-8");
        // } catch (UnsupportedEncodingException e) {
        //     // TODO Auto-generated catch block
        //     e.printStackTrace();
        // }

        // String photoName = String.valueOf(UUID.randomUUID()) + ".png";
        // String imgUrl = "/var/work/project/data/" + photoName;
        // boolean res= GenerateImage(picData,imgUrl);
        // push(pic);

        return JSONObject.parseObject(resStr);
    }

    @RequestMapping(value="/download", method=RequestMethod.POST)
    public Pic download() {
        // picData = picData.substring(30);
        // try {
        //     picData = URLDecoder.decode(picData,"UTF-8");
        // } catch (UnsupportedEncodingException e) {
        //     // TODO Auto-generated catch block
        //     e.printStackTrace();
        // }

        // String photoName = String.valueOf(UUID.randomUUID()) + ".png";
        // String imgUrl = "/var/work/project/data/" + photoName;
        // boolean res= GenerateImage(picData,imgUrl);

        return pop();
    }

    @RequestMapping(value="/{user}/customers", method=RequestMethod.GET)
    List<User> getUserCustomers(@PathVariable Long user) throws Exception {
        throw new Exception();
        // return new ArrayList<>();
    }

    @RequestMapping(value="/{user}", method=RequestMethod.DELETE)
    public User deleteUser(@PathVariable Long user) {
        return new User("name-test", "sex-test");
    }

    public static  boolean  GenerateImage(String imgStr,String url){
 
        if (imgStr == null) return false;
        // BASE64Decoder decoder = new BASE64Decoder();
        
        try
        {
            //Base64解码
            // byte[] b = decoder.decodeBuffer(imgStr);
            byte[] b = Base64.decodeBase64(imgStr);
            for(int i=0;i<b.length;++i)
            {
                if(b[i]<0)
                {//调整异常数据
                    b[i]+=256;
                }
            }
            //生成jpeg图片
            OutputStream out = new FileOutputStream(url);
            out.write(b);
            out.flush();
            out.close();
            return true;
        }
        catch (Exception e)
        {
            return false;
        }
    }

}

class User {
    
    private String name;
    public User(String name, String sex) {
        this.name = name;
        this.sex = sex;
    }
    private String sex;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    //setter,getter...
}

class Pic {
    
    private String data;

    public Pic() {
    }

    public String getData() {
        return data;
    }

    public Pic(String data) {
        this.data = data;
    }

    public void setData(String data) {
        this.data = data;
    }

    //setter,getter...
}
