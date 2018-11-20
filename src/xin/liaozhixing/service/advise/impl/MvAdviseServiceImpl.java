package xin.liaozhixing.service.advise.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xin.liaozhixing.mapper.advise.MvAdviceMapper;
import xin.liaozhixing.model.advise.MvAdviseModel;
import xin.liaozhixing.model.advise.MvAdviseResponseModel;
import xin.liaozhixing.service.advise.MvAdviseService;

import java.util.List;

@Service
public class MvAdviseServiceImpl implements MvAdviseService {

    @Autowired
    private MvAdviceMapper mapper;


    /**
     * 查询建议
     *
     * @param example
     * @return
     */
    @Override
    public List<MvAdviseModel> getAdviseByExample(MvAdviseModel example) {
        return mapper.getMvAdviseByExample(example);
    }

    /**
     * 查询投诉建议回复
     *
     * @param example
     * @return
     */
    @Override
    public List<MvAdviseResponseModel> getAdviseResponseByExample(MvAdviseResponseModel example) {
        return mapper.getMvAdviseResponseByExample(example);
    }

    /**
     * 增加建议
     *
     * @param advise
     */
    @Override
    public void addAdvise(MvAdviseModel advise) {
        mapper.addAdvise(advise);
    }

    /**
     * 增加建议回复
     *
     * @param adviseResponse
     */
    @Override
    public void addAdviseResponse(MvAdviseResponseModel adviseResponse) {
        mapper.addAdviseResponse(adviseResponse);
    }

    /**
     * 修改建议
     *
     * @param advise
     */
    @Override
    public void modifyAdvice(MvAdviseModel advise) {
        mapper.modifyAdvice(advise);
    }
}
