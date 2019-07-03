package ${diy_serviceImpl_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.entity.${tuofengTableName?cap_first};
import ${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.mapper.${tuofengTableName?cap_first}Mapper;
import ${diy_service_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.service.I${tuofengTableName?cap_first}Service;
import org.springframework.stereotype.Service;

/**
 * ${introspectedTable.remarks}-服务实现类
 *
 */
@Service("i${tuofengTableName?cap_first}ServiceImpl")
public class ${tuofengTableName?cap_first}ServiceImpl extends ServiceImpl<${tuofengTableName?cap_first}Mapper, ${tuofengTableName?cap_first}> implements I${tuofengTableName?cap_first}Service {


}
