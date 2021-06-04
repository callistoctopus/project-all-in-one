//package cn.think.sky.repository.database.RDB.hibernate;
//
//import java.io.Serializable;
//import java.util.List;
//
//import org.hibernate.Criteria;
//import org.hibernate.Session;
//import org.hibernate.SessionFactory;
//import org.hibernate.criterion.Order;
//import org.hibernate.criterion.Restrictions;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Repository;
//import org.springframework.transaction.annotation.Transactional;
//
//import cn.think.sky.model.User;
//
//@Repository
//public class HibernateRepository {
//	
//	@Autowired
//	private SessionFactory sessionFactory;
//
//	private Session currentSession() {
//		return sessionFactory.getCurrentSession();//<co id="co_RetrieveCurrentSession"/>
//	}
//
//	public long count() {
//		return findAll().size(); 
//	}
//
//	public List<User> findRecent() {
//		return findRecent(10);
//	}
//
//	public List<User> findRecent(int count) {
//		return (List<User>) userCriteria()
//				.setMaxResults(count)
//				.list();
//	}
//
//	public User findOne(String username) {
//		return (User) currentSession().get(User.class, username);
//	}
//
//	public User save(User user) {
//		Serializable id = currentSession().save(user);
//		return new User(
//				user.getId(),
//				user.getUsername(), 
//				user.getPassword(), 
//				user.getEnabled(),
//				user.getAuthority());
//	}
//
//	public List<User> findByUserId(long spitterId) {
//		return userCriteria()
//				.add(Restrictions.eq("users.id", spitterId))
//				.list();
//	}
//	
//	public void delete(String username) {
//		currentSession().delete(findOne(username));
//	}
//	
//	@Transactional
//	public List<User> findAll() {
//		return (List<User>) userCriteria().list(); 
//	}
//	
//	private Criteria userCriteria() {
//		return currentSession() 
//				.createCriteria(User.class)
//				.addOrder(Order.desc("username"));
//	}
//}
