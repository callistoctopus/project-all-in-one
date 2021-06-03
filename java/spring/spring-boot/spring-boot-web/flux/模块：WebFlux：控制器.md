#基于注解的控制器和基于函数的控制器

#基于注解的控制器

//MyRestController.java

import com.callistoptopus.springbootwebflux.model.User;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/users")
public class MyRestController {

    @GetMapping("/{user}")
    public Mono<User> getUser(@PathVariable Long user) {
        return Mono.just(new User("test-name","test-sex"));
    }

    @GetMapping("/{user}/customers")
    public Flux<User> getUserCustomers(@PathVariable Long user) {
        return Flux.just(new User("test-name","test-sex"));
    }

    @DeleteMapping("/{user}")
    public Mono<User> deleteUser(@PathVariable Long user) {
        return Mono.just(new User("test-name","test-sex"));
    }

}

class User {
    private String name;
    private String sex;

    //setter,getter...
}

#基于函数的控制器

//UserHandler.java
import com.callistoptopus.springbootwebflux.model.User;

import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;

import reactor.core.publisher.Mono;

@Component
public class UserHandler {

    public Mono<User> getUser(ServerRequest request) {
        return Mono.just(new User("test-name", "test-sex")).checkpoint();
    }

    public Mono<User> getUserCustomers(ServerRequest request) {
        return Mono.just(new User("test-name", "test-sex"));
    }

    public Mono<User> deleteUser(ServerRequest request) {
        return Mono.just(new User("test-name", "test-sex"));
    }
}


//RoutingConfiguration.java
import com.callistoptopus.springbootwebflux.controller.UserHandler;
import com.callistoptopus.springbootwebflux.model.User;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.server.RouterFunction;

import static org.springframework.http.MediaType.*;
import static org.springframework.web.reactive.function.server.RequestPredicates.*;
import static org.springframework.web.reactive.function.server.RouterFunctions.route;

@Configuration(proxyBeanMethods = false)
public class RoutingConfiguration {

    @Bean
    public RouterFunction<User> monoRouterFunction(UserHandler userHandler) {
        return route(GET("/{user}").and(accept(APPLICATION_JSON)), userHandler::getUser)
                .andRoute(GET("/{user}/customers").and(accept(APPLICATION_JSON)), userHandler::getUserCustomers)
                .andRoute(DELETE("/{user}").and(accept(APPLICATION_JSON)), userHandler::deleteUser);
    }

}