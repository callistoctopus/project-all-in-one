//MyService.java

import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import reactor.core.publisher.Mono;

@Service
public class MyBeans {
    private final WebClient webClient;

    public MyBeans(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl("https://example.org").build();
    }

    public Mono<String> someRestCall(String name) {
        return this.webClient.get().uri("/{name}/details", name)
                        .retrieve().bodyToMono(String.class);
    }
}