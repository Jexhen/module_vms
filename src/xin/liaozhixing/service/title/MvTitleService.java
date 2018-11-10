package xin.liaozhixing.service.title;

import xin.liaozhixing.model.title.MvTitleModel;

import java.util.List;

public interface MvTitleService {

    List<MvTitleModel> getTitleOfRole(Long roleId, String isParentNode);

}
