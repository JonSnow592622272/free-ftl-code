package ${diy_serviceApi_targetPackage}.${introspectedTable.tableConfiguration.properties.module};

import com.shotgun.my.api.consts.CommonConstant;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;

@FeignClient(name = CommonConstant.APPLICATION_NAME)
@RequestMapping(MyStudentServiceApi.PATH)
public interface ${tuofengTableName?cap_first}ServiceApi {
    String PATH = "/${introspectedTable.fullyQualifiedTable.introspectedTableName}";


}