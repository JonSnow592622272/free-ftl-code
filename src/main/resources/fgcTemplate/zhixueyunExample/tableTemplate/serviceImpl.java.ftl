<#include "config/tableConfig.ftl">
package ${zxy_service_impl_package}<#if introspectedTable.tableConfiguration.properties.serviceImpl_module??&& introspectedTable.tableConfiguration.properties.serviceImpl_module!="">.${introspectedTable.tableConfiguration.properties.serviceImpl_module}<#else></#if>;

import com.zxy.common.dao.support.CommonDao;
import ${zxy_service_package}<#if introspectedTable.tableConfiguration.properties.service_module??&& introspectedTable.tableConfiguration.properties.service_module!="">.${introspectedTable.tableConfiguration.properties.service_module}<#else></#if>.${tuofengTableName?substring(1)}Service;
import com.zxy.product.${zxy_java_package}.entity.${tuofengTableName?substring(1)};
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.zxy.product.${zxy_java_package}.jooq.Tables.${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case};

@Service
public class ${tuofengTableName?substring(1)}ServiceSupport implements ${tuofengTableName?substring(1)}Service {

    private CommonDao<${tuofengTableName?substring(1)}> ${tuofengTableName?substring(1)?uncap_first}Dao;

    @Autowired
    public void set${tuofengTableName?substring(1)}Dao(CommonDao<${tuofengTableName?substring(1)}> ${tuofengTableName?substring(1)?uncap_first}Dao) {
        this.${tuofengTableName?substring(1)?uncap_first}Dao = ${tuofengTableName?substring(1)?uncap_first}Dao;
    }

    @Override
    public void delete(${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments} ${introspectedTable.primaryKeyColumns[0].javaProperty}) {
        ${tuofengTableName?substring(1)?uncap_first}Dao.delete(${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case}.${introspectedTable.primaryKeyColumns[0].actualColumnName?substring(2)?upper_case}.eq(${introspectedTable.primaryKeyColumns[0].javaProperty}));
    }


}
