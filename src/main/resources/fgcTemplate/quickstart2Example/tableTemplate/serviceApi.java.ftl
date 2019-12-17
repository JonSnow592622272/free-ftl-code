package ${diy_serviceApi_targetPackage}.${introspectedTable.tableConfiguration.properties.module};

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.shotgun.my.api.consts.CommonConstant;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${tuofengTableName?cap_first};
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@FeignClient(name = CommonConstant.APPLICATION_NAME, contextId = "${tuofengTableName}ServiceApi", path = ${tuofengTableName?cap_first}ServiceApi.PATH)
public interface ${tuofengTableName?cap_first}ServiceApi {
    String PATH = "/${introspectedTable.fullyQualifiedTable.introspectedTableName}";

    @GetMapping("/testGet10")
    IPage<${tuofengTableName?cap_first}> testGet10();


}