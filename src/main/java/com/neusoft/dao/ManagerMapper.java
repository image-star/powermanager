package com.neusoft.dao;

import com.neusoft.bean.Manager;

import java.util.List;
import java.util.Map;

public interface ManagerMapper {
    int deleteByPrimaryKey(Integer managerId);

    int insert(Manager record);

    int insertSelective(Manager record);

    Manager selectByPrimaryKey(Integer managerId);

    int updateByPrimaryKeySelective(Manager record);

    int updateByPrimaryKey(Manager record);

    List<Manager> selectAll(Map map);

    int insertAll(List<Manager> list);

    int deleteAll(List<Integer> list);

    List<Manager> login(Map map);


}