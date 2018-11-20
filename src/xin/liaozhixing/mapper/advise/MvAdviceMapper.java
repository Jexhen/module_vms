package xin.liaozhixing.mapper.advise;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.advise.MvAdviseModel;

import java.util.List;

public interface MvAdviceMapper {

    List<MvAdviseModel> getMvAdviseByExample(@Param("example") MvAdviseModel example);

}
