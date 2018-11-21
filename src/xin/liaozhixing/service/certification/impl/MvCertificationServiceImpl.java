package xin.liaozhixing.service.certification.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xin.liaozhixing.mapper.certification.MvCertificationMapper;
import xin.liaozhixing.model.certification.MvCertificationModel;
import xin.liaozhixing.model.certification.MvCertificationTypeModel;
import xin.liaozhixing.service.certification.MvCertificationService;

import java.util.List;

@Service
public class MvCertificationServiceImpl implements MvCertificationService {

    @Autowired
    private MvCertificationMapper mapper;

    /**
     * 查询证明类型
     *
     * @param example
     * @return
     */
    @Override
    public List<MvCertificationTypeModel> getCertificationTypeByExample(MvCertificationTypeModel example) {
        return mapper.getCertificationTypeByExample(example);
    }

    /**
     * 新增证明
     *
     * @param certification
     */
    @Override
    public void addCertification(MvCertificationModel certification) {
        mapper.addCertification(certification);
    }

    /**
     * 查询证明
     *
     * @param example
     * @return
     */
    @Override
    public List<MvCertificationModel> getCertificationByExample(MvCertificationModel example) {
        return mapper.getCertificationByExample(example);
    }
}
