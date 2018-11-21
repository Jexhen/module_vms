package xin.liaozhixing.service.certification;

import xin.liaozhixing.model.certification.MvCertificationModel;
import xin.liaozhixing.model.certification.MvCertificationTypeModel;

import java.util.List;

public interface MvCertificationService {

    /**
     * 查询证明类型
     * @param example
     * @return
     */
    List<MvCertificationTypeModel> getCertificationTypeByExample(MvCertificationTypeModel example);

    /**
     * 新增证明
     * @param certification
     */
    void addCertification(MvCertificationModel certification);

    /**
     * 查询证明
     * @param example
     * @return
     */
    List<MvCertificationModel> getCertificationByExample(MvCertificationModel example);

    /**
     * 删除证明
     * @param ids
     */
    void removeCertification(Long[] ids);

    /**
     * 修改证明
     * @param certification
     */
    void modifyCertification(MvCertificationModel certification);
}
