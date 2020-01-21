package com.shotgun.my.fgc.plugin;

import com.shotgun.my.fgc.util.FileUtils;
import com.shotgun.my.fgc.xml.IgnoreDTDEntityResolver;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.Interface;
import org.mybatis.generator.api.dom.java.TopLevelClass;
import org.mybatis.generator.config.Context;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

public class FgcPlugin extends BasePlugin {

    private String tableTemplatePackage;
    private String fieldTemplatePackage;
    private File tableTemplatePackageFile;
    private File fieldTemplatePackageFile;
    private boolean isEnableTablePlugin = true;
    private boolean isEnableFieldPlugin = true;
    private Configuration cfgTable = new Configuration(Configuration.VERSION_2_3_23);
    private Configuration cfgField = new Configuration(Configuration.VERSION_2_3_23);
    /**
     * 建立数据模型（Map），用于传递到模板文件中
     */
    Map commonMap = new HashMap<>();

    /**
     * @author wulm
     * @version 1.0.0
     * @date 2019/5/26 21:06
     * @desc 插件类型枚举
     */
    public enum PluginTypeEnum {TABLE, FIELD}

    @Override
    public void setContext(Context context) {
        try {
            //将generatorConfig.xml中的properties传递到ftl模板中
            commonMap.putAll(context.getProperties());
            tableTemplatePackage = context.getProperty("tableTemplatePackage");
            fieldTemplatePackage = context.getProperty("fieldTemplatePackage");

            if ("".equals(tableTemplatePackage) || "${tableTemplatePackage}".equals(tableTemplatePackage)) {
                tableTemplatePackage = null;
                isEnableTablePlugin = false;
            } else {
                try {
                    //使用classpath相对路径
                    tableTemplatePackageFile = new ClassPathResource(tableTemplatePackage).getFile();
                } catch (IOException e) {
                    //使用绝对路径
                    tableTemplatePackageFile = new File(tableTemplatePackage);
                }
                Assert.isTrue(Files.isDirectory(tableTemplatePackageFile.toPath()),
                        "确保tableTemplatePackage存在且为文件夹！tableTemplatePackage=" + tableTemplatePackage);
                cfgTable.setDirectoryForTemplateLoading(tableTemplatePackageFile);
            }

            if ("".equals(fieldTemplatePackage) || "${fieldTemplatePackage}".equals(fieldTemplatePackage)) {
                fieldTemplatePackage = null;
                isEnableFieldPlugin = false;
            } else {
                try {
                    //使用classpath相对路径
                    fieldTemplatePackageFile = new ClassPathResource(fieldTemplatePackage).getFile();
                } catch (IOException e) {
                    //使用绝对路径
                    fieldTemplatePackageFile = new File(fieldTemplatePackage);
                }

                Assert.isTrue(Files.isDirectory(fieldTemplatePackageFile.toPath()),
                        "确保fieldTemplatePackage存在且为文件夹！fieldTemplatePackage=" + fieldTemplatePackage);
                cfgField.setDirectoryForTemplateLoading(fieldTemplatePackageFile);

            }

        } catch (IOException e) {
            throw new RuntimeException("执行失败!!!!!!!!!!!!!!!!!!!", e);
        }

    }

    @Override
    public boolean validate(List<String> list) {
        return true;
    }

    @Override
    public boolean modelFieldGenerated(Field field, TopLevelClass topLevelClass,
            IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable,
            ModelClassType modelClassType) {
//        System.out.println("执行字段：" + introspectedTable.getFullyQualifiedTableNameAtRuntime() + "::" +
//        introspectedColumn.getActualColumnName());
        readyGo(PluginTypeEnum.FIELD, field, topLevelClass, introspectedColumn, introspectedTable,
                modelClassType, null);
        return false;
    }

    @Override
    public boolean clientGenerated(Interface anInterface, TopLevelClass topLevelClass,
            IntrospectedTable introspectedTable) {
        System.out.println("执行表：" + introspectedTable.getFullyQualifiedTableNameAtRuntime());
        readyGo(PluginTypeEnum.TABLE, null, topLevelClass, null, introspectedTable, null, anInterface);
        return false;
    }

    private void readyGo(PluginTypeEnum pluginTypeEnum, Field field, TopLevelClass topLevelClass,
            IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable,
            ModelClassType modelClassType, Interface anInterface) {

        commonMap.put("field", field);
        commonMap.put("topLevelClass", topLevelClass);
        commonMap.put("introspectedColumn", introspectedColumn);
        commonMap.put("introspectedTable", introspectedTable);
        commonMap.put("modelClassType", modelClassType);
        commonMap.put("anInterface", anInterface);

        String className = introspectedTable.getBaseRecordType().substring(
                introspectedTable.getContext().getJavaModelGeneratorConfiguration().getTargetPackage()
                        .length() + 1);

        //设置驼峰表名
        commonMap.put("tuofengTableName",
                FileUtils.lineToHump(introspectedTable.getFullyQualifiedTableNameAtRuntime()));
        try {

            Configuration cfg;
            File templatePackageFile;
            switch (pluginTypeEnum) {
                case TABLE:
                    if (!isEnableTablePlugin) {
                        return;
                    }
                    cfg = cfgTable;
                    templatePackageFile = tableTemplatePackageFile;
                    break;
                case FIELD:
                    if (!isEnableFieldPlugin) {
                        return;
                    }
                    cfg = cfgField;
                    templatePackageFile = fieldTemplatePackageFile;
                    break;
                default:
                    throw new RuntimeException("未匹配到类型!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!");
            }

            Files.list(templatePackageFile.toPath()).forEach(templatePath -> {

                if (templatePath.toAbsolutePath().toString().endsWith(".ftl")) {

                    try {
                        String s = templatePath.toAbsolutePath().toString();
                        Path templateConfigFilePath = new File(s + "config.properties").toPath();

                        //从ftl模板生成properties内容
                        byte[] baoBytesProperties = loadFtlTemplate(commonMap, cfg, templateConfigFilePath);
                        //生成properties
                        Properties ftlProperties = new Properties();
                        ftlProperties.load(new StringReader(
                                new String(baoBytesProperties, StandardCharsets.UTF_8)));

                        String filePath = "filePath";
                        String fileCreateType = "fileCreateType";
                        String rmca = "replaceModeCheckAttributes";

                        //properties配置属性
                        String filePathProp = ftlProperties.getProperty(filePath);
                        Assert.isTrue(!StringUtils.isEmpty(filePathProp),
                                templateConfigFilePath.toAbsolutePath().toString() + "文件中filePath不能为空");

                        String fileCreateTypeProp = ftlProperties.getProperty(fileCreateType);
                        if (fileCreateTypeProp == null || "".equals(fileCreateTypeProp.trim())) {
                            fileCreateTypeProp = "0";
                        }

                        commonMap.putAll(ftlProperties);

                        //从ftl模板生成代码
                        byte[] baoBytesCode = loadFtlTemplate(commonMap, cfg, templatePath);

                        Path createFilePath = new File(filePathProp).toPath();

                        boolean isExistsOldFile = Files.exists(createFilePath);
                        //原始文件数据
                        byte[] oldFileBytes = isExistsOldFile ? Files
                                .readAllBytes(createFilePath) : new byte[0];

                        //创建目录
                        Files.createDirectories(createFilePath.getParent());

                        if (baoBytesCode.length == 0) {
                            //生成的代码内容为空，清除文件
                            if (Files.exists(createFilePath)) {
                                Files.delete(createFilePath);
                            }
                        } else {

                            //创建文件
                            if ("0".equals(fileCreateTypeProp)) {
                                //不重写模式（文件不存在则创建，存在则不覆盖）
                                if ((!isExistsOldFile || oldFileBytes.length == 0) && baoBytesCode.length > 0) {
                                    Files.write(createFilePath, baoBytesCode);
                                }
                            } else if ("1".equals(fileCreateTypeProp)) {
                                //重写模式
                                if (isExistsOldFile && oldFileBytes.length > 0) {
                                    //检查文件内容是否一致，如果完全一致则不需要再覆盖了
                                    if (!new String(oldFileBytes, StandardCharsets.UTF_8)
                                            .equals(new String(baoBytesCode, StandardCharsets.UTF_8))) {
                                        //文件存在且内容不同!!!!!!!!!!替换！！！！！！
                                        Files.write(createFilePath, baoBytesCode);
                                    }
                                } else {
                                    //文件不存在或者为空文件则创建
                                    if (baoBytesCode.length > 0) {
                                        Files.write(createFilePath, baoBytesCode);
                                    }
                                }
                            } else if ("2".equals(fileCreateTypeProp)) {
                                //替换模式。只支持xml。对“标签”和属性匹配的进行替换（无则创建，存在则替换）
//                            Assert.isTrue(createFilePath.endsWith(".xml"), "警告！！！该模式只支持xml格式文件！" +
//                            createFilePath
//                                    .toAbsolutePath().toString());
                                if ((!isExistsOldFile || oldFileBytes.length == 0) && baoBytesCode.length > 0) {
                                    Files.write(createFilePath, baoBytesCode);
                                } else {
                                    //文件存在，进行匹配替换

                                    String rmcaProp = ftlProperties.getProperty(rmca);
                                    if (rmcaProp == null || "".equals(rmcaProp.trim())) {
                                        rmcaProp = "id";
                                    }
                                    replaceXmlAndWriteFile(createFilePath, oldFileBytes, templatePath,
                                            baoBytesCode, rmcaProp.split(","));
                                }

                            } else {
                                throw new IllegalArgumentException("该模式尚未开发！！！");
                            }

                        }

                    } catch (Exception e) {
                        throw new RuntimeException("执行失败!!!!!!!!!!!!!!!!!!!" + e.getMessage(), e);
                    }

                } else {
                    //非.ftl结尾文件直接跳过
                    return;
                }
            });

        } catch (Exception e) {
            throw new RuntimeException("执行失败!!!!!!!!!!!!!!!!!!!" + e.getMessage(), e);
        }

    }

