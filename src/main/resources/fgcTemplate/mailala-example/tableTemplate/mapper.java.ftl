package ${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.entity.${introspectedTable.tableConfiguration.domainObjectName};
import org.springframework.stereotype.Repository;

/**
* ${introspectedTable.remarks}-Mapper 接口
*
*/
@Repository(value = "i${introspectedTable.tableConfiguration.domainObjectName}Mapper")
public interface ${introspectedTable.tableConfiguration.domainObjectName}Mapper extends BaseMapper<${introspectedTable.tableConfiguration.domainObjectName}> {

}
