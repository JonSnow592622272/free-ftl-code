DROP TABLE IF EXISTS `my_teacher`;
CREATE TABLE `my_teacher` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师表';



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




INSERT INTO `nimei`.`my_teacher`(`id`, `name`, `age`) VALUES (1, '猪老师', 30);
INSERT INTO `nimei`.`my_teacher`(`id`, `name`, `age`) VALUES (2, '肥仔老师', 31);


INSERT INTO `nimei`.`my_student`(`id`, `name`, `age`, `teacher_id`) VALUES (1, '张三', 10, 1);
INSERT INTO `nimei`.`my_student`(`id`, `name`, `age`, `teacher_id`) VALUES (2, '李四', 10, 1);
INSERT INTO `nimei`.`my_student`(`id`, `name`, `age`, `teacher_id`) VALUES (3, '王五', 11, 1);
INSERT INTO `nimei`.`my_student`(`id`, `name`, `age`, `teacher_id`) VALUES (4, '赵六', 12, 2);
INSERT INTO `nimei`.`my_student`(`id`, `name`, `age`, `teacher_id`) VALUES (5, '田七', 13, 2);
INSERT INTO `nimei`.`my_student`(`id`, `name`, `age`, `teacher_id`) VALUES (6, '王八', 14, 2);


INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (1, 1, 1, 60);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (2, 1, 2, 70);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (3, 2, 1, 80);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (4, 2, 2, 90);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (5, 3, 1, 50);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (6, 3, 2, 40);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (7, 4, 1, 80);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (8, 4, 2, 80);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (9, 5, 1, 69);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (10, 5, 2, 90);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (11, 6, 1, 100);
INSERT INTO `nimei`.`my_student_scores`(`id`, `student_id`, `type`, `scores`) VALUES (12, 6, 2, 100);
