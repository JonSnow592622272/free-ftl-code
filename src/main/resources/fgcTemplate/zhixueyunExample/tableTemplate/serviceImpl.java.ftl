<#include "config/tableConfig.ftl">
package ${zxy_service_impl_package}<#if introspectedTable.tableConfiguration.properties.serviceImpl_module??&& introspectedTable.tableConfiguration.properties.serviceImpl_module!="">.${introspectedTable.tableConfiguration.properties.serviceImpl_module}<#else></#if>;

import com.zxy.common.base.helper.PagedResult;
import com.zxy.common.dao.Fields;
import com.zxy.common.dao.support.CommonDao;
import ${zxy_service_package}<#if introspectedTable.tableConfiguration.properties.service_module??&& introspectedTable.tableConfiguration.properties.service_module!="">.${introspectedTable.tableConfiguration.properties.service_module}<#else></#if>.${tuofengTableName?substring(1)}Service;
import com.zxy.product.${zxy_java_package}.entity.${tuofengTableName?substring(1)};
import org.jooq.Condition;
import org.jooq.Field;
import org.jooq.Record;
import org.jooq.SelectConditionStep;
import org.jooq.SelectSelectStep;
import org.jooq.impl.DSL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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

    @Override
    public ${tuofengTableName?substring(1)} findById(${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments} ${introspectedTable.primaryKeyColumns[0].javaProperty}) {
        return ${tuofengTableName?substring(1)?uncap_first}Dao.getOptional(${introspectedTable.primaryKeyColumns[0].javaProperty}).orElse(null);
    }

    @Override
    public PagedResult<${tuofengTableName?substring(1)}> findPage(Integer page, Integer pageSize){
        return ${tuofengTableName?substring(1)?uncap_first}Dao.execute(context -> {
            //组装条件
            List<Condition> conditions = Stream.of(Optional.of(DSL.trueCondition())/*TODO ....*/)
                    .filter(Optional::isPresent).map(Optional::get).collect(Collectors.toList());

            //组装from
            Function<SelectSelectStep<Record>, SelectConditionStep<Record>> stepFunc = a -> a
                    .from(${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case}).where(conditions);

            int count = stepFunc.apply(context.select(Fields.start().add(${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case}.${introspectedTable.primaryKeyColumns[0].actualColumnName?substring(2)?upper_case}.count()).end()))
                    .fetchOne().getValue(0, Integer.class);

            List<${tuofengTableName?substring(1)}> ${tuofengTableName?substring(1)?uncap_first}s = count == 0 ? new ArrayList<>() : stepFunc.apply(context
                    .select(Fields.start()<#list introspectedTable.allColumns as allColumns>
                            .add(${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case}.${allColumns.actualColumnName?substring(2)?upper_case})</#list>
                            .end())).limit((page - 1) * pageSize, pageSize).fetchInto(${tuofengTableName?substring(1)}.class);

            return PagedResult.create(count, ${tuofengTableName?substring(1)?uncap_first}s);
        });
    }

    @Override
    public ${tuofengTableName?substring(1)} insert(
<#assign isHave=false><#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="id"&&allColumns.javaProperty!="createTime" >
        <#if isHave>,</#if>Optional<${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}> ${allColumns.javaProperty}
        <#assign isHave=true>
    </#if>
</#list>
    ) {
        ${tuofengTableName?substring(1)} ${tuofengTableName?substring(1)?uncap_first} = new ${tuofengTableName?substring(1)}();
        ${tuofengTableName?substring(1)?uncap_first}.forInsert();

<#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="id"&&allColumns.javaProperty!="createTime" >
        ${allColumns.javaProperty}.ifPresent(${tuofengTableName?substring(1)?uncap_first}::set${allColumns.javaProperty?cap_first});
    </#if>
</#list>

        return ${tuofengTableName?substring(1)?uncap_first}Dao.insert(${tuofengTableName?substring(1)?uncap_first});
    }

    @Override
    public int update(
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
    ) {
        return ${tuofengTableName?substring(1)?uncap_first}Dao.execute(context -> {
            //设值封装
            Map<Field<?>, Object> setMap = new HashMap<>();

<#list introspectedTable.allColumns as allColumns>
    <#if allColumns.javaProperty!="id"&&allColumns.javaProperty!="createTime" >
            ${allColumns.javaProperty}.ifPresent(v -> setMap.put(${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case}.${allColumns.actualColumnName?substring(2)?upper_case}, v));
    </#if>
</#list>

            return setMap.size() == 0 ? 0 : context.update(${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case}).set(setMap)
                    .where(${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?upper_case}.${introspectedTable.primaryKeyColumns[0].actualColumnName?substring(2)?upper_case}.eq(${introspectedTable.primaryKeyColumns[0].javaProperty})).execute();

        });
    }


}
