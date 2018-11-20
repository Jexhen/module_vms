package xin.liaozhixing.controller.advise;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import xin.liaozhixing.service.advise.MvAdviseService;

@Controller
@RequestMapping("/advise")
public class MvAdviseController {

    @Autowired
    private MvAdviseService service;

}
