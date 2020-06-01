package com.shotgun.my.fgc.commentGenerator;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.internal.DefaultCommentGenerator;

/**
 * 
 * @author josnow
 * @date 2017年10月26日 上午11:41:35
 * @version 1.0.0
 * @desc 实体属性注释
 */
public class MyCommentGenerator extends DefaultCommentGenerator {

	@Override
	public void addFieldComment(Field field, IntrospectedTable introspectedTable,
			IntrospectedColumn introspectedColumn) {

		if (introspectedColumn.getRemarks() != null && !introspectedColumn.getRemarks().equals("")) {
			field.addJavaDocLine("/** " + introspectedColumn.getRemarks() + " */");
		}
	}

}
