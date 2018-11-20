package xin.liaozhixing.service.advise.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xin.liaozhixing.mapper.advise.MvAdviceMapper;
import xin.liaozhixing.model.advise.MvAdviseModel;
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
}
