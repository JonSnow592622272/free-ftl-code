package com.my.ffc.plugin;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.Interface;
import org.mybatis.generator.api.dom.java.TopLevelClass;
import org.mybatis.generator.config.Context;

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

    private String tableTemplatePackage;
    private String fieldTemplatePackage;
    private Configuration cfgTable = new Configuration(Configuration.VERSION_2_3_23);
    private Configuration cfgField = new Configuration(Configuration.VERSION_2_3_23);

    @Override
    public void setContext(Context context) {
        try {
            tableTemplatePackage = context.getProperty("tableTemplatePackage");
            fieldTemplatePackage = context.getProperty("fieldTemplatePackage");

            cfgTable.setDirectoryForTemplateLoading(new File(tableTemplatePackage));
            cfgField.setDirectoryForTemplateLoading(new File(fieldTemplatePackage));
        } catch (IOException e) {
            throw new RuntimeException("error!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!", e);
        }

    }

    @Override
    public boolean validate(List<String> list) {
        return true;
    }

    @Override
    public boolean modelFieldGenerated(Field field, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType) {
        readyGo(PluginTypeEnum.FIELD, field, topLevelClass, introspectedColumn, introspectedTable, modelClassType, null);
        return false;
    }

    @Override
    public boolean clientGenerated(Interface anInterface, TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        readyGo(PluginTypeEnum.TABLE, null, topLevelClass, null, introspectedTable, null, anInterface);
        return false;
    }

    private void readyGo(PluginTypeEnum pluginTypeEnum, Field field, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType, Interface anInterface) {

        // 建立数据模型（Map）
        Map<String, Object> commonMap = new HashMap<>();
        commonMap.put("field", field);
        commonMap.put("class", topLevelClass);
        commonMap.put("column", introspectedColumn);
        commonMap.put("table", introspectedTable);
        commonMap.put("classType", modelClassType);
        commonMap.put("interface", anInterface);

        switch (pluginTypeEnum) {
            case FIELD:
                processFildTemplate(commonMap);
                break;
            case TABLE:
                processTableTemplate(commonMap);
                break;

            default:
                throw new RuntimeException("未匹配到类型!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!");
        }

    }

    private void processTableTemplate(Map<String, Object> commonMap) {
        try {
//            System.out.println(tableTemplatePackage);
            Template template = cfgTable.getTemplate("aa.ftl");

            // 获取输出流（指定到控制台（标准输出））
            Writer out = new OutputStreamWriter(System.out);
            // StringWriter out = new StringWriter();
            // System.out.println(out.toString());
            // 数据与模板合并（数据+模板=输出）
            template.process(commonMap, out);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            throw new RuntimeException("error!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!", e);
        }
    }

    private void processFildTemplate(Map<String, Object> commonMap) {
        try {
            Template template = cfgField.getTemplate("aa.ftl");

            // 获取输出流（指定到控制台（标准输出））
            Writer out = new OutputStreamWriter(System.out);
            // StringWriter out = new StringWriter();
            // System.out.println(out.toString());
            // 数据与模板合并（数据+模板=输出）
            template.process(commonMap, out);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            throw new RuntimeException("error!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!", e);
        }
    }

    public static void main(String[] args) throws IOException {
        Path path = new File("D:/a/b/d").toPath();
        Files.createDirectories(path);
    }
}
