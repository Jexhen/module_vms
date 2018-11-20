package xin.liaozhixing.service.advise;

import xin.liaozhixing.model.advise.MvAdviseModel;
import xin.liaozhixing.model.advise.MvAdviseResponseModel;

import java.util.List;

public interface MvAdviseService {

    /**
     * 查询建议
     * @param example
     * @return
     */
    List<MvAdviseModel> getAdviseByExample(MvAdviseModel example);

    /**
     * 查询投诉建议回复
     * @param example
     * @return
     */
    List<MvAdviseResponseModel> getAdviseResponseByExample(MvAdviseResponseModel example);

    /**
     * 增加建议
     * @param advise
     */
    void addAdvise(MvAdviseModel advise);

    /**
     * 增加建议回复
     * @param adviseResponse
     */
    void addAdviseResponse(MvAdviseResponseModel adviseResponse);

    /**
     * 修改建议
     * @param advise
     */
    void modifyAdvice(MvAdviseModel advise);
}
