//package cn.think.sky.repository.database.RDB.jpa;
//
//import java.util.List;
//
//import javax.persistence.EntityManager;
//import javax.persistence.PersistenceContext;
//
//import org.springframework.stereotype.Repository;
//
//import cn.think.sky.model.User;
//
//@Repository
//public class JpaRepository {
//
//	@PersistenceContext
//	private EntityManager entityManager;
//
//	public long count() {
//		return findAll().size();
//	}
//
//	public User save(User user) {
//		entityManager.persist(user);
//		return user;
//	}
//
//	public User findOne(int id) {
//		return entityManager.find(User.class, id);
//	}
//
//	public User findByUsername(String username) {		
//		return (User) entityManager.createQuery("select s from User s where s.username=?").setParameter(1, username).getSingleResult();
//	}
//
//	public List<User> findAll() {
//		return (List<User>) entityManager.createQuery("select s from User s").getResultList();
//	}
//	
//}