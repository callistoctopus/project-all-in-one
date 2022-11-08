DROP table if exists bill;
CREATE TABLE `bill` (
  `id` varchar(100) NOT NULL,
  `user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '经济行为执行者',
  `time` datetime NOT NULL COMMENT '经济行为发生日期时间',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '经济行为发生要因',
  `type` smallint NOT NULL COMMENT '0：支出 1：收入',
  `amount` double NOT NULL COMMENT '金额',
  `note` varchar(100) DEFAULT NULL COMMENT '备注',
  `is_deleted` smallint DEFAULT NULL COMMENT '是否删除',
  `update_time` datetime DEFAULT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流水账';

DROP table if exists budget;
CREATE TABLE `budget` (
  `id` varchar(100) NOT NULL,
  `user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '经济行为执行者',
  `year` varchar(4) NOT NULL COMMENT '经济预算年份',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '预算项目',
  `type` smallint NOT NULL COMMENT '0：支出 1：收入',
  `budget` double NOT NULL COMMENT '预算金额',
  `note` varchar(100) DEFAULT NULL COMMENT '备注',
  `is_deleted` smallint DEFAULT NULL COMMENT '是否删除',
  `update_time` datetime DEFAULT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='年度预算';

-- zhangben.budget definition
DROP table if exists financial_reason;
CREATE TABLE `financial_reason` (
  `id` varchar(100) NOT NULL,
  `user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '经济行为执行者',
  `type` smallint NOT NULL COMMENT '0：支出 1：收入',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '经济行为发生要因',
  `note` varchar(100) DEFAULT NULL COMMENT '备注',
  `is_deleted` smallint DEFAULT NULL COMMENT '是否删除',
  `update_time` datetime DEFAULT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='经济行为发生要因';