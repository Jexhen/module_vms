package xin.liaozhixing.service.advise;

import xin.liaozhixing.model.advise.MvAdviseModel;

import java.util.List;

public interface MvAdviseService {

    /**
     * 查询建议
     * @param example
     * @return
     */
    List<MvAdviseModel> getAdviseByExample(MvAdviseModel example);
}
