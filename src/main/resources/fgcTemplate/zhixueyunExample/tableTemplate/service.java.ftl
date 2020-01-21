<#include "config/tableConfig.ftl">
package ${zxy_service_package}<#if introspectedTable.tableConfiguration.properties.service_module??&& introspectedTable.tableConfiguration.properties.service_module!="">.${introspectedTable.tableConfiguration.properties.service_module}<#else></#if>;

import com.zxy.common.base.annotation.RemoteService;
import com.zxy.common.base.helper.PagedResult;
import com.zxy.product.${zxy_java_package}.entity.${className};
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

/**
 * @desc ${introspectedTable.remarks}-Service
 **/
@RemoteService
public interface ${className}Service {

    /**
     * 删除
     *
     * @param ${introspectedTable.primaryKeyColumns[0].javaProperty} ${introspectedTable.primaryKeyColumns[0].remarks}
     **/
    @Transactional
    void delete(${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments} ${introspectedTable.primaryKeyColumns[0].javaProperty});

    /**
     * 查询单条
     *
     * @param ${introspectedTable.primaryKeyColumns[0].javaProperty} ${introspectedTable.primaryKeyColumns[0].remarks}
     * @return ${introspectedTable.remarks}
     **/
    @Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
    ${className} findById(${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments} ${introspectedTable.primaryKeyColumns[0].javaProperty});

    /**
     * 查询分页
     **/
    @Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
    PagedResult<${className}> findPage(Integer page, Integer pageSize);

    /**
     * 新增
     **/
    @Transactional
    ${className} insert(
<#assign isHave=false><#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="id"&&allColumns.javaProperty!="createTime" >
        <#if isHave>,</#if>Optional<${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}> ${allColumns.javaProperty}
        <#assign isHave=true>
    </#if>
</#list>
    );

    /**
     * 修改
     **/
    @Transactional
    int update(
<#assign isHave=false><#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="createTime" >
        <#if allColumns.javaProperty=="id">
            <#if isHave>,</#if>${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments} ${allColumns.javaProperty}
        <#else>
            <#if isHave>,</#if>Optional<${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}> ${allColumns.javaProperty}
        </#if>
        <#assign isHave=true>
    </#if>
</#list>
    );


}
