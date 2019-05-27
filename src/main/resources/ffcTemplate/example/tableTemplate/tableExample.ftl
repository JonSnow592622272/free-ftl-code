表名字：${introspectedTable.fullyQualifiedTable.introspectedTableName}
表驼峰命名（从generatorConfig.xml的table标签传递过来）：${introspectedTable.tableConfiguration.domainObjectName}
表备注: ${introspectedTable.remarks}
xml传递属性（从generatorConfig.xml的table标签传递过来）：module:${introspectedTable.tableConfiguration.properties.module}


--------------------------表字段---------------------------
--------主键字段------------
<#list introspectedTable.primaryKeyColumns as primaryKey>
主键：
            数据库字段类型 : ${primaryKey.jdbcTypeName}
            数据库字段名称 : ${primaryKey.actualColumnName}

            java类型包名 : ${primaryKey.fullyQualifiedJavaType.packageName}
            java类型类名 : ${primaryKey.fullyQualifiedJavaType.shortNameWithoutTypeArguments}
            java类型包名+类名 : ${primaryKey.fullyQualifiedJavaType.fullyQualifiedNameWithoutTypeParameters}
            java属性名称 : ${primaryKey.javaProperty}
</#list>

--------非主键字段------------
<#list introspectedTable.nonPrimaryKeyColumns as baseColumns>
基础字段：
        数据库字段类型 : ${baseColumns.jdbcTypeName}
        数据库字段名称 : ${baseColumns.actualColumnName}

        java类型包名 : ${baseColumns.fullyQualifiedJavaType.packageName}
        java类型类名 : ${baseColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}
        java类型包名+类名 : ${baseColumns.fullyQualifiedJavaType.fullyQualifiedNameWithoutTypeParameters}
        java属性名称 : ${baseColumns.javaProperty}
</#list>



