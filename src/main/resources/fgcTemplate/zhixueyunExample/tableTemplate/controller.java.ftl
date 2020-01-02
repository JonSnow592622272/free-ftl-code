package ${diy_controller_targetPackage};

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

@Controller
@RequestMapping("/${introspectedTable.fullyQualifiedTable.introspectedTableName?substring(2)?replace("_","-")}")
public class ${tuofengTableName?substring(1)}Controller {

    private ${tuofengTableName?substring(1)}Service ${tuofengTableName?substring(1)?uncap_first}Service;

    @Autowired
    public void set${tuofengTableName?substring(1)}Service(${tuofengTableName?substring(1)}Service ${tuofengTableName?substring(1)?uncap_first}Service) {
        this.${tuofengTableName?substring(1)?uncap_first}Service = ${tuofengTableName?substring(1)?uncap_first}Service;
    }

    /*
     * @author wulm
     * @desc 查询年度配额列表
     **/
    @RequestMapping(method = RequestMethod.GET)
    @Permitted
    @Param(name = "page", type = Integer.class, required = true)
    @Param(name = "pageSize", type = Integer.class, required = true)
    @JSON("recordCount")
    @JSON("items.(id,year,subjectName,quotaTotal,quotaUsed,quotaBalance,upperLimit)")
    @JSON("items.quotaBrands.(id,${tuofengTableName?substring(1)?uncap_first}Id,brandValue,label,quotaTotal,quotaUsed,quotaBalance)")
    public PagedResult<${tuofengTableName?substring(1)}> findPage(RequestContext requestContext) {
        //年度科目数据
        return ${tuofengTableName?substring(1)?uncap_first}Service
                .findPage(requestContext.getInteger("page"), requestContext.getInteger("pageSize"));
    }

    @RequestMapping(method = RequestMethod.POST)
    @Permitted
    @Param(name = "year", type = Integer.class, required = true)
    @Param(name = "trainingSubjectId", type = String.class, required = true)
    @Param(name = "quotaTotal", type = Integer.class, required = true)
    @JSON("*")
    public boolean insert(RequestContext context) {

        ${tuofengTableName?substring(1)?uncap_first}Service.insert(context.get("year", Integer.class),
                context.get("trainingSubjectId", String.class),
                context.get("quotaTotal", Integer.class));

        return true;
    }


    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    @Permitted
    @Param(name = "id", type = String.class, required = true)
    @Param(name = "quotaTotal", type = Integer.class, required = true)
    @JSON("*")
    public boolean update(RequestContext context) {

        ${tuofengTableName?substring(1)?uncap_first}Service.update(context.get("id", String.class), context.get("quotaTotal", Integer.class));

        return true;
    }


}
