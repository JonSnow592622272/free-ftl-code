package ${diy_service_targetPackage}.${introspectedTable.tableConfiguration.properties.module};

import ${diy_serviceApi_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${tuofengTableName?cap_first}ServiceApi;

/**
 * @desc 提供给controller层的接口放在Api接口，仅给service层提供的接口才放到这
 **/
public interface ${tuofengTableName?cap_first}Service extends ${tuofengTableName?cap_first}ServiceApi {


}