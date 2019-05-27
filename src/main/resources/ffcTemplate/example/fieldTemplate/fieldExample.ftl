表名字：${introspectedTable.fullyQualifiedTable.introspectedTableName}
表驼峰命名（从generatorConfig.xml的table标签传递过来）：${introspectedTable.tableConfiguration.domainObjectName}
表备注: ${introspectedTable.remarks}
xml传递属性（从generatorConfig.xml的table标签传递过来）：module:${introspectedTable.tableConfiguration.properties.module}





字段：
数据库字段类型 : ${introspectedColumn.jdbcTypeName}
数据库字段名称 : ${introspectedColumn.actualColumnName}

java类型包名 : ${introspectedColumn.fullyQualifiedJavaType.packageName}
java类型类名 : ${introspectedColumn.fullyQualifiedJavaType.shortNameWithoutTypeArguments}
java类型包名+类名 : ${introspectedColumn.fullyQualifiedJavaType.fullyQualifiedNameWithoutTypeParameters}
java属性名称 : ${introspectedColumn.javaProperty}