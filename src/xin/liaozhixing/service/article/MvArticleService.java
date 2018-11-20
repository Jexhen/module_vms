package xin.liaozhixing.service.article;

import xin.liaozhixing.model.article.MvArticleModel;

import java.util.List;

public interface MvArticleService {

    List<MvArticleModel> getArticleByExample(MvArticleModel model);

    List<MvArticleModel> getArticleAsEdit(MvArticleModel model);

    void addArticle(MvArticleModel article);

    void modifyArticle(MvArticleModel article);

    void removeArticle(Long[] ids);
}
