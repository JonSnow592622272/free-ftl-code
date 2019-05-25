package com.my.ffc;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.springframework.core.io.ClassPathResource;

import java.util.ArrayList;
import java.util.List;

public class StartUp {
    public static void main(String[] args) throws Exception {
        List<String> warnings = new ArrayList<String>();
        warnings.add("zzzzz");
        warnings.add("zzzzz55555555555");
        warnings.add("zzzzz666666");


        boolean overwrite = true;
        ClassPathResource generatorConfigResource = new ClassPathResource("ffcDbConfig/generatorConfig.xml");
//		File configFile = new File("generatorConfig.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(generatorConfigResource.getInputStream());
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }
}
