create database project_info;

create table project( 
	id VARCHAR(100) not null COMMENT '项目ID',
	parent_id VARCHAR(100) not null COMMENT '上级项目ID',
	name VARCHAR(200) not null COMMENT '项目名称',
	outline VARCHAR(200) not null COMMENT '项目概要',
	customer_company VARCHAR(200) not null COMMENT '甲方公司',
	customer_id VARCHAR(200) not null COMMENT '甲方负责人',
	project_company VARCHAR(200) not null COMMENT '乙方公司',
	project_id VARCHAR(200) not null COMMENT '乙方负责人',
	create_date DATETIME not null COMMENT '项目创建日期',
	close_date DATETIME not null COMMENT '项目关闭日期',
	status TINYINT COMMENT '项目状态 0:立项 1：准备 2：实施中 3：验收 4：关闭 5：暂停 6：中止 7：终止',
	primary key (id) 
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '项目信息表';

create table project_function(	
	id VARCHAR(100) not null COMMENT '功能ID',
	parent_id VARCHAR(100) not null COMMENT '上级功能ID',
	name VARCHAR(200) not null COMMENT '功能名称',
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '项目功能信息表';

create table develop_flow( 
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '开发流程信息表';

create table develop_plan(
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '开发计划信息表';

create table develop_structure(
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '开发体制信息表';

create table develop_quality_quota(
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '开发品质信息表';

create table develop_risk( 
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '开发风险信息表';

create table develop_version( 
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '开发版本信息表';

create table develop_cost( 
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '开发成本信息表';

create table task(
	id VARCHAR(100) not null COMMENT '任务ID',
	executor_ids VARCHAR(100) not null COMMENT '实施者（多个以逗号分隔）',
	task_type TINYINT not null  COMMENT '任务类型 develop_flow or -：自定义', 
	name VARCHAR(200) not null COMMENT '任务名称',
	outline VARCHAR(200) not null COMMENT '任务概要',
	start_time_plan DATETIME COMMENT '计划开始日期', 
	end_time_plan DATETIME COMMENT '计划结束日期', 
	cost_plan INT COMMENT '预估任务耗时（人日）', 
	deadline DATETIME COMMENT '完成截止日期', 
	publish_time DATETIME COMMENT '发布日期',
	task_source_id VARCHAR(100) not null COMMENT '0:系统自动分发 -：管理员id',
	sender_comment VARCHAR(300) COMMENT '发布者备注',
	executor_comment VARCHAR(300) COMMENT '实施者备注',
	status TINYINT COMMENT '任务状态 0:作成中 1：已发布 2：已接收 3：实施中 4：实施完成 5：发布者取回 6：实施者取回  7：确认中 8：已承认 9：申请调整 10：再发'
)ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 STATS_PERSISTENT = 0 ROW_FORMAT = DYNAMIC COMMENT = '任务信息表';