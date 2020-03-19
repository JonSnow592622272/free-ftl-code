package com.shotgun.my.fgc.startup.primeval;

import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.springframework.core.io.ClassPathResource;

import java.util.ArrayList;
import java.util.List;

/**
 * @author wulm
 * @desc 原生mybatis-generator连接“达梦数据库”生成代码
 * 注意达梦数据库中“模式名”就是“数据库名”，表名一定要大写，否则找不到表
 *
 * @date 2020/3/19 20:28
 **/
public class DaMengGenerator {
    public static void main(String[] args) throws Exception {
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        ClassPathResource generatorConfigResource = new ClassPathResource(
                "fgcDbConfig/primeval/dameng/generatorConfig.xml");
//		File configFile = new File("generatorConfig.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(generatorConfigResource.getInputStream());
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        org.mybatis.generator.api.MyBatisGenerator myBatisGenerator =
                new org.mybatis.generator.api.MyBatisGenerator(
                config, callback, warnings);
        myBatisGenerator.generate(null);
    }
}
