package com.neusoft.controller;

import com.neusoft.bean.Role;
import com.neusoft.bean.RoleMenuRF;
import com.neusoft.bean.SystemMenu;
import com.neusoft.dao.RoleMapper;
import com.neusoft.dao.RoleMenuRFMapper;
import com.neusoft.dao.SystemMenuMapper;
import com.neusoft.util.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("admin/role")
public class RoleController {
    @Autowired
    private RoleMapper mapper;

    @Autowired
    private RoleMenuRFMapper rfMapper;

    @RequestMapping("html")
    public String page(){
        return "admin/role/list";
    }


    @RequestMapping("list")
    @ResponseBody
    public Object findall(
    ){
        ResultBean bean=null;
        try{
            List<Role> list=mapper.selectAll();
            bean=new ResultBean(ResultBean.Code.SUCCESS);
            bean.setObj(list);
        }catch (Exception e){
            e.printStackTrace();
            bean=new ResultBean(ResultBean.Code.EXCEPTION);
            bean.setMsg(e.getMessage());
        }
        return bean;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Object delete(
            Integer id
    ){
        ResultBean bean=null;
        try{
            int rows=mapper.deleteByPrimaryKey(id);
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

    @RequestMapping("saveOrupdate")
    @ResponseBody
    public Object save(
            Role role
    ){
        ResultBean bean=null;
        try{
            int rows=0;
            if(role.getRoleId()!=null){
                role.setRoleLastmodify(new Date());
                rows=mapper.updateByPrimaryKeySelective(role);
            }else {
                role.setRoleCreatetime(new Date());
                role.setRoleLastmodify(new Date());
                rows=mapper.insertSelective(role);
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

    @RequestMapping("power")
    @ResponseBody
    public Object power(
            String menuids,Integer roleid
    ){
        ResultBean bean=null;
        try{
            int rows=0;
            rows=rfMapper.deletebyroleid(roleid);
            if (menuids!=null&&menuids.length()>0) {
                String[] ids = menuids.split("[,]");
                List<RoleMenuRF> list = new ArrayList<>();
                for (String id : ids
                ) {
                    RoleMenuRF rf = new RoleMenuRF();
                    rf.setRmrfMenuid(Integer.valueOf(id));
                    rf.setRmrfRoleid(roleid);
                    rf.setRmrfCreatetime(new Date());
                    rf.setRmrfLastmodify(new Date());
                    list.add(rf);
                }
                rows=rfMapper.insertAll(list);
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


    @RequestMapping("powerlist")
    @ResponseBody
    public Object powerlist(
            Integer roleid
    ){
        ResultBean bean=null;
        try{
            int rows=0;
            List<RoleMenuRF> list=rfMapper.selectByroleid(roleid);
            bean=new ResultBean(ResultBean.Code.SUCCESS);
            bean.setObj(list);
        }catch (Exception e){
            e.printStackTrace();
            bean=new ResultBean(ResultBean.Code.EXCEPTION);
            bean.setMsg(e.getMessage());
        }
        return bean;
    }

}
