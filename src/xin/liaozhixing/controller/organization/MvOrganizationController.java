package xin.liaozhixing.controller.organization;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("organization")
public class MvOrganizationController {

    @RequestMapping("/getOrganization.shtml")
    public String getOrganization(Model model) {
        return "organization";
    }

}
