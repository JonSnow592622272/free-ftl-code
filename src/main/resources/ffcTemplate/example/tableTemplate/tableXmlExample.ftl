<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.yunyihenkey.basedao.malldb.basemapper.MallMoneyDelayBaseMapper">
    <resultMap id="BaseResultMap" type="com.yunyihenkey.basedao.malldb.basevo.MallMoneyDelay">
        <id column="id" jdbcType="BIGINT" property="id"/>
        <result column="money_user_id" jdbcType="BIGINT" property="moneyUserId"/>
        <result column="account_type" jdbcType="INTEGER" property="accountType"/>
    </resultMap>
    <sql id="Base_Column_List">
        id, money_user_id, account_type, title, order_money, money, money_type, relation_id,
        remarks, create_time, sign, old_money, postage_fee
    </sql>

</mapper>