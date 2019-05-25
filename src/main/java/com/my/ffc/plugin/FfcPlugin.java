package com.my.ffc.plugin;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.Interface;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import java.util.List;

public class FfcPlugin extends BasePlugin {

	private List<String> list;

	public List<String> getList() {
		return list;
	}

	public void setList(List<String> list) {
		this.list = list;
	}

	@Override
	public boolean validate(List<String> list) {
		this.list= list;
		return true;
	}

	@Override
	public boolean modelFieldGenerated(Field field, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType) {
		System.out.println(list + "jjjjjjjjjjjjjjjjjj");
		return false;
	}


    @Override
    public boolean clientGenerated(Interface anInterface, TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
		System.out.println(list + "wwwwwwwwwwww");
        return false;
    }

}
