create database account;

drop table IF EXISTS account;

create table account( 
	id VARCHAR(100) not null,
	name VARCHAR(100) not null,
	pass VARCHAR(100),
	sign_up_time DATETIME,
	latest_login_time DATETIME,
	status TINYINT not null,
	primary key (id) )
ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '用户登录信息';

create database authority;

drop table IF EXISTS authority;

create table authority( 
	id VARCHAR(100) not null,
	account_id VARCHAR(100) not null,
	role_id VARCHAR(100),
	primary key (id) 
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '用户权限信息表';

create table roles( 
	id VARCHAR(100) not null,
	service_id VARCHAR(100) not null,
	customize_level TINYINT,
	primary key (id) 
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '角色信息表';