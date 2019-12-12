package ${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.baseDo.${tuofengTableName?cap_first};
import org.springframework.stereotype.Repository;

/**
* ${introspectedTable.remarks}-Mapper 接口
*
*/
@Repository(value = "i${tuofengTableName?cap_first}Mapper")
public interface ${tuofengTableName?cap_first}Mapper extends BaseMapper<${tuofengTableName?cap_first}> {

}
