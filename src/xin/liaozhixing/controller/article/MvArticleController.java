package xin.liaozhixing.controller.article;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import xin.liaozhixing.model.article.MvArticleModel;
import xin.liaozhixing.model.base.BaseResponse;
import xin.liaozhixing.model.base.BaseTableResponse;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.service.article.MvArticleService;
import xin.liaozhixing.utils.EmptyUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping("/article")
public class MvArticleController {

    @Autowired
    private MvArticleService service;

    /**
     * 查询文章
     * @param model 查询条件
     * @param articleType 文章类型
     * @param request
     * @return
     */
    @RequestMapping("/getArticles")
    public @ResponseBody BaseTableResponse getArticleByExample(MvArticleModel model, String articleType, String isEdit, HttpServletRequest request) {
        BaseTableResponse response = new BaseTableResponse();
        // 解决layui get提交问题
        if (model!=null && EmptyUtils.isNotEmpty(model.getMatcTitle())) {
            try {
                String decodeTitle = new String(model.getMatcTitle().getBytes("ISO-8859-1"), "UTF-8");
                model.setMatcTitle(decodeTitle);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        // 根据权限查看对应组织的文章
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        String mvusOrganizationId = loginUser.getMvusOrganizationId().toString();
        // 非超级管理员才需要设置管理组织
        if (!mvusOrganizationId.equals("-1"))
            model.setMatcOrganizationId(mvusOrganizationId);
        model.setMatcType(articleType);// 文章类型
        List<MvArticleModel> existArticles;
        if ("1".equals(isEdit)) {
            existArticles = service.getArticleAsEdit(model);
        } else {
            existArticles = service.getArticleByExample(model);
        }
        response.setCode(0);
        response.setMsg("");
        response.setData(existArticles);
        response.setCount(existArticles.size());

        return response;
    }

    @RequestMapping("/addArticle")
    public @ResponseBody BaseResponse addArticle(MvArticleModel article, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (EmptyUtils.isNotEmpty(article.getMatcTitle())) {
            if (EmptyUtils.isNotEmpty(article.getMatcContent())) {
                if (EmptyUtils.isNotEmpty(article.getMatcType())) {
                    MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                    String mvusOrganizationId = loginUser.getMvusOrganizationId().toString();
                    article.setMatcOrganizationId(mvusOrganizationId);
                    article.setCreator(loginUser.getMvusId().toString());
                    article.setModifier(loginUser.getMvusId().toString());
                    service.addArticle(article);
                    response.setSuccess(true);
                    response.setMessage("发布成功");
                } else {
                    response.setSuccess(false);
                    response.setMessage("文章类型不能为空");
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

    @RequestMapping("/modifyArticle")
    public @ResponseBody BaseResponse modifyArticle(MvArticleModel article, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (EmptyUtils.isNotEmpty(article.getMatcTitle())) {
            if (EmptyUtils.isNotEmpty(article.getMatcContent())) {
                MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                article.setModifier(loginUser.getMvusId().toString());
                service.modifyArticle(article);
                response.setSuccess(true);
                response.setMessage("修改成功");
            } else {
                response.setMessage("内容不能为空");
            }
        } else {
            response.setSuccess(false);
            response.setMessage("标题不能为空");
        }
        return response;
    }

    @RequestMapping("/removeArticle")
    public @ResponseBody BaseResponse removeArticle(@RequestParam("ids[]") Long[] ids) {
        BaseResponse response = new BaseResponse();
        service.removeArticle(ids);
        response.setSuccess(true);
        response.setMessage("删除成功");
        return response;
    }
}
