<#assign isHaveEnum=false />
<#list introspectedTable.allColumns as allColumns>
    <#if allColumns.remarks!?length gt 0 && allColumns.remarks?index_of("#")!=-1>
        <#assign isHaveEnum=true />
        <#break>
    </#if>
</#list>
<#if isHaveEnum >
    package ${diy_enum_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.consts;
    /**
    * <p>
    * 表名：${introspectedTable.fullyQualifiedTable.introspectedTableName}
    * ${introspectedTable.remarks}
    * </p>
    *
    */
    import java.io.Serializable;
    import java.util.LinkedHashMap;
    import java.util.Map;

    public class ${tuofengTableName?cap_first}Const implements Serializable {

<#-- ----------  BEGIN 字段循环遍历  ---------->
    <#list introspectedTable.allColumns as allColumns>
        <#if allColumns.remarks!?length gt 0>
            <#if allColumns.remarks?index_of("#")!=-1 >
                /**
                * ${allColumns.remarks?substring(0,allColumns.remarks?index_of("#"))}
                **/
                public enum  ${allColumns.actualColumnName?upper_case}{

                <#assign _isNumber=(allColumns.jdbcTypeName=="INTEGER"||allColumns.jdbcTypeName=="INT"||allColumns.jdbcTypeName=="NUMBER")?string("1","0")/>
                <#assign _consts=allColumns.remarks?substring(allColumns.remarks?index_of("#")+1)/>
                <#list _consts?split(";") as item>
                    <#assign _subItem = ((item?trim)?replace("|",","))?split(",") />
                    <#if _subItem?size ==3>
                        <#if _isNumber=="1">
                            ${_subItem[2]}(${_subItem[0]},"${_subItem[1]}"),
                        <#else>
                            ${_subItem[2]}("${_subItem[0]}","${_subItem[1]}"),
                        </#if>

                    </#if>
                </#list>
                ;
                private  ${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}  value;

                private  String  text;

                ${allColumns.actualColumnName?upper_case}(${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments} value, String text){
                this.value = value;
                this.text = text;
                }

                public ${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments} getValue() {
                return value;
                }

                public void setValue(${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments} value) {
                this.value = value;
                }

                public String getText() {
                return text;
                }

                public void setText(String text) {
                this.text = text;
                }

                public static Map<${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}, String> valueMap = new LinkedHashMap<>();

                public static Map<${allColumns.fullyQualifiedJavaType.shortNameWithoutTypeArguments}, ${allColumns.actualColumnName?upper_case}> enumMap = new LinkedHashMap<>();

                static {

                ${allColumns.actualColumnName?upper_case}[] values = ${allColumns.actualColumnName?upper_case}.values();

                for (${allColumns.actualColumnName?upper_case} val : values) {
                valueMap.put(val.value, val.text);
                enumMap.put(val.value, val);
                }

                }
                }
            </#if>
        </#if>
    </#list>
    }
</#if>