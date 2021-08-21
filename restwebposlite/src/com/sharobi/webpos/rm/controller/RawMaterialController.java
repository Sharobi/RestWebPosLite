package com.sharobi.webpos.rm.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sharobi.webpos.rm.service.RawMaterialService;


@Controller
@RequestMapping("/rawmaterial")
public class RawMaterialController {
	private final static Logger logger=LogManager.getLogger(RawMaterialController.class);
	private final static RawMaterialService rawMaterialService=new RawMaterialService();

}
