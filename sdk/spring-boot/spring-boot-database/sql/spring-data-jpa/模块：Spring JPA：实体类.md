通过
@EnableAutoConfiguration 
@SpringBootApplication
开启实体类扫描

通过
@Entity, 
@Embeddable, 
@MappedSuperclass
标注实体类

//People.java
import java.io.Serializable;
import javax.persistence.*;

@Entity
public class People implements Serializable {

    @Id
    @GeneratedValue
    private Long person_id;

    @Column(nullable = false)
    private String first_name;

    @Column(nullable = false)
    private String last_name;

    // ... additional members, often include @OneToMany mappings

    protected People() {
        // no-args constructor required by JPA spec
        // this one is protected since it shouldn't be used directly
    }

    public People(String fname, String lname) {
        this.first_name = fname;
        this.last_name= lname;
    }

}

