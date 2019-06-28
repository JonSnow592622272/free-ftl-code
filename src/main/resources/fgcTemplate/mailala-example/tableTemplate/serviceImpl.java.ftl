package ${diy_serviceImpl_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.entity.${introspectedTable.tableConfiguration.domainObjectName};
import ${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.mapper.${introspectedTable.tableConfiguration.domainObjectName}Mapper;
import ${diy_service_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.service.I${introspectedTable.tableConfiguration.domainObjectName}Service;
import org.springframework.stereotype.Service;

/**
 * ${introspectedTable.remarks}-服务实现类
 *
 */
@Service
public class ${introspectedTable.tableConfiguration.domainObjectName}ServiceImpl extends ServiceImpl<${introspectedTable.tableConfiguration.domainObjectName}Mapper, ${introspectedTable.tableConfiguration.domainObjectName}> implements I${introspectedTable.tableConfiguration.domainObjectName}Service {


}
