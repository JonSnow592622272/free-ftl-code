# free-generator-code


基于FreeMarker、mybatis-generator的通用代码生成器，生成不仅限于java代码，还可生成任意你想要的语言代码。使用非常简单，你不需要编写java代码，内部包含许多ftl案例，你可以参考ftl案例来扩展自定义ftl模板。


##!!!初始案例sql脚本!!!
+ **数据库初始脚本（数据库名为：nimei）.sql**

##!!!参考案例!!!
+ 案例1：StartUpQuickstart.java
  + 配置所在目录：resources\fgcDbConfig\quickstartConfig
  + 模板所在目录：resources\fgcTemplate\quickstartExample
+ 案例2：StartUpQuickstart2.java
  + 配置所在目录：resources\fgcDbConfig\quickstart2Config
  + 模板所在目录：resources\fgcTemplate\quickstart2Example
+ ....

----------------
#####清除空文件夹下的“.gitxxx”文件（用Git Bash Here打开执行）
find ./ -type f -name '.gitxxx' -delete

#####使能够上传空文件夹（用Git Bash Here打开执行）
find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitxxx \;

+ 案例1效果图：
  +   ![image](https://github.com/JonSnow592622272/my-image/blob/master/free-generator-code/anli1.jpg)
