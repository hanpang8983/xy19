package com.hanpang.framework.base.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sys")
public class SysControler extends BaseController {
	protected Logger logger = Logger.getLogger(SysControler.class);

}
