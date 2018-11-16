package xin.liaozhixing.controller.article;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import xin.liaozhixing.model.article.MvArticleModel;
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
    public @ResponseBody BaseTableResponse getArticleByExample(MvArticleModel model, String articleType, HttpServletRequest request) {
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
        if (!mvusOrganizationId.equals("-1"))
            model.setMatcOrganizationId(mvusOrganizationId);
        model.setMatcType(articleType);// 文章类型
        List<MvArticleModel> existArticles = service.getArticleByExample(model);
        if (EmptyUtils.isNotEmpty(existArticles)) {
            response.setCode(0);
            response.setMsg("");
            response.setData(existArticles);
            response.setCount(existArticles.size());
        }
        return response;
    }

}
