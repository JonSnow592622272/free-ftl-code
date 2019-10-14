#### 该目录是从mybatis-plus的ftl模板拷贝过来<br/>
####参考AutoGenerator类下的模板<br/>
        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-generator</artifactId>
            <version>3.2.0</version>
        </dependency>

!注意：扩展自定义的模板，该扩展模板每个表一定要设置一个模块，比如generatorConfig.xml中设置<br/>

        <table tableName="test_scores">
            <property name="module" value="study模块"/>
        </table>