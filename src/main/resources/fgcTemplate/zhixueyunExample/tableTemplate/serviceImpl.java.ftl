<#include "config/tableConfig.ftl">
package com.zxy.product.training.service.support;

import com.zxy.common.dao.support.CommonDao;
import com.zxy.product.training.api.QuotaSubjectService;
import com.zxy.product.training.entity.QuotaSubject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.zxy.product.training.jooq.Tables.QUOTA_SUBJECT;

@Service
public class QuotaSubjectServiceSupport implements QuotaSubjectService {

    private CommonDao<QuotaSubject> quotaSubjectDao;

    @Autowired
    public void setQuotaSubjectDao(CommonDao<QuotaSubject> quotaSubjectDao) {
        this.quotaSubjectDao = quotaSubjectDao;
    }

    @Override
    public void delete(String id) {
        quotaSubjectDao.delete(QUOTA_SUBJECT.ID.eq(id));
    }


}
