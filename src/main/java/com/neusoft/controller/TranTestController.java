package com.neusoft.controller;

import com.neusoft.bean.Manager;
import com.neusoft.service.IManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("index")
public class TranTestController {

    @Autowired
    private IManagerService service;

    @ResponseBody
    @RequestMapping("test1")
    public Object test1(Manager manager){
        service.saveManager(manager);
        return manager;
    }
    @ResponseBody
    @RequestMapping("test2")
    public Object test2(Manager manager){
        service.saveManager2(manager);
        return manager;
    }
}
