# free-generator-code


基于FreeMarker、mybatis-generator的通用代码生成器，生成不仅限于java代码，还可生成任意你想要的语言代码。使用非常简单，你不需要编写任何java代码，内部包含许多ftl案例，你可以参考ftl案例来扩展自定义ftl模板。


##!!!初始案例sql脚本!!!
 **数据库初始脚本（数据库名为：nimei）.sql**

##!!!参考案例!!!
+ 案例：StartUpQuickstart
  + 配置目录：resources\fgcDbConfig\quickstartConfig
  + 模板目录：resources\fgcTemplate\quickstartExample
+ 案例：StartUpQuickstart2
  + 配置目录：resources\fgcDbConfig\quickstart2Config
  + 模板目录：resources\fgcTemplate\quickstart2Example
+ ....

----------------
#####清除空文件夹下的“.gitxxx”文件（用Git Bash Here打开执行）
find ./ -type f -name '.gitxxx' -delete

#####使能够上传空文件夹（用Git Bash Here打开执行）
find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitxxx \;
