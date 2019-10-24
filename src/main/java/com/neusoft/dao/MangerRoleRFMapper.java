package com.neusoft.dao;

import com.neusoft.bean.MangerRoleRF;

import java.util.List;

public interface MangerRoleRFMapper {
    int deleteByPrimaryKey(Integer rfId);

    int insert(MangerRoleRF record);

    int insertSelective(MangerRoleRF record);

    MangerRoleRF selectByPrimaryKey(Integer rfId);

    int updateByPrimaryKeySelective(MangerRoleRF record);

    int updateByPrimaryKey(MangerRoleRF record);

    int  deletebyManagerid(Integer managerid);

    int  insertAll(List<MangerRoleRF> list);
}