package com.my.ffc;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.springframework.core.io.ClassPathResource;
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

public class Xmltest {
    public static class IgnoreDTDEntityResolver implements EntityResolver {

        @Override
        public InputSource resolveEntity(String publicId, String systemId) throws SAXException, IOException {
            return new InputSource(new ByteArrayInputStream("<?xml version='1.0' encoding='UTF-8'?>".getBytes()));
        }
    }

    public static void main32(String[] args) throws Exception {
        Document document = DocumentHelper
                .parseText("<resultMap id=\"BaseResultMap\" type=\"com.yunyihenkey.basedao.malldb.basevo.MallMoneyDelay\">\n" +
                        "    <id column=\"id\" jdbcType=\"BIGINT\" property=\"id\"/>\n" +
                        "    <result column=\"money_user_id\" jdbcType=\"BIGINT\" property=\"moneyUserId\"/>\n" +
                        "    <result column=\"account_type\" jdbcType=\"INTEGER\" property=\"accountType\"/>\n" +
                        "    <result column=\"title\" jdbcType=\"VARCHAR\" property=\"title\"/>\n" +
                        "    <result column=\"order_money\" jdbcType=\"BIGINT\" property=\"orderMoney\"/>\n" +
                        "    <result column=\"money\" jdbcType=\"BIGINT\" property=\"money\"/>\n" +
                        "    <result column=\"money_type\" jdbcType=\"INTEGER\" property=\"moneyType\"/>\n" +
                        "    <result column=\"relation_id\" jdbcType=\"BIGINT\" property=\"relationId\"/>\n" +
                        "    <result column=\"remarks\" jdbcType=\"VARCHAR\" property=\"remarks\"/>\n" +
                        "    <result column=\"create_time\" jdbcType=\"TIMESTAMP\" property=\"createTime\"/>\n" +
                        "    <result column=\"sign\" jdbcType=\"VARCHAR\" property=\"sign\"/>\n" +
                        "    <result column=\"old_money\" jdbcType=\"BIGINT\" property=\"oldMoney\"/>\n" +
                        "    <result column=\"postage_fee\" jdbcType=\"BIGINT\" property=\"postageFee\"/>\n" +
                        "  </resultMap>");

        System.out.println(document.getRootElement().asXML());

    }

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

            Document document = DocumentHelper
                    .parseText("<resultMap id=\"BaseResultMap\" type=\"com.yunyihenkey.basedao.malldb.basevo.MallMoneyDelay\">\n" +
                            "    <id column=\"id\" jdbcType=\"BIGINT\" property=\"id\"/>\n" +
                            "  </resultMap><!-- ssss -->");

            Element rootElement1 = document.getRootElement();
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

            // 打印字符串,即是XML文档
            System.out.println(stringWriter.toString());

            xmlWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

//        System.out.println(extdocument.asXML());

    }
}
