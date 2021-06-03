#@JsonComponent 是Spring boot的核心注解，使用@JsonComponent 之后就不需要手动将Jackson的序列化和反序列化手动加入ObjectMapper。


//UserCombinedSerializer.java
import org.springframework.boot.ExitCodeGenerator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.*;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import org.springframework.boot.jackson.*;

@JsonComponent
public class UserCombinedSerializer  {

    public static class UserJsonSerializer 
      extends JsonSerializer<User> {
 
        @Override
        public void serialize(User user, JsonGenerator jsonGenerator, 
          SerializerProvider serializerProvider) throws IOException, 
          JsonProcessingException {
  
            jsonGenerator.writeStartObject();
            jsonGenerator.writeStringField(
              "favoriteColor", getColorAsWebColor(user.getFavoriteColor()));
            jsonGenerator.writeEndObject();
        }
 
        private static String getColorAsWebColor(Color color) {
            int r = (int) Math.round(color.getRed() * 255.0);
            int g = (int) Math.round(color.getGreen() * 255.0);
            int b = (int) Math.round(color.getBlue() * 255.0);
            return String.format("#%02x%02x%02x", r, g, b);
        }
    }
 
    public static class UserJsonDeserializer 
      extends JsonDeserializer<User> {
  
        @Override
        public User deserialize(JsonParser jsonParser, 
          DeserializationContext deserializationContext)
          throws IOException, JsonProcessingException {
  
            TreeNode treeNode = jsonParser.getCodec().readTree(jsonParser);
            TextNode favoriteColor = (TextNode) treeNode.get(
              "favoriteColor");
            return new User(Color.web(favoriteColor.asText()));
        }
    }

}

//User.java
public class User {
    private Color favoriteColor;

    //setter,getter...
}

#序列化的使用
//UserJsonSerializerTest.java
public class UserJsonSerializerTest {
 
    @Autowired
    private ObjectMapper objectMapper;
 
    @Test
    public void testSerialization() throws JsonProcessingException {
        User user = new User(Color.ALICEBLUE);
        String json = objectMapper.writeValueAsString(user);
  
        assertEquals("{\"favoriteColor\":\"#f0f8ff\"}", json);
    }
}

#反序列化的使用
//UserJsonDeserializerTest.java
public class UserJsonDeserializerTest {
 
    @Autowired
    private ObjectMapper objectMapper;
 
    @Test
    public void testDeserialize() throws IOException {
        String json = "{\"favoriteColor\":\"#f0f8ff\"}"
        User user = objectMapper.readValue(json, User.class);
  
        assertEquals(Color.ALICEBLUE, user.getFavoriteColor());
    }
}
