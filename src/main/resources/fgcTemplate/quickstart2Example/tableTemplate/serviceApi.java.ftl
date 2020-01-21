package ${diy_serviceApi_targetPackage}.${introspectedTable.tableConfiguration.properties.module};

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.shotgun.my.api.config.FeignConfig;
import com.shotgun.my.api.consts.CommonConstant;
import ${diy_model_targetPackage}.${introspectedTable.tableConfiguration.properties.module}.${className};
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = CommonConstant.APPLICATION_NAME, contextId = "${className?uncap_first}ServiceApi", path =
        CommonConstant.APPLICATION_SERVLET_CONTEXT_PATH + ${className}ServiceApi.PATH, configuration =
        FeignConfig.class)
public interface ${className}ServiceApi {
    String PATH = "/${introspectedTable.fullyQualifiedTable.introspectedTableName}";

    @GetMapping("/testGet10")
    IPage<${className}> testGet10();


}