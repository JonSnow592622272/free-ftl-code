package ${diy_serviceImpl_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.baseDo.${className};
import ${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.mapper.${className}Mapper;
import ${diy_service_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.service.I${className}Service;
import org.springframework.stereotype.Service;

/**
 * ${introspectedTable.remarks}-服务实现类
 *
 */
@Service("i${className}ServiceImpl")
public class ${className}ServiceImpl extends ServiceImpl<${className}Mapper, ${className}> implements I${className}Service {


}
