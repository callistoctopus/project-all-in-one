Spring Data JPA 通过方法名自动为 Repository 接口创建实体

通过
@EnableAutoConfiguration 
@SpringBootApplication
开启扫描


//PeopleRepository.java
import com.callistoctopus.springbootdatajpahibernate.entity.People;

import org.springframework.data.domain.*;
import org.springframework.data.repository.*;

public interface PeopleRepository extends Repository<People, Long> {

    Page<People> findAll(Pageable pageable);

    People findByFirst_nameAndLast_nameAllIgnoringCase(String first_name, String last_name);

}