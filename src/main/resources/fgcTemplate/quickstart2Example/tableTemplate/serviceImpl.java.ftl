package ${diy_serviceImpl_targetPackage}.${introspectedTable.tableConfiguration.properties.module};

import com.baomidou.mybatisplus.core.metadata.IPage;
import ${diy_serviceApi_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${className}ServiceApi;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${className};
import ${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${className}Mapper;
import ${diy_service_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${className}Service;
import com.shotgun.mycommon.service.base.MyServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(${className}ServiceApi.PATH)
public class ${className}ServiceImpl extends MyServiceImpl<${className}Mapper, ${className}> implements ${className}Service {

    @Autowired
    private ${className}ServiceApi testServiceApi;//http接口调用

    @Autowired
    private ${className}Service testService;//内部方法直接调用


    /**
     * 暴露接口
     **/
    @Override
    public IPage<${className}> testGet10() {
        System.out.println("testServiceApi内存信息:::" + testServiceApi);
        System.out.println("testService内存信息:::" + testService);

        return super.testGet10();
    }


}
