//MyService.java

import org.springframework.messaging.rsocket.RSocketRequester;
import org.springframework.stereotype.Service;

import reactor.core.publisher.Mono;

@Service
public class MyService {

    private final Mono<RSocketRequester> rsocketRequester;

    public MyService(RSocketRequester.Builder rsocketRequesterBuilder) {
        this.rsocketRequester = rsocketRequesterBuilder
                .connectTcp("example.org", 9898).cache();

        someRSocketCall("");
    }

    public Mono<User> someRSocketCall(String name) {
        return this.rsocketRequester.flatMap(req ->
                    req.route("user").data(name).retrieveMono(User.class));
    }

}

class User {
    private String name;

    //setter,getter...
}