//MyService.java

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class MyService {

    private final RestTemplate restTemplate;

    public MyService(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
        String userid = "1";
        String o = this.restTemplate.getForObject("http://localhost:8080/users/{userid}", String.class, userid);
        System.out.println("Call http://localhost:8080/users/{userid} : " + o);
    }

}