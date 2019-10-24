<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2019/10/8
  Time: 19:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>后台管理</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <style>
        body{
            padding: 0px;
            margin: 0px;
        }
        .el-header {
            background-color: #B3C0D1;
            color: #333;
            line-height: 60px;
        }

        .el-aside {
            color: #333;
        }
        iframe{
            width: 100%;
            height: 100%;
            outline: none;
            outline-width: 0px;
            overflow:scroll;
            border: 0px;
        }
    </style>

</head>
<body>
<div id="app">
    <el-container style="height: 100%; border: 0px solid #eee">
        <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
            <el-menu :default-openeds="['1']">
                <el-submenu v-for="(item,index) in menus" :index="index+''" :key="item.menuId">
                    <template slot="title">
                        <i :class="item.menuIco"></i>{{item.menuTitle}}</template>
                    <el-menu-item v-for="(m,i) in item.list"  :key="m.menuId" :index="index+'-'+i"  @click="addTab(m.menuTitle,m.menuTitle,m.menuLink)">
                        <template slot="title"><i :class="m.menuIco"></i>{{m.menuTitle}}</template>
                        </el-menu-item>
                </el-submenu>

            </el-menu>
        </el-aside>

        <el-container>
            <el-header style="text-align: right; font-size: 12px">
                <el-dropdown>
                    <i class="el-icon-setting" style="margin-right: 15px"></i>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item>修改密码</el-dropdown-item>
                        <el-dropdown-item>注销</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
                <span>${manager.managerName}</span>
            </el-header>

            <el-main>
                <el-tabs v-model="editableTabsValue" type="card" closable @tab-remove="removeTab">
                    <el-tab-pane
                            v-for="(item, index) in editableTabs"
                            :key="item.name"
                            :label="item.title"
                            :name="item.name"
                    >
                        <iframe :src="item.src"></iframe>
                    </el-tab-pane>
                </el-tabs>
            </el-main>
        </el-container>
    </el-container>
</div>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://cdn.bootcss.com/qs/6.5.1/qs.min.js"></script>

<script>
    new Vue({
        el: '#app',
        data: function() {
            return {
                menus:[],
                editableTabsValue: '1',
                editableTabs: [ {
                    title: 'Tab 1',
                    name: '1',
                    src: 'http://www.baidu.com'
                }],
                tabIndex: 1
            }
        },
        created(){
            this.loadmenu();
        },
        methods: {
            loadmenu(){
                var self=this;
                axios.get("<%=basePath%>admin/menu/manager").then(function (response) {
                    if (response.data.code=='10000'){
                        self.menus=response.data.obj;
                        console.log(self.menus)
                    }else {
                        self.$message({
                            type: 'error',
                            message: '菜单加载失败!'
                        });
                    }
                }).catch(function (error) {
                    self.$message({
                        type: 'error',
                        message: '网络异常!'
                    });
                });
            },
            addTab(name,title,src) {
                // let newTabName = ++this.tabIndex + '';
                var  hased=false;//判断是否已经有了
                for (var i=0;i<this.editableTabs.length;i++){
                    if(this.editableTabs[i].name==name){
                        hased=true;
                        break;
                    }
                }
                if(!hased){
                    this.editableTabs.push({
                    title: title,
                    name: name,
                    src: src
                });
                }
                this.editableTabsValue = name;
            },
            removeTab(targetName) {
                let tabs = this.editableTabs;
                let activeName = this.editableTabsValue;
                if (activeName === targetName) {
                    tabs.forEach((tab, index) => {
                        if (tab.name === targetName) {
                            let nextTab = tabs[index + 1] || tabs[index - 1];
                            if (nextTab) {
                                activeName = nextTab.name;
                            }
                        }
                    });
                }

                this.editableTabsValue = activeName;
                this.editableTabs = tabs.filter(tab => tab.name !== targetName);
            }
        }
    });
</script>

</body>
</html>
