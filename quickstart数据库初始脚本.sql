
DROP TABLE IF EXISTS `my_student`;
CREATE TABLE `my_student` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `teacher_id` bigint(20) DEFAULT NULL COMMENT '教师id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='学生表';


DROP TABLE IF EXISTS `my_student_scores`;
CREATE TABLE `my_student_scores` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) DEFAULT NULL COMMENT '学生id',
  `type` int(11) DEFAULT NULL COMMENT '类型#YUWEN,1,语文;SHUXUE,2,数学;YINGYU,3,英语;',
  `scores` int(11) DEFAULT NULL COMMENT '分数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id` (`student_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分数表';


DROP TABLE IF EXISTS `my_teacher`;
CREATE TABLE `my_teacher` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师表';