package xin.liaozhixing.mapper.article;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.article.MvArticleModel;

import java.util.List;

public interface MvArticleMapper {

    List<MvArticleModel> getArticleByExample(@Param("example") MvArticleModel example);

}
