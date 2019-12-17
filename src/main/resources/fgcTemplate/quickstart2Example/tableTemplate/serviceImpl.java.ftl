package ${diy_serviceImpl_targetPackage}.${introspectedTable.tableConfiguration.properties.module};

import com.baomidou.mybatisplus.core.metadata.IPage;
import ${diy_serviceApi_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${tuofengTableName?cap_first}ServiceApi;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${tuofengTableName?cap_first};
import ${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${tuofengTableName?cap_first}Mapper;
import ${diy_service_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${tuofengTableName?cap_first}Service;
import com.shotgun.mycommon.service.base.MyServiceImpl;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(${tuofengTableName?cap_first}ServiceApi.PATH)
public class ${tuofengTableName?cap_first}ServiceImpl extends MyServiceImpl<${tuofengTableName?cap_first}Mapper, ${tuofengTableName?cap_first}> implements ${tuofengTableName?cap_first}Service {

    @Override
    public IPage<${tuofengTableName?cap_first}> testGet10() {
        return super.testGet10();
    }


}
