package xin.liaozhixing.service.title.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import xin.liaozhixing.mapper.title.MvTitleMapper;
import xin.liaozhixing.model.title.MvTitleModel;
import xin.liaozhixing.service.title.MvTitleService;

import java.util.List;

@Service("titleService")
@Transactional
public class MvTitleServiceImpl implements MvTitleService {

    @Autowired
    private MvTitleMapper titleMapper;

    /**
     * 根据角色获取功能标题
     * @param roleId
     * @param isParentNode
     * @return
     */
    public List<MvTitleModel> getTitleOfRole(Long roleId, String isParentNode) {
        return titleMapper.getTitle(roleId, isParentNode);
    }

}
