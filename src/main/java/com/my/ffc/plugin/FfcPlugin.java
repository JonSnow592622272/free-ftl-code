package com.my.ffc.plugin;

import com.my.ffc.plugin.ffcPlugin.PluginTypeEnum;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.Interface;
import org.mybatis.generator.api.dom.java.TopLevelClass;
import org.mybatis.generator.config.Context;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class FfcPlugin extends BasePlugin {

    private String tableTemplatePackage;
    private String fieldTemplatePackage;
    private Configuration cfgTable = new Configuration(Configuration.VERSION_2_3_23);
    private Configuration cfgField = new Configuration(Configuration.VERSION_2_3_23);
    private boolean isEnableTablePlugin = true;
    private boolean isEnableFieldPlugin = true;

    @Override
    public void setContext(Context context) {
        try {

            tableTemplatePackage = context.getProperty("tableTemplatePackage");
            fieldTemplatePackage = context.getProperty("fieldTemplatePackage");
            if ("${tableTemplatePackage}".equals(tableTemplatePackage)) {
                tableTemplatePackage = null;
            }
            if ("${fieldTemplatePackage}".equals(fieldTemplatePackage)) {
                fieldTemplatePackage = null;
            }

            if (StringUtils.isEmpty(tableTemplatePackage)) {
                isEnableTablePlugin = false;
            } else {
                Assert.isTrue(Files
                        .isDirectory(new File(tableTemplatePackage)
                                .toPath()), "确保tableTemplatePackage存在且为文件夹！tableTemplatePackage=" + tableTemplatePackage);
                cfgTable.setDirectoryForTemplateLoading(new File(tableTemplatePackage));
            }

            if (StringUtils.isEmpty(fieldTemplatePackage)) {
                isEnableFieldPlugin = false;
            } else {
                Assert.isTrue(Files
                        .isDirectory(new File(fieldTemplatePackage)
                                .toPath()), "确保fieldTemplatePackage存在且为文件夹！fieldTemplatePackage=" + fieldTemplatePackage);
                cfgField.setDirectoryForTemplateLoading(new File(fieldTemplatePackage));
            }

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

        try {

            Configuration cfg;
            String templatePackage;
            switch (pluginTypeEnum) {
                case TABLE:
                    if (!isEnableTablePlugin) {
                        return;
                    }
                    cfg = cfgTable;
                    templatePackage = tableTemplatePackage;
                    break;
                case FIELD:
                    if (!isEnableFieldPlugin) {
                        return;
                    }
                    cfg = cfgField;
                    templatePackage = fieldTemplatePackage;
                    break;
                default:
                    throw new RuntimeException("未匹配到类型!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!");
            }

            Files.list(new File(templatePackage).toPath()).forEach(path -> {

                if (path.toAbsolutePath().toString().endsWith(".ftl")) {

                    try {
                        Path configFilePath = new File(path.toAbsolutePath().toString() + "config.properties").toPath();

                        //从ftl模板生成properties内容
                        byte[] baoBytes = loadFtlTemplate(commonMap, cfg, configFilePath);
                        //生成properties
                        Properties ftlProperties = new Properties();
                        ftlProperties.load(new StringReader(new String(baoBytes, StandardCharsets.UTF_8)));

                        //properties配置属性
                        String filePathProp = ftlProperties.getProperty("filePath");
                        Assert.isTrue(!StringUtils.isEmpty(filePathProp), configFilePath.toAbsolutePath()
                                .toString() + "文件中filePath不能为空");
                        String fileCreateTypeProp = ftlProperties.getProperty("fileCreateType");

                        //从ftl模板生成代码
                        byte[] bao2Bytes = loadFtlTemplate(commonMap, cfg, path);

                        Path createFilePath = new File(filePathProp).toPath();
                        //创建目录
                        Files.createDirectories(createFilePath.getParent());
                        //创建文件
                        if ("1".equals(fileCreateTypeProp)) {
                            //重写模式
                            if (Files.exists(createFilePath)) {
                                //检查文件内容是否一致，如果完全一致则不需要再覆盖了
                                if (!new String(Files.readAllBytes(createFilePath), StandardCharsets.UTF_8)
                                        .equals(new String(bao2Bytes, StandardCharsets.UTF_8))) {
                                    //文件存在且内容不同!!!!!!!!!!替换！！！！！！
                                    Files.write(createFilePath, bao2Bytes);
                                }
                            } else {
                                Files.write(createFilePath, bao2Bytes);
                            }
                        } else if ("2".equals(fileCreateTypeProp)) {
                            //替换模式。只支持xml。对“标签”和“id”匹配的进行替换
                            //.............................................................................................
                        } else {
                            //不重写模式
                            if (!Files.exists(createFilePath)) {
                                Files.write(createFilePath, bao2Bytes);
                            }
                        }

                    } catch (Exception e) {
                        throw new RuntimeException("error!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!", e);
                    }

                } else {
                    //非.ftl结尾文件直接跳过
                    return;
                }
            });

        } catch (Exception e) {
            throw new RuntimeException("error!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!", e);
        }

    }

    private byte[] loadFtlTemplate(Map<String, Object> commonMap, Configuration cfg, Path configFilePath) throws IOException, TemplateException {
        Assert.isTrue(Files.exists(configFilePath) && !Files
                .isDirectory(configFilePath), "确保文件存在且不是文件夹!!!!!" + configFilePath.toAbsolutePath()
                .toString());
        Template template = cfg.getTemplate(configFilePath.getFileName().toString());
        ByteArrayOutputStream bao = new ByteArrayOutputStream(1024);
        Writer out = new OutputStreamWriter(bao);
        template.process(commonMap, out);
        out.flush();
        out.close();
        return bao.toByteArray();
    }

}
