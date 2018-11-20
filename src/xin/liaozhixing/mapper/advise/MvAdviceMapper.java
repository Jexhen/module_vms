package xin.liaozhixing.mapper.advise;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.advise.MvAdviseModel;
import xin.liaozhixing.model.advise.MvAdviseResponseModel;

import java.util.List;

public interface MvAdviceMapper {

    List<MvAdviseModel> getMvAdviseByExample(@Param("example") MvAdviseModel example);

    List<MvAdviseResponseModel> getMvAdviseResponseByExample(@Param("example") MvAdviseResponseModel example);

    void addAdvise(@Param("advise") MvAdviseModel advise);

    void addAdviseResponse(@Param("adviseResponse")MvAdviseResponseModel adviseResponse);

    void modifyAdvice(@Param("advise") MvAdviseModel advise);
}
