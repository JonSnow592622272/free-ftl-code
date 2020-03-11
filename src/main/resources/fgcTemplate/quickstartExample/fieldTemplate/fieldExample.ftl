!!!!!注意：
!!!!!
!!!!!tableTemplate的ftl可以使用 anInterface, topLevelClass, introspectedTable 三个对象
!!!!!fieldTemplate的ftl可以使用 field, topLevelClass, introspectedColumn, introspectedTable, modelClassType 5个对象
!!!!!
!!!!!mybatis-generator部分属性和get方法没有提供，可以找到其他方法代替
!!!!!比如：primaryKeyColumns属性——————>getPrimaryKeyColumns()
!!!!!        getNonPrimaryKeyColumns()方法可以获取非主键字段。
!!!!!
!!!!!

表名字：${introspectedTable.fullyQualifiedTable.introspectedTableName}
表驼峰命名：${className?uncap_first}:::::::首字母大写驼峰：${className}
表备注: ${introspectedTable.remarks}
xml传递属性（从generatorConfig.xml的table标签传递过来）：module:${introspectedTable.tableConfiguration.properties.module}




字段：
        数据库字段类型 : ${introspectedColumn.jdbcTypeName}
        数据库字段名称 : ${introspectedColumn.actualColumnName}
        数据库字段备注 : ${introspectedColumn.remarks}


        java类型包名 : ${introspectedColumn.fullyQualifiedJavaType.packageName}
        java类型类名 : ${introspectedColumn.fullyQualifiedJavaType.shortNameWithoutTypeArguments}
        java类型包名+类名 : ${introspectedColumn.fullyQualifiedJavaType.fullyQualifiedNameWithoutTypeParameters}
        java属性名称 : ${introspectedColumn.javaProperty}