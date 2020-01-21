<#include "config/tableConfig.ftl">
package ${zxy_controller_package}<#if introspectedTable.tableConfiguration.properties.controller_module??&& introspectedTable.tableConfiguration.properties.controller_module!="">.${introspectedTable.tableConfiguration.properties.controller_module}<#else></#if>;

import com.google.common.collect.ImmutableMap;
import com.zxy.common.base.helper.PagedResult;
import com.zxy.common.restful.RequestContext;
import com.zxy.common.restful.annotation.Param;
import com.zxy.common.restful.json.JSON;
import com.zxy.common.restful.security.Permitted;
import ${zxy_service_package}<#if introspectedTable.tableConfiguration.properties.service_module??&& introspectedTable.tableConfiguration.properties.service_module!="">.${introspectedTable.tableConfiguration.properties.service_module}<#else></#if>.${className}Service;
import com.zxy.product.${zxy_java_package}.entity.${className};
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Map;

/**
 * @desc ${introspectedTable.remarks}-Controller
 **/
@Controller
@RequestMapping("/${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?replace("_","-")}")
public class ${className}Controller {

    private ${className}Service ${className?uncap_first}Service;

    @Autowired
    public void set${className}Service(${className}Service ${className?uncap_first}Service) {
        this.${className?uncap_first}Service = ${className?uncap_first}Service;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/{${introspectedTable.primaryKeyColumns[0].javaProperty}}", method = RequestMethod.DELETE)
    @Permitted
    @Param(name = "${introspectedTable.primaryKeyColumns[0].javaProperty}", type = ${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments}.class, required = true)
    @JSON("*")
    public Map<String, Integer> delete(RequestContext requestContext) {
        ${className?uncap_first}Service.delete(requestContext.get${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments}("${introspectedTable.primaryKeyColumns[0].javaProperty}"));
        return ImmutableMap.of("count", 1);
    }


    /**
     * 查询单条
     **/
    @RequestMapping(value = "/{${introspectedTable.primaryKeyColumns[0].javaProperty}}", method = RequestMethod.GET)
    @Permitted
    @Param(name = "${introspectedTable.primaryKeyColumns[0].javaProperty}", type = ${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments}.class, required = true)
    @JSON("<#list introspectedTable.allColumns as allColumns>${allColumns.javaProperty}<#if allColumns_has_next>,</#if></#list>")
    public ${className} find(RequestContext requestContext) {
        return ${className?uncap_first}Service.findById(requestContext.get${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments}("${introspectedTable.primaryKeyColumns[0].javaProperty}"));
    }

    /**
     * 查询分页
     **/
    @RequestMapping(method = RequestMethod.GET)
    @Permitted
    @Param(name = "page", type = Integer.class, required = true)
    @Param(name = "pageSize", type = Integer.class, required = true)
    @JSON("recordCount")
    @JSON("items.(<#list introspectedTable.allColumns as allColumns>${allColumns.javaProperty}<#if allColumns_has_next>,</#if></#list>)")
    public PagedResult<${className}> findPage(RequestContext requestContext) {
        return ${className?uncap_first}Service.findPage(requestContext.getInteger("page"), requestContext.getInteger("pageSize"));
    }

    /**
     * 新增
     **/
    @RequestMapping(method = RequestMethod.POST)
    @Permitted
<#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="id"&&allColumns.javaProperty!="createTime" >
    @Param(name = "${allColumns.javaProperty}", type = ${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}.class)
    </#if>
</#list>
    @JSON("<#list introspectedTable.allColumns as allColumns>${allColumns.javaProperty}<#if allColumns_has_next>,</#if></#list>")
    public ${className} insert(RequestContext context) {
        return ${className?uncap_first}Service.insert(
<#assign isHave=false><#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="id"&&allColumns.javaProperty!="createTime" >
                <#if isHave>,</#if><#if allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="String"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Integer"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Long"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Boolean"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Byte">context.getOptional${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}("${allColumns.javaProperty}")<#else>context.getOptional("${allColumns.javaProperty}", ${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}.class)</#if>
        <#assign isHave=true>
    </#if>
</#list>
        );

    }

    /**
     * 修改
     **/
    @RequestMapping(value ="/{${introspectedTable.primaryKeyColumns[0].javaProperty}}", method = RequestMethod.PUT)
    @Permitted
<#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="createTime" >
    @Param(name = "${allColumns.javaProperty}", type = ${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}.class)
    </#if>
</#list>
    @JSON("*")
    public Map<String, Integer> update(RequestContext context) {
        return ImmutableMap.of("count", ${className?uncap_first}Service.update(
<#assign isHave=false><#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="createTime" >
        <#if allColumns.javaProperty=="id">
                <#if isHave>,</#if><#if allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="String"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Integer"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Long"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Boolean"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Byte">context.get${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}("${allColumns.javaProperty}")<#else>context.get("${allColumns.javaProperty}", ${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}.class)</#if>
        <#else>
                <#if isHave>,</#if><#if allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="String"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Integer"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Long"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Boolean"||allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments=="Byte">context.getOptional${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}("${allColumns.javaProperty}")<#else>context.getOptional("${allColumns.javaProperty}", ${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}.class)</#if>
        </#if>
        <#assign isHave=true>
    </#if>
</#list>
        ));

    }


}
