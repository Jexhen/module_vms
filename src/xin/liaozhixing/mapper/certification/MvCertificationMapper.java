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
}
