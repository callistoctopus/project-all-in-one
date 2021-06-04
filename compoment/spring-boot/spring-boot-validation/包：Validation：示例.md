//ControllerPrototype.java

import javax.validation.constraints.Size;

import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value="/users")
@Validated
public class ControllerPrototype {

    @RequestMapping(value="/{user}", method=RequestMethod.GET)
    public User getUser(@Size(min=2, max=3) @PathVariable Long user) {
        return new User("name-test", "sex-test");
    }

}

class User {
    private String name;
    private String sex;

    //setter getter...
}