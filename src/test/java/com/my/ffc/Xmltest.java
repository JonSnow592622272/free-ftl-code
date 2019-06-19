package com.my.fgc;

import com.my.fgc.xml.IgnoreDTDEntityResolver;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.springframework.core.io.ClassPathResource;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

public class Xmltest {

    public static void main(String[] args) throws Exception {
        SAXReader reader = new SAXReader();
        // 忽略DTD，降低延迟
        reader.setEntityResolver(new IgnoreDTDEntityResolver());
        Document extdocument = reader.read(new ClassPathResource("xmltestfile/a.xml").getFile());

        Element rootElement = extdocument.getRootElement();

        ListIterator<Element> it = rootElement.elements().listIterator();

//        ListIterator it = (ListIterator) rootElement.elementIterator();

//        List<Element> elements = rootElement.elements();
        int i = 0;
        while (it.hasNext()) {
            i++;
            System.out.println("=============开始遍历第" + i + "本书==========");
            Element element = it.next();

            SAXReader reader2 = new SAXReader(false);
// 忽略DTD，降低延迟
            reader2.setEntityResolver(new IgnoreDTDEntityResolver());

            String s = "<resultMap id=\"BaseResultMap\" type=\"com.yunyihenkey.basedao.malldb.basevo.MallMoneyDelay\">\n\n\n" +
                    "<id column=\"id\" jdbcType=\"BIGINT\" property=\"id6666666666666666666666666\"/>\n\n\n\n\n\n" +
                    "<id column=\"id\" jdbcType=\"BIGINT\" property=\"id6666666666666666666666666\"/>" +
                    "<id column=\"id\" jdbcType=\"BIGINT\" property=\"id6666666666666666666666666\"/>" +
                    "<id column=\"id\" jdbcType=\"BIGINT\" property=\"id6666666666666666666666666\"/>" +
                    "</resultMap>";
            Document document = reader2
                    .read(new ByteArrayInputStream(s.getBytes()));

            Element rootElement1 = document.getRootElement();
//            rootElement1.createCopy()
            it.remove();
            it.add(rootElement1);

//            System.out.println(":::::" + element.asXML());
            if (true) {
                break;
            }

            List<Attribute> bookAttrs = element.attributes();
            for (Attribute attr : bookAttrs) {
                System.out.println("属性名：" + attr.getName() + "-----属性值：" + attr.getValue());
            }

            Iterator<Element> childNode = element.elementIterator();
            while (childNode.hasNext()) {
                Element child = childNode.next();
                System.out.println("节点名：" + child.getName() + "-----节点值：" + child.getStringValue());
            }
            System.out.println("=============结束遍历第" + i + "本书==========");
        }

        // 设置XML文档格式
        OutputFormat outputFormat = OutputFormat.createPrettyPrint();
//outputFormat.setEncoding("UTF-8");
// outputFormat.setSuppressDeclaration(true); //是否生产xml头
//outputFormat.setIndent(true); //设置是否缩进
//outputFormat.setIndent("    "); //以四个空格方式实现缩进
        outputFormat.setTrimText(false);

        try {
            // stringWriter字符串是用来保存XML文档的
            StringWriter stringWriter = new StringWriter();
            // xmlWriter是用来把XML文档写入字符串的(工具)
            XMLWriter xmlWriter = new XMLWriter(stringWriter, outputFormat);

            // 把创建好的XML文档写入字符串
            xmlWriter.write(extdocument);
            xmlWriter.close();

            stringWriter.close();
            // 打印字符串,即是XML文档
            System.out.println(stringWriter.toString());

        } catch (IOException e) {
            e.printStackTrace();
        }

//        System.out.println(extdocument.asXML());

    }

    public static void main2332(String[] args) throws Exception {
        String a="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<!DOCTYPE mapper PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\" \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">\n" +
                "<mapper namespace=\"com.yunyihenkey.basedao.malldb.basemapper.MallMoneyDelayBaseMapper\">\n" +
                "    <resultMap id=\"BaseResultMap\" type=\"com.yunyihenkey.basedao.malldb.basevo.MallMoneyDelay\">\n" +
                "        <id column=\"id\" jdbcType=\"BIGINT\" property=\"id\"/>\n" +
                "        <result column=\"money_user_id\" jdbcType=\"BIGINT\" property=\"moneyUserId\"/>\n" +
                "        <result column=\"account_type\" jdbcType=\"INTEGER\" property=\"accountType\"/>\n" +
                "    </resultMap>\n" +
                "    <sql id=\"Base_Column_List\">\n" +
                "        id, money_user_id, account_type, title, order_money, money, money_type, relation_id,\n" +
                "        remarks, create_time, sign, old_money, postage_fee\n" +
                "    </sql>\n" +
                "\n" +
                "</mapper>";

        OutputFormat outputFormat = OutputFormat.createPrettyPrint();
        //outputFormat.setEncoding("UTF-8");
        // outputFormat.setSuppressDeclaration(true); //是否生产xml头
        //outputFormat.setIndent(true); //设置是否缩进
        //outputFormat.setIndent("    "); //以四个空格方式实现缩进
        outputFormat.setTrimText(false);


        SAXReader reader = new SAXReader(false);
        // 忽略DTD，降低延迟
        reader.setEntityResolver(new IgnoreDTDEntityResolver());


        Document oldDocument = reader.read(new ByteArrayInputStream(a.getBytes()));

        StringWriter stringWriter = new StringWriter();

        XMLWriter xmlWriter = new XMLWriter(stringWriter, outputFormat);
        xmlWriter.write(oldDocument);


        System.out.println(stringWriter.toString());
    }
}
