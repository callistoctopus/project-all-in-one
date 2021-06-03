#通过@Controller或者@RestController处理HTTP请求
#通过@RequestMapping映射HTTP请求

//MyRestController.java

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value="/users")
public class ControllerPrototype {

    @RequestMapping(value="/{user}", method=RequestMethod.GET)
    public User getUser(@PathVariable Long user) {
        return new User("name-test", "sex-test");
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

}

class User {
    private String name;
    private String sex;

    //setter,getter...
}