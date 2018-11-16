package xin.liaozhixing.service.article.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xin.liaozhixing.mapper.article.MvArticleMapper;
import xin.liaozhixing.model.article.MvArticleModel;
import xin.liaozhixing.service.article.MvArticleService;

import java.util.List;

@Service
public class MvArticleServiceImpl implements MvArticleService {

    @Autowired
    private MvArticleMapper mapper;

    @Override
    public List<MvArticleModel> getArticleByExample(MvArticleModel model) {
        return mapper.getArticleByExample(model);
    }
}
