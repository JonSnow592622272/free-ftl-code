package ${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.baseDo.${className};
import org.springframework.stereotype.Repository;

/**
* ${introspectedTable.remarks}-Mapper 接口
*
*/
@Repository(value = "i${className}Mapper")
public interface ${className}Mapper extends BaseMapper<${className}> {

}
