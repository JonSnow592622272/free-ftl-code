<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${diy_mapperJava_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${introspectedTable.tableConfiguration.domainObjectName}Mapper">

        <#--生成主键排在第一位，非主键排在后面，这里缩为一行是为了避免替换之后出现换行问题，注意！！！fileCreateType=2时,第一次生成会出现未换行的问题，再次生成一次即可恢复正常-->
    <resultMap id="BaseResultMap" type="${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${introspectedTable.tableConfiguration.domainObjectName}"><#list introspectedTable.primaryKeyColumns as primaryKey><id column="${primaryKey.actualColumnName}" jdbcType="${primaryKey.jdbcTypeName}" property="${primaryKey.javaProperty}"/></#list><#list introspectedTable.nonPrimaryKeyColumns as baseColumns><result column="${baseColumns.actualColumnName}" jdbcType="${baseColumns.jdbcTypeName}" property="${baseColumns.javaProperty}"/></#list></resultMap>

    <sql id="Base_Column_List">
        <#list introspectedTable.primaryKeyColumns as primaryKey>${primaryKey.actualColumnName},</#list><#list introspectedTable.nonPrimaryKeyColumns as baseColumns>${baseColumns.actualColumnName}<#if baseColumns_has_next>,</#if></#list>
    </sql>

</mapper>