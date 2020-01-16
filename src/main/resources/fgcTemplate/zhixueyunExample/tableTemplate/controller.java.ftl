<#include "config/tableConfig.ftl">

//名人:${linkman}
package ${zxy_controller_package}<#if introspectedTable.tableConfiguration.properties.module??&& introspectedTable.tableConfiguration.properties.module!="">.${introspectedTable.tableConfiguration.properties.module}<#else></#if>;

import com.google.common.collect.ImmutableMap;
import com.zxy.common.restful.RequestContext;
import com.zxy.common.restful.annotation.Param;
import com.zxy.common.restful.json.JSON;
import com.zxy.common.restful.security.Permitted;
import com.zxy.product.training.api.${tuofengTableName?substring(1)}Service;
import com.zxy.product.training.entity.${tuofengTableName?substring(1)};
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
public class ${tuofengTableName?substring(1)}Controller {

    private ${tuofengTableName?substring(1)}Service ${tuofengTableName?substring(1)?uncap_first}Service;

    @Autowired
    public void set${tuofengTableName?substring(1)}Service(${tuofengTableName?substring(1)}Service ${tuofengTableName?substring(1)?uncap_first}Service) {
        this.${tuofengTableName?substring(1)?uncap_first}Service = ${tuofengTableName?substring(1)?uncap_first}Service;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/{${introspectedTable.primaryKeyColumns[0].javaProperty}}", method = RequestMethod.DELETE)
    @Permitted
    @Param(name = "${introspectedTable.primaryKeyColumns[0].javaProperty}", type = ${introspectedTable.primaryKeyColumns[0].fullyQualifiedJavaType.shortNameWithoutTypeArguments}.class, required = true)
    @JSON("*")
    public Map<String, Integer> delete(RequestContext requestContext) {
        quotaSubjectService.delete(requestContext.getString("${introspectedTable.primaryKeyColumns[0].javaProperty}"));
        return ImmutableMap.of("count", 1);
    }


}
