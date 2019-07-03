!!!!!注意：
!!!!!
!!!!!tableTemplate的ftl可以使用 anInterface, topLevelClass, introspectedTable 三个对象
!!!!!fieldTemplate的ftl可以使用 field, topLevelClass, introspectedColumn, introspectedTable, modelClassType 5个对象
!!!!!
!!!!!mybatis-generator部分属性和get方法没有提供，可以找到其他方法代替
!!!!!比如：primaryKeyColumns属性——>有提供getPrimaryKeyColumns()
!!!!!        getNonPrimaryKeyColumns()方法可以获取主键字段。
!!!!!
!!!!!

表名字：${introspectedTable.fullyQualifiedTable.introspectedTableName}
表驼峰命名（从generatorConfig.xml的table标签传递过来）：${tuofengTableName}:::::::首字母大写驼峰：${tuofengTableName?cap_first}
表备注: ${introspectedTable.remarks}
xml传递属性（从generatorConfig.xml的table标签传递过来）：module:${introspectedTable.tableConfiguration.properties.module}


-----------------------------------------------------表字段------------------------------------------------------
--------------------------------------------主键字段------------------------------------
<#list introspectedTable.primaryKeyColumns as primaryKey>
主键：
            数据库字段类型 : ${primaryKey.jdbcTypeName}
            数据库字段名称 : ${primaryKey.actualColumnName}
            数据库字段备注 : ${primaryKey.remarks}




            java类型包名 : ${primaryKey.fullyQualifiedJavaType.packageName}
            java类型类名 : ${primaryKey.fullyQualifiedJavaType.shortNameWithoutTypeArguments}
            java类型包名+类名 : ${primaryKey.fullyQualifiedJavaType.fullyQualifiedNameWithoutTypeParameters}
            java属性名称 : ${primaryKey.javaProperty}
</#list>

--------------------------------------------非主键字段------------------------------------
<#list introspectedTable.nonPrimaryKeyColumns as baseColumns>
基础字段：
        数据库字段类型 : ${baseColumns.jdbcTypeName}
        数据库字段名称 : ${baseColumns.actualColumnName}
        数据库字段备注 : ${baseColumns.remarks}

    java类型包名 : ${baseColumns.fullyQualifiedJavaType.packageName}
        java类型类名 : ${baseColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}
        java类型包名+类名 : ${baseColumns.fullyQualifiedJavaType.fullyQualifiedNameWithoutTypeParameters}
        java属性名称 : ${baseColumns.javaProperty}
</#list>


--------------------------------所有字段（主键字段+非主键字段）------------------------

<#list introspectedTable.allColumns as allColumns>
基础字段：
    数据库字段类型 : ${allColumns.jdbcTypeName}
    数据库字段名称 : ${allColumns.actualColumnName}
    数据库字段备注 : ${allColumns.remarks}

    java类型包名 : ${allColumns.fullyQualifiedJavaType.packageName}
    java类型类名 : ${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}
    java类型包名+类名 : ${allColumns.fullyQualifiedJavaType.fullyQualifiedNameWithoutTypeParameters}
    java属性名称 : ${allColumns.javaProperty}
</#list>
