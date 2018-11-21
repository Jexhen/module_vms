package xin.liaozhixing.controller.certification;

import com.fasterxml.jackson.databind.ser.Serializers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import xin.liaozhixing.model.base.BaseResponse;
import xin.liaozhixing.model.base.BaseTableResponse;
import xin.liaozhixing.model.certification.MvCertificationModel;
import xin.liaozhixing.model.certification.MvCertificationTypeModel;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.service.certification.MvCertificationService;
import xin.liaozhixing.utils.BasePathUtils;
import xin.liaozhixing.utils.EmptyUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/certification")
public class MvCertificationController {

    @Autowired
    private MvCertificationService service;

    @RequestMapping("/upload")
    public @ResponseBody BaseResponse uploadAttachment(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (null != file) {
            String originalFilename = file.getOriginalFilename();// 文件原名称
            String fileName = BasePathUtils.getPath("yyyyMMddHHmmss")+
                    Integer.toHexString(new Random().nextInt()) +"."+ originalFilename.
                    substring(originalFilename.lastIndexOf(".") + 1);
            String pat = request.getSession().getServletContext().getRealPath("/") + "/";//获取文件保存路径
            String sqlPath="static/attachments/"+BasePathUtils.getPath("yyyyMMdd")+"/";

            File fileDir=new File(pat+sqlPath);
            if (!fileDir.exists()) { //如果不存在 则创建
                fileDir.mkdirs();
            }
            String path=pat+sqlPath+fileName;
            File localFile = new File(path);
            try {
                file.transferTo(localFile);
                MvCertificationModel model = new MvCertificationModel();
                model.setMctfAttachmentName(originalFilename);// 附件原名称
                model.setMctfAttachmentUrl(sqlPath + fileName);// 附件路径
                response.setSuccess(true);
                response.setData(model);
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            response.setSuccess(false);
            response.setMessage("文件为空");
        }
        return response;
    }

    /**
     * 通过ID查找证明类型
     * @param example
     * @return
     */
    @RequestMapping("/getCertificationType")
    public @ResponseBody BaseResponse getCertificationType(MvCertificationTypeModel example) {
        BaseResponse response = new BaseResponse();
        List<MvCertificationTypeModel> existCertificationTypes = service.getCertificationTypeByExample(example);
        if (EmptyUtils.isNotEmpty(existCertificationTypes)) {
            response.setSuccess(true);
            response.setData(existCertificationTypes.get(0));
        } else {
            response.setSuccess(false);
            response.setMessage("找不到证明类型");
        }
        return response;
    }

    /**
     * 新增证明
     * @param certification
     * @param request
     * @return
     */
    @RequestMapping("/addCertification")
    public @ResponseBody BaseResponse addCertification(MvCertificationModel certification, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (EmptyUtils.isNotEmpty(certification.getMctfName())) {
            if (certification.getMctfCertificationTypeId()!=null) {
                MvCertificationTypeModel example = new MvCertificationTypeModel();
                example.setMvctId(Long.valueOf(certification.getMctfCertificationTypeId()));
                List<MvCertificationTypeModel> certificationTypeByExample = service.getCertificationTypeByExample(example);
                if (EmptyUtils.isNotEmpty(certificationTypeByExample)) {
                    // 如果该证明类型需要上传附件，校验附件
                    if (certificationTypeByExample.get(0).getMvctIsNeedAttachment() == 1) {
                        if (EmptyUtils.isEmpty(certification.getMctfAttachmentName())) {
                            response.setSuccess(false);
                            response.setMessage("该证明类型需要上传附件");
                            return response;
                        }
                    }
                    MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                    certification.setCreator(loginUser.getMvusId().toString());
                    certification.setModifier(loginUser.getMvusId().toString());
                    service.addCertification(certification);
                    response.setSuccess(true);
                    response.setMessage("申请成功");
                } else {
                    response.setSuccess(false);
                    response.setMessage("没有该证明类型");
                }
            } else {
                response.setSuccess(false);
                response.setMessage("请选择证明类型");
            }
        } else {
            response.setSuccess(false);
            response.setMessage("证明名称不能为空");
        }
        return response;
    }

    /**
     * 审核人查询证明
     * @param certification
     * @param request
     * @return
     */
    @RequestMapping("/getCertificationForAuditor")
    public @ResponseBody BaseTableResponse getCertificationForAuditor(MvCertificationModel certification, HttpServletRequest request) {
        BaseTableResponse response = new BaseTableResponse();
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        if (certification==null)
            certification = new MvCertificationModel();
        certification.setAuditor(loginUser.getMvusId());
        List<MvCertificationModel> certificationByExample = service.getCertificationByExample(certification);
        response.setCode(0);
        response.setMsg("");
        response.setData(certificationByExample);
        response.setCount(certificationByExample.size());
        return response;
    }

    /**
     * 申请人查询证明
     * @param certification
     * @param request
     * @return
     */
    @RequestMapping("/getCertificationForApplicant")
    public @ResponseBody BaseTableResponse getCertificationForApplicant(MvCertificationModel certification, HttpServletRequest request) {
        BaseTableResponse response = new BaseTableResponse();
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        if (certification==null)
            certification = new MvCertificationModel();
        if (EmptyUtils.isNotEmpty(certification.getMctfName())) {
            try {
                String decodeName = new String(certification.getMctfName().getBytes("ISO-8859-1"),"UTF-8");
                certification.setMctfName(decodeName);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        certification.setCreator(loginUser.getMvusId().toString());
        List<MvCertificationModel> certificationByExample = service.getCertificationByExample(certification);
        response.setCode(0);
        response.setMsg("");
        response.setData(certificationByExample);
        response.setCount(certificationByExample.size());
        return response;
    }

    /**
     * 删除证明
     * @param ids
     * @return
     */
    @RequestMapping("/removeCertification")
    public @ResponseBody BaseResponse removeCertification(@RequestParam("ids[]") Long[] ids) {
        BaseResponse response = new BaseResponse();
        service.removeCertification(ids);
        response.setSuccess(true);
        response.setMessage("删除成功");
        return response;
    }

    @RequestMapping("/updateCertification")
    public @ResponseBody BaseResponse updateCertification(MvCertificationModel certification, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (certification!=null && certification.getMctfId()!=null) {
            // 通过
            if (EmptyUtils.isNotEmpty(certification.getMctfStatus())){
                MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                certification.setModifier(loginUser.getMvusId().toString());
                service.modifyCertification(certification);
                response.setSuccess(true);
                response.setMessage("操作成功");
            } else {
                response.setSuccess(false);
                response.setMessage("状态不允许为空");
            }
        } else {
            response.setSuccess(false);
            response.setMessage("ID不能为空");
        }
        return response;
    }


    /**
     * 通过ID查找证明类型
     * @param example
     * @return
     */
    @RequestMapping("/getCertificationTypeByExample")
    public @ResponseBody BaseTableResponse getCertificationTypeByExample(MvCertificationTypeModel example, HttpServletRequest request) {
        BaseTableResponse response = new BaseTableResponse();
        if (example==null)
            example = new MvCertificationTypeModel();
        // 只能查询对应组织的证明类型
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        example.setOrganizationId(loginUser.getMvusOrganizationId());
        List<MvCertificationTypeModel> existCertificationTypes = service.getCertificationTypeByExample(example);
        response.setCode(0);
        response.setMsg("");
        response.setData(existCertificationTypes);
        response.setCount(existCertificationTypes.size());
        return response;
    }

    @RequestMapping("/modifyCertificationType")
    public @ResponseBody BaseResponse modifyCertificationType(MvCertificationTypeModel certificationTypeModel, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        certificationTypeModel.setModifier(loginUser.getMvusId().toString());
        service.modifyCertificationType(certificationTypeModel);
        response.setSuccess(true);
        response.setMessage("修改成功");
        return response;
    }

    @RequestMapping("/addCertificationType")
    public @ResponseBody BaseResponse addCertificationType(MvCertificationTypeModel type, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        type.setCreator(loginUser.getMvusId().toString());
        service.addCertificationType(type);
        response.setSuccess(true);
        response.setMessage("新增成功");
        return response;
    }

    /**
     * 删除证明类型
     * @param ids
     * @return
     */
    @RequestMapping("/removeCertificationType")
    public @ResponseBody BaseResponse removeCertificationType(@RequestParam("ids[]") Long[] ids) {
        BaseResponse response = new BaseResponse();
        service.removeCertificationType(ids);
        response.setSuccess(true);
        response.setMessage("删除成功");
        return response;
    }
}
