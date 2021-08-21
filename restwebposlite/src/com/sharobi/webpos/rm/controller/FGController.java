package com.sharobi.webpos.rm.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sharobi.webpos.rm.service.FGService;

@Controller
@RequestMapping("/fg")
public class FGController {
	private final static Logger logger=LogManager.getLogger(FGController.class);
	private final static FGService fgService=new FGService();
}
