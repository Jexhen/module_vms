package xin.liaozhixing.controller.advise;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import xin.liaozhixing.model.advise.MvAdviseModel;
import xin.liaozhixing.model.advise.MvAdviseResponseModel;
import xin.liaozhixing.model.base.BaseResponse;
import xin.liaozhixing.model.base.BaseTableResponse;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.service.advise.MvAdviseService;
import xin.liaozhixing.utils.EmptyUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/advise")
public class MvAdviseController {

    @Autowired
    private MvAdviseService service;

    /**
     * 建议人查询
     * @param example
     * @param request
     * @return
     */
    @RequestMapping("/getAdviseOfAdvisor")
    public @ResponseBody BaseTableResponse getAdviseOfAdvisor(MvAdviseModel example, HttpServletRequest request) {
        BaseTableResponse response = new BaseTableResponse();
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        if (example==null) {
            example = new MvAdviseModel();
        }
        example.setCreator(loginUser.getMvusId().toString());
        List<MvAdviseModel> existAdvise = service.getAdviseByExample(example);
        response.setCode(0);
        response.setMsg("");
        response.setData(existAdvise);
        response.setCount(existAdvise.size());
        return response;
    }

    /**
     * 被建议人查询
     * @param example
     * @param request
     * @return
     */
    @RequestMapping("/getAdviseOfAnswerer")
    public @ResponseBody BaseTableResponse getAdviseOfAnswerer(MvAdviseModel example, HttpServletRequest request) {
        BaseTableResponse response = new BaseTableResponse();
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        if (example==null) {
            example = new MvAdviseModel();
        }
        example.setMadvToUserId(loginUser.getMvusId().toString());
        List<MvAdviseModel> existAdvise = service.getAdviseByExample(example);
        response.setCode(0);
        response.setMsg("");
        response.setData(existAdvise);
        response.setCount(existAdvise.size());
        return response;
    }

    /**
     * 查询回复
     * @param example
     * @return
     */
    @RequestMapping("/getAdviseResponse")
    public @ResponseBody BaseResponse getAdviseResponse(MvAdviseResponseModel example) {
        BaseResponse response = new BaseResponse();
        List<MvAdviseResponseModel> existAdviseResponse = service.getAdviseResponseByExample(example);
        if (EmptyUtils.isNotEmpty(existAdviseResponse)) {
            response.setSuccess(true);
            response.setData(existAdviseResponse.get(0));
        } else {
            response.setSuccess(false);
            response.setMessage("该投诉建议还未被回复，请稍后");
        }
        return response;
    }

    /**
     * 新增投诉建议
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/addAdvise")
    public @ResponseBody BaseResponse addAdvise(MvAdviseModel model, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (EmptyUtils.isNotEmpty(model.getMadvTitle())) {
            if (EmptyUtils.isNotEmpty(model.getMadvContent())) {
                if (EmptyUtils.isNotEmpty(model.getMadvToUserId())) {
                    MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                    model.setCreator(loginUser.getMvusId().toString());
                    model.setModifier(loginUser.getMvusId().toString());
                    service.addAdvise(model);
                    response.setSuccess(true);
                    response.setMessage("投诉建议成功");
                } else {
                    response.setSuccess(false);
                    response.setMessage("处理回复人不能为空");
                }
            } else {
                response.setSuccess(false);
                response.setMessage("内容不能为空");
            }
        } else {
            response.setSuccess(false);
            response.setMessage("标题不能为空");
        }
        return response;
    }

    @RequestMapping("/addAdviseResponse")
    public @ResponseBody BaseResponse addAdviseResponse(MvAdviseResponseModel model, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (EmptyUtils.isNotEmpty(model.getMvarContent()))  {
            MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
            model.setCreator(loginUser.getMvusId().toString());
            model.setModifier(loginUser.getMvusId().toString());
            service.addAdviseResponse(model);
            MvAdviseModel example = new MvAdviseModel();
            example.setMadvId(model.getMvarAdivseId());
            example.setModifier(loginUser.getMvusId().toString());
            service.modifyAdvice(example);
            response.setSuccess(true);
            response.setMessage("回复成功");
        } else {
            response.setSuccess(false);
            response.setMessage("回复内容不能为空");
        }
        return response;
    }
}
