package com.neusoft.controller;

import com.neusoft.bean.Manager;
import com.neusoft.bean.SystemMenu;
import com.neusoft.dao.SystemMenuMapper;
import com.neusoft.util.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("admin/menu")
public class SystemMenuController extends BaseController {

    @Autowired
    private SystemMenuMapper mapper;

    @RequestMapping("tree")
    public String page(){
        return "admin/menu/tree";
    }


    @RequestMapping("manager")
    @ResponseBody
    public Object findbymanagerid(
    ){
        ResultBean bean=null;
        try{
            Manager manager=getLoginManager();
            List<SystemMenu> list=mapper.selectByManagerId(manager.getManagerId());
            List<SystemMenu> temp=new ArrayList<>();

            for (SystemMenu m:list
            ) {
                for (SystemMenu m1:list
                ) {
                    if (m.getMenuId().intValue()==m1.getMenuPid().intValue()){
                        m.getList().add(m1);
                        temp.add(m1);
                    }
                }
            }
            list.removeAll(temp);
            bean=new ResultBean(ResultBean.Code.SUCCESS);
            bean.setObj(list);

        }catch (Exception e){
            e.printStackTrace();
            bean=new ResultBean(ResultBean.Code.EXCEPTION);
            bean.setMsg(e.getMessage());
        }
        return bean;
    }

    @RequestMapping("list")
    @ResponseBody
    public Object findall(
    ){
        ResultBean bean=null;
        try{
            List<SystemMenu> list=mapper.selectAll();
            List<SystemMenu> temp=new ArrayList<>();

            for (SystemMenu m:list
                 ) {
                for (SystemMenu m1:list
                     ) {
                    if (m.getMenuId().intValue()==m1.getMenuPid().intValue()){
                        m.getList().add(m1);
                        temp.add(m1);
                    }
                }
            }
            list.removeAll(temp);
            bean=new ResultBean(ResultBean.Code.SUCCESS);
            bean.setObj(list);

        }catch (Exception e){
            e.printStackTrace();
            bean=new ResultBean(ResultBean.Code.EXCEPTION);
            bean.setMsg(e.getMessage());
        }
        return bean;
    }


    @RequestMapping("saveOrupdate")
    @ResponseBody
    public Object save(
            SystemMenu menu
    ){
        ResultBean bean=null;
        try{
            int rows=0;
            if(menu.getMenuId()!=null){
                menu.setMenuLastmodify(new Date());
                rows=mapper.updateByPrimaryKeySelective(menu);
            }else {
                menu.setMenuCreatetime(new Date());
                menu.setMenuLastmodify(new Date());
                rows=mapper.insertSelective(menu);
            }
            if(rows>0){
                bean=new ResultBean(ResultBean.Code.SUCCESS);
            }else {
                bean=new ResultBean(ResultBean.Code.FAIL);
            }
        }catch (Exception e){
            e.printStackTrace();
            bean=new ResultBean(ResultBean.Code.EXCEPTION);
            bean.setMsg(e.getMessage());
        }
        return bean;
    }

}
