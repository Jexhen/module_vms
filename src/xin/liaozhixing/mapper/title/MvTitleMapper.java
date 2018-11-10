package xin.liaozhixing.mapper.title;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.title.MvTitleModel;

import java.util.List;

public interface MvTitleMapper {

    List<MvTitleModel> getTitle(@Param("roleId") Long roleId, @Param("isParentNode") String isParentNode);

}
