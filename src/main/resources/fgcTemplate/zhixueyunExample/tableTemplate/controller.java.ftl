package ${zxy_controller_package}<#if introspectedTable.tableConfiguration.properties.module??&& introspectedTable.tableConfiguration.properties.module!="">.${introspectedTable.tableConfiguration.properties.module}<#else></#if>;

import com.zxy.common.base.helper.PagedResult;
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



}
