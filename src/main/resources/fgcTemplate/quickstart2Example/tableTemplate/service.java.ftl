package ${diy_service_targetPackage}.${introspectedTable.tableConfiguration.properties.module};

import ${diy_serviceApi_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${className}ServiceApi;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${className};
import com.shotgun.mycommon.service.base.MyIService;

/**
 * 只提供给service层的接口才放到这里(controller无法访问到)，control层和service都可以访问的接口放在ServiceApi接口
 **/
public interface ${className}Service extends ${className}ServiceApi, MyIService<${className}>  {


}