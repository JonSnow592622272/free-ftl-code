<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.yunyihenkey.basedao.malldb.basemapper.MallMoneyFlowBaseMapper">

        <#--生成主键排在第一位，非主键排在后面，这里缩为一行是为了避免替换之后出现换行问题-->
    <resultMap id="BaseResultMap" type="com.my.haha.${introspectedTable.tableConfiguration.domainObjectName}"><#list introspectedTable.primaryKeyColumns as primaryKey><id column="${primaryKey.actualColumnName}" jdbcType="${primaryKey.jdbcTypeName}" property="${primaryKey.javaProperty}"/></#list><#list introspectedTable.nonPrimaryKeyColumns as baseColumns><result column="${baseColumns.actualColumnName}" jdbcType="${baseColumns.jdbcTypeName}" property="${baseColumns.javaProperty}"/></#list></resultMap>

    <sql id="Base_Column_List">
        <#list introspectedTable.primaryKeyColumns as primaryKey>${primaryKey.actualColumnName},</#list><#list introspectedTable.nonPrimaryKeyColumns as baseColumns>${baseColumns.actualColumnName}<#if baseColumns_has_next>,</#if></#list>
    </sql>

</mapper>