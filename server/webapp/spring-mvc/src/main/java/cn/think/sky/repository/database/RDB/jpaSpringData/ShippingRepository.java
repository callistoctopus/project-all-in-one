package cn.think.sky.repository.database.RDB.jpaSpringData;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import cn.think.sky.model.Shipping;
import cn.think.sky.model.User;

/**
 * Repository interface with operations for {@link Spitter} persistence.
 * @author habuma
 */
public interface ShippingRepository extends JpaRepository<Shipping, Long> {
	  
//	Shipping findByUsername(String username);
	
//	List<User> findByUsernameOrFullNameLike(String username, String fullName);

}
