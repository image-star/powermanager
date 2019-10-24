package com.neusoft.dao;

import com.neusoft.bean.RoleMenuRF;

import java.util.List;

public interface RoleMenuRFMapper {
    int deleteByPrimaryKey(Integer rmrfId);

    int insert(RoleMenuRF record);

    int insertSelective(RoleMenuRF record);

    RoleMenuRF selectByPrimaryKey(Integer rmrfId);

    int updateByPrimaryKeySelective(RoleMenuRF record);

    int updateByPrimaryKey(RoleMenuRF record);

    int   deletebyroleid(Integer roleid);

    int   insertAll(List<RoleMenuRF> list);

    List<RoleMenuRF> selectByroleid(Integer roleid);
}