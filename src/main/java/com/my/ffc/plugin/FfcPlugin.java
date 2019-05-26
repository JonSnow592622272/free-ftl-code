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
import java.nio.file.Files;
import java.nio.file.Path;
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
        readyGo(field, topLevelClass, introspectedColumn, introspectedTable, modelClassType, null);
        return false;
    }


    @Override
    public boolean clientGenerated(Interface anInterface, TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        readyGo(null, topLevelClass, null, introspectedTable, null, anInterface);
        return false;
    }

    private void readyGo(Field field, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType, Interface anInterface) {
        try {

            Template template = cfgTable.getTemplate("aa.ftl");

            // 建立数据模型（Map）
            Map<String, Object> root = new HashMap<>();
            root.put("field", field);
            root.put("class", topLevelClass);
            root.put("column", introspectedColumn);
            root.put("table", introspectedTable);
            root.put("classType", modelClassType);
            root.put("interface", anInterface);

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
    }

    public static void main(String[] args) throws IOException {
        Path path = new File("D:/a/b/d").toPath();
        Files.createDirectories(path);
    }
}
