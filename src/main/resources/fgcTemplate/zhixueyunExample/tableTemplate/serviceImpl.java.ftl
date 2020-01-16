<#include "config/tableConfig.ftl">
package com.zxy.product.training.service.support;

import com.zxy.common.dao.support.CommonDao;
import com.zxy.product.training.api.${tuofengTableName?substring(1)}Service;
import com.zxy.product.training.entity.${tuofengTableName?substring(1)};
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.zxy.product.training.jooq.Tables.${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case};

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
