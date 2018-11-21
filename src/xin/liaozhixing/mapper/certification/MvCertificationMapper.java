package xin.liaozhixing.mapper.certification;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.certification.MvCertificationModel;
import xin.liaozhixing.model.certification.MvCertificationTypeModel;

import java.util.List;

public interface MvCertificationMapper {

    /**
     * 查询证明类型
     * @param example
     * @return
     */
    List<MvCertificationTypeModel> getCertificationTypeByExample(@Param("example") MvCertificationTypeModel example);

    /**
     * 新增证明
     * @param certification
     */
    void addCertification(@Param("certification") MvCertificationModel certification);

    /**
     * 查询证明
     */
    List<MvCertificationModel> getCertificationByExample(@Param("example") MvCertificationModel example);

    /**
     * 删除证明
     * @param ids
     */
    void removeCertification(@Param("ids") Long[] ids);

    /**
     * 修改证明
     * @param certification
     */
    void modifyCertification(@Param("certification") MvCertificationModel certification);

    /**
     * 增加证明类型
     * @param type
     */
    void addCertificationType(@Param("type") MvCertificationTypeModel type);

    /**
     * 删除证明类型
     * @param ids
     */
    void removeCertificationType(@Param("ids") Long[] ids);

    /**
     * 修改证明类型
     * @param type
     */
    void modifyCertificationType(@Param("type") MvCertificationTypeModel type);
}