    private byte[] loadFtlTemplate(Map<String, Object> commonMap, Configuration cfg,
            Path configFilePath) throws IOException, TemplateException {
        Assert.isTrue(Files.exists(configFilePath) && !Files.isDirectory(configFilePath),
                "确保文件存在且不是文件夹!!!!!" + configFilePath.toAbsolutePath().toString());
        Template template = cfg.getTemplate(configFilePath.getFileName().toString());
        ByteArrayOutputStream bao = new ByteArrayOutputStream(1024);
        Writer out = new OutputStreamWriter(bao);
        template.process(commonMap, out);
        out.flush();
        out.close();
        return bao.toByteArray();
    }

    /**
     * @param oldFilePath                老的xml文件路径
     * @param oldXmlBytes
     * @param templatePath               xml模板文件路径
     * @param newXmlBytes                新的xml内容
     * @param replaceModeCheckAttributes 替换模式要检查标签的属性
     * @desc 替换xml，在新的xml内容在老的xml内容中，无则创建，存在则匹配替换。
     * @author wulm
     * @date 2019/6/17 17:43
     **/
    private void replaceXmlAndWriteFile(Path oldFilePath, byte[] oldXmlBytes, Path templatePath,
            byte[] newXmlBytes, String[] replaceModeCheckAttributes) throws IOException {

        SAXReader reader = new SAXReader(false);
        // 忽略DTD，降低延迟
        reader.setEntityResolver(new IgnoreDTDEntityResolver());

        Document oldDocument = null;
        try {
            oldDocument = reader.read(new ByteArrayInputStream(oldXmlBytes));
        } catch (DocumentException e) {
            throw new RuntimeException(
                    "原文件必须是xml文件内容！！！！！！！！！！！！！！！！oldFilePath=" + oldFilePath.toAbsolutePath().toString(), e);
        }
        Element oldRootElement = oldDocument.getRootElement();

        Document newDocument = null;
        try {
            newDocument = reader.read(new ByteArrayInputStream(newXmlBytes));
        } catch (DocumentException e) {
            throw new RuntimeException(
                    "新文件必须是xml文件内容！！！！！！！！！！！！！！！！templatePath=" + templatePath.toAbsolutePath().toString(),
                    e);
        }
        Element newRootElement = newDocument.getRootElement();

        //匹配替换处理
        replaceElement(oldRootElement, newRootElement, replaceModeCheckAttributes);
        //写入文件
        OutputFormat outputFormat = OutputFormat.createPrettyPrint();
        //outputFormat.setEncoding("UTF-8");
        // outputFormat.setSuppressDeclaration(true); //是否生产xml头
        //outputFormat.setIndent(true); //设置是否缩进
        //outputFormat.setIndent("    "); //以四个空格方式实现缩进
        outputFormat.setTrimText(false);

        ByteArrayOutputStream oldNewXmlBaos = new ByteArrayOutputStream(1024);

        XMLWriter xmlWriter = new XMLWriter(oldNewXmlBaos, outputFormat);
        xmlWriter.write(oldDocument);

        //去除空白行，存在多行空白只保留一行空白
        List<String> oldNewXmlStrs = FileUtils
                .trimLine(FileUtils.readAllLines(oldNewXmlBaos.toByteArray()), true, false);

        //检查文件内容是否一致，如果完全一致则不需要再覆盖了
        if (!new String(oldXmlBytes, StandardCharsets.UTF_8)
                .equals(FileUtils.stringsToString(oldNewXmlStrs))) {
            Files.write(oldFilePath, oldNewXmlStrs);
        }

    }

