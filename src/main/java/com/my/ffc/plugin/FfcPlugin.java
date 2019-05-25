package com.my.ffc.plugin;

import freemarker.template.Configuration;
import freemarker.template.Template;
import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.Interface;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FfcPlugin extends BasePlugin {

    private List<String> list;

    private Configuration cfgTable = new Configuration(Configuration.VERSION_2_3_23);

    private Configuration cfgField = new Configuration(Configuration.VERSION_2_3_23);


    @Override
    public boolean validate(List<String> list) {
        try {
            this.list = list;
            cfgTable.setDirectoryForTemplateLoading(new File("src/main/resources/ffcTemplate/defaultGroup/tableTemplate"));
            //TODO            cfgField.setDirectoryForTemplateLoading(new File("src/main/resources/ffcTemplate/defaultGroup/tableTemplate"));
        } catch (IOException e) {
            throw new RuntimeException("error!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!", e);
        }
        return true;
    }

    @Override
    public boolean modelFieldGenerated(Field field, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType) {
        return false;
    }


    @Override
    public boolean clientGenerated(Interface anInterface, TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {


        try {

            Template template = cfgTable.getTemplate("aa.ftl");

            // 建立数据模型（Map）
            Map<String, Object> root = new HashMap<>();
            root.put("anInterface", anInterface);
            root.put("topLevelClass", topLevelClass);
            root.put("introspectedTable", introspectedTable);

            // 获取输出流（指定到控制台（标准输出））
            Writer out = new OutputStreamWriter(System.out);
            // StringWriter out = new StringWriter();
            // System.out.println(out.toString());
            // 数据与模板合并（数据+模板=输出）
            template.process(root, out);
            out.flush();
        } catch (Exception e) {
            throw new RuntimeException("error!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!", e);
        }
        return false;
    }
}
