<#include "config/tableConfig.ftl">
package ${zxy_service_package}<#if introspectedTable.tableConfiguration.properties.module??&& introspectedTable.tableConfiguration.properties.module!="">.${introspectedTable.tableConfiguration.properties.module}<#else></#if>;

import com.zxy.common.base.annotation.RemoteService;
import com.zxy.common.base.helper.PagedResult;
import com.zxy.product.training.entity.${tuofengTableName?substring(1)};
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * @desc ${introspectedTable.remarks}-Service
 **/
@RemoteService
public interface ${tuofengTableName?substring(1)}Service {

    /**
     * 删除
     *
     * @param ${introspectedTable.primaryKeyColumns[0].javaProperty} ${introspectedTable.primaryKeyColumns[0].remarks}
     **/
    @Transactional
    void delete(${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments} ${introspectedTable.primaryKeyColumns[0].javaProperty});


}