    /**
     * @desc 匹配替换处理
     * @author wulm
     * @date 2019/6/17 17:58
     **/
    private void replaceElement(Element oldElement, Element newElement, String[] replaceModeCheckAttributes) {
        List<Element> oldElements = oldElement.elements();

        Iterator<Element> newIt = newElement.elementIterator();
        newWhile:
        while (newIt.hasNext()) {
            Element newChild = newIt.next();
            //新xml节点和老xml节点比较
            //节点是否在老xml存在
            boolean isExistElement = false;
            //待匹配的新xml属性
            List<Attribute> newCheckAttributes = null;
            ListIterator<Element> oldIt = oldElements.listIterator();
            oldWhile:
            while (oldIt.hasNext()) {
                Element oldChild = oldIt.next();
                if (newChild.getName().equals(oldChild.getName())) {
                    //标签相同，进一步检查属性是否相同
                    if (newCheckAttributes == null) {
                        //初始化当前新的xml属性集合
                        newCheckAttributes = new ArrayList<>();
                        for (String attrName : replaceModeCheckAttributes) {
                            //添加待匹配的新xml属性
                            Attribute newAttribute = newChild.attribute(attrName);
                            if (newAttribute == null) {
                                //在新的xml中没有完全匹配到指定属性，直接跳过当前检测
                                continue newWhile;
                            } else {
                                newCheckAttributes.add(newAttribute);
                            }
                        }
                    }
                    boolean isAllAttrEquals = true;
                    for (Attribute newAttribute : newCheckAttributes) {
                        Attribute oldAttribute = oldChild.attribute(newAttribute.getName());
                        if (oldAttribute == null || !oldAttribute.getValue()
                                .equals(newAttribute.getValue())) {
                            isAllAttrEquals = false;
                            break;
                        }
                    }
                    if (isAllAttrEquals) {
                        //存在且匹配到则替换
                        isExistElement = true;
                        oldIt.remove();
//                        Element copy = newChild.createCopy();
//                        System.out.println("::::::::::::::::::::" + copy.asXML());
                        oldIt.add(newChild.createCopy());
                        //continue  newWhile;
                        // /////////////////////////////////////////////////////////这里可以考虑以后要不要标签属性匹配过成功一次就跳过。
                    }

                }
            }
            if (!isExistElement) {
                //新的xml存在，但老的xml没找到，采用“无则创建原则”////////////////////////////////////////////////后面可以考虑是否调整顺序
                oldElements.add(0, newChild.createCopy());
            }
        }
    }

}
