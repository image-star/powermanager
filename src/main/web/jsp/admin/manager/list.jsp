<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2019/10/9
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>管理员列表</title>
    <link rel="stylesheet" href="<%=basePath%>static/element/css/theme/index.css">
    <style>
        body{
            padding: 0px;
            margin: 0px;
        }
        .avatar-uploader .el-upload {
            border: 1px dashed #d9d9d9;
            border-radius: 6px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .avatar-uploader .el-upload:hover {
            border-color: #409EFF;
        }
        .avatar-uploader-icon {
            font-size: 28px;
            color: #8c939d;
            width: 100px;
            height: 100px;
            line-height: 100px;
            text-align: center;
        }
        .avatar {
            width: 100px;
            height: 100px;
            display: block;
        }
    </style>
</head>
<body>
    <div id="app">

        <el-dialog title="添加/修改信息" :visible.sync="dialogFormVisible" width="380px">
            <el-form :model="manager" :rules="rules" ref="managerForm">

                <div style="margin: 0 auto;text-align: center;margin-bottom: 10px">
                    <el-upload
                            class="avatar-uploader"
                            action="<%=basePath%>admin/manager/upload"
                            name="file"
                            :show-file-list="false"
                            :on-success="handleAvatarSuccess"
                            :before-upload="beforeAvatarUpload">
                        <img v-if="imageUrl" :src="imageUrl" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </div>


                <el-form-item label="姓名" :label-width="formLabelWidth"  prop="managerName">
                    <el-input v-model="manager.managerName" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="性别" :label-width="formLabelWidth" prop="managerSex">
                    <el-select v-model="manager.managerSex" placeholder="性别">
                        <el-option label="男" value="男"></el-option>
                        <el-option label="女" value="女"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="身份证" :label-width="formLabelWidth" prop="managerIdcard">
                    <el-input v-model="manager.managerIdcard" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="电话" :label-width="formLabelWidth" prop="managerPhone">
                    <el-input v-model="manager.managerPhone" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitForm('managerForm')">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog title="授权" :visible.sync="dialogRoleVisible" width="300px">
            <el-checkbox-group v-model="checkedRoles" @change="handleCheckedRolesChange">
                <el-checkbox v-for="role in roles" :label="role.roleId" :key="role.roleId">{{role.roleName}}</el-checkbox>
            </el-checkbox-group>
        </el-dialog>

        <el-row :gutter="20" style="margin-bottom: 10px">
            <el-col :span="5">
                <el-button-group>
                    <el-button type="primary" icon="el-icon-plus" @click="opensave"></el-button>
                    <el-button type="primary" icon="el-icon-edit"
                               <%--@click="editx"--%>
                    ></el-button>
                    <el-button type="primary" icon="el-icon-delete" @click="deleteAll"></el-button>
                </el-button-group>
            </el-col>
            <el-col :span="2">
                <a href="<%=basePath%>static/template/manager.xlsx">模板下载</a>
            </el-col>
            <el-col :span="10">
                <div class="grid-content bg-purple-light">
                <el-upload
                        class="upload-demo"
                        action="<%=basePath%>admin/manager/import"
                        :on-success="importsuccess"
                        :on-error="importfail"
                        :show-file-list="false"
                >
                    <el-button size="small" type="primary">批量添加</el-button>
                </el-upload>
                </div>
            </el-col>
            <el-col :span="6">
                <el-input
                        type="text"
                        @keyup.enter.native="search"
                        v-model="param"
                        placeholder="输入关键字搜索">
                    <el-button slot="append" icon="el-icon-search" @click="search"></el-button>
                </el-input>
            </el-col>
        </el-row>

        <template>
            <el-table
                    :data="list"
                    ref="tb1"
                    border
                    style="width: 100%"
                    :default-sort = "{prop: 'managerId', order: 'descending'}"
                    @sort-change="sort"
            >
                <el-table-column
                        type="selection"
                        width="55">
                </el-table-column>
                <el-table-column
                        fixed
                        prop="managerId"
                        sortable
                        label="ID"
                        width="60">
                </el-table-column>

                <el-table-column
                        label="头像"
                        width="150">
                    <template slot-scope="scope">
                        <img style="height: 90px;" :src="'<%=basePath%>'+scope.row.managerImg" onerror="javascript:this.src='<%=basePath%>static/imgs/default.jpg'"></img>
                    </template>
                </el-table-column>

                <el-table-column
                        prop="managerName"
                        label="姓名"
                        width="100">
                </el-table-column>
                <el-table-column
                        prop="rolestr"
                        label="角色"
                        width="250">
                </el-table-column>
                <el-table-column
                        prop="managerPhone"
                        label="电话"
                        width="120">
                </el-table-column>
                <el-table-column
                        prop="managerSex"
                        label="性别"
                        width="60">
                </el-table-column>
                <el-table-column
                        prop="managerIdcard"
                        label="身份证号码"
                        width="200">
                </el-table-column>
                <el-table-column
                        prop="managerCreatetime"
                        sortable
                        label="创建时间"
                        width="200">
                </el-table-column>
                <el-table-column
                        prop="managerLastmodify"
                        label="最后修改时间"
                        width="180">
                </el-table-column>
                <el-table-column
                        fixed="right"
                        label="操作"
                        width="100">
                    <template slot-scope="scope">
                        <el-button @click="power_role(scope.row)" type="text" size="small">授权</el-button>
                        <el-button @click="edits(scope.row)" type="text" size="small">编辑</el-button>
                        <el-button @click="deletex(scope.row.managerId)" type="text" size="small">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </template>
        <%--分页--%>
        <el-pagination
                background
                layout="prev, pager, next,sizes,jumper"
                :total="page.total"
                :page-size="page.size"
                @current-change="pagechange"
                @prev-click="prev"
                @next-click="next"
                @size-change="sizechange"
        >
        </el-pagination>
    </div>



<script src="<%=basePath%>static/element/js/vue.js"></script>
<script src="<%=basePath%>static/element/js/elementui.js"></script>
<script src="<%=basePath%>static/element/js/axio.js"></script>
<script src="<%=basePath%>static/element/js/qs.js"></script>

        <script>
            new Vue({
                el:'#app',
                data:function () {
                    return{
                        roles:[],
                        checkedRoles:[],
                        param:'',
                        order:'asc',
                        pro:'managerId',
                        list: [],
                        page:{
                            total:50,
                            index:1,
                            size:20
                        },
                        dialogFormVisible: false,
                        dialogRoleVisible: false,
                        imageUrl: '',
                        manager:{},
                        formLabelWidth:'80px',
                        rules: {
                            managerName: [
                                 { required: true, message: '请输入姓名', trigger: 'blur' },
                                 { min: 2, max: 50, message: '长度在 2 到 50 个字符', trigger: 'blur' }
                            ],
                            managerSex: [
                                 { required: true, message: '请选择性别', trigger: 'change' },
                            ],
                            managerPhone: [
                                 { required: true, message: '请输入手机号码', trigger: 'blur' },
                                 { pattern:/^1(3|4|5|6|7|8|9)\d{9}$/,message:'请输入正确的手机号码'}
                            ],
                            managerIdcard: [
                                 { required: true, message: '请输入身份证号码', trigger: 'blur' },
                                 { pattern:/^(^\d{15}$)|(^\d{17}([0-9]|X|x)$)$/,message:'请输入正确的身份证号码'}
                            ],
                        },
                        currentmanagerid:0
                    }
                },
                created:function () {
                    this.getdata();
                    this.getRoles();
                },
                methods:{
                    power_role(row){
                        var roles=row.roles;
                        this.checkedRoles=[];
                        for (var i=0;i<roles.length;i++) {
                            this.checkedRoles.push(roles[i].roleId)
                        }
                        this.dialogRoleVisible=true;
                        this.currentmanagerid=row.managerId;

                    },
                    handleCheckedRolesChange:function(){
                        var ids=[];
                        for (var i=0;i<this.checkedRoles.length;i++){
                            ids.push(this.checkedRoles[i])
                        }
                        console.log(this.checkedRoles)
                        var  self=this;
                        var data={'roleids':ids.join(','),'managerid':this.currentmanagerid}
                        axios.post('<%=basePath%>admin/manager/savepower',Qs.stringify(data)).
                        then(function (res) {
                            if (res.data.code=='10000'){
                                self.$message({
                                    type: 'success',
                                    message: '已保存!'
                                });
                                self.getdata();
                            }else {
                                self.$message({
                                    type: 'error',
                                    message: '保存失败!'
                                });
                            }
                        }).catch(() => {
                            self.$message({
                                type: 'error',
                                message: '网络异常!'
                            });
                        });
                    },
                    getRoles:function () {
                        var self=this;
                        axios.get("<%=basePath%>admin/role/list").
                        then(function (response) {
                            if (response.data.code=='10000'){
                                self.roles=response.data.obj;
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    deleteAll(){
                        var  rows=this.$refs.tb1.selection;
                        var ids=[];
                        for (var i=0;i<rows.length;i++){
                            ids.push(rows[i].managerId)
                        }
                        console.log("IDs:"+ids);
                        var  self=this;
                        if (ids.length<=0)
                        {
                            self.$message({
                                type: 'error',
                                message: '请选择删除的数据!'
                            });
                            return;
                        }
                        var data={'ids':ids.join(',')}
                        axios.post('<%=basePath%>admin/manager/deleteAll',Qs.stringify(data)).
                        then(function (res) {
                            if (res.data.code=='10000'){
                                self.$message({
                                    type: 'success',
                                    message: '删除成功!'
                                });
                                self.getdata();
                                self.dialogFormVisible=false;
                            }else {
                                self.$message({
                                    type: 'error',
                                    message: '删除失败!'
                                });
                            }
                        }).catch(() => {
                            self.$message({
                                type: 'error',
                                message: '网络异常!'
                            });
                        });
                    },
                    search:function(str){
                        console.log(str)
                        console.log(this.param)
                        this.getdata()
                    },
                    sort:function(e){
                        this.pro=e.prop;
                        if(e.order=='ascending'){
                            this.order='asc';
                        }else {
                            this.order='desc';
                        }
                        this.getdata();
                        console.log(e.column+"--"+e.prop+"--"+e.order)
                    },
                    opensave(){
                        this.manager={};
                        this.dialogFormVisible = true;
                        this.resetForm('managerForm')
                    },
                    edits(row){
                        this.manager=row;
                        this.dialogFormVisible=true;
                    },
                    // editx(){
                    //     var  row=this.$refs.tb1.selection;
                    //     console.log(row)
                    //     this.manager=row;
                    //     this.dialogFormVisible=true;
                    // },
                    importsuccess:function(response, file, fileList){
                        if (response.code=='10000')
                        {
                            this.$message({
                                type: 'success',
                                message: '上传成功!'
                            });
                            this.getdata();
                        }else {
                            this.$message({
                                type: 'error',
                                message: '上传失败!'
                            });
                        }
                    },
                    importfail:function(err, file, fileList){
                        this.$message({
                            type: 'error',
                            message: '上传网络异常!'
                        });
                    },
                    submitForm(formName) {
                        this.$refs[formName].validate((valid) => {
                            if (valid) {
                                this.save();
                            } else {
                                console.log('error submit!!');
                                return false;
                            }
                        });
                    },
                    resetForm(formName) {
                        this.$refs[formName].resetFields();
                    },
                    save(){
                        var self=this;
                        axios.post('<%=basePath%>admin/manager/saveOrupdate',Qs.stringify(self.manager)).
                        then(function (res) {
                                if (res.data.code=='10000'){
                                    self.$message({
                                        type: 'success',
                                        message: '保存成功!'
                                    });
                                    self.getdata();
                                    self.dialogFormVisible=false;
                                }else {
                                    self.$message({
                                        type: 'error',
                                        message: '保存失败!'
                                    });
                                }
                        }).catch(() => {
                            self.$message({
                                type: 'error',
                                message: '网络异常!'
                            });
                        });
                    },
                    handleAvatarSuccess(res, file) {
                        this.imageUrl = URL.createObjectURL(file.raw);
                        if (res.code=="10000"){
                            this.manager.managerImg=res.obj;
                        }
                    },
                    beforeAvatarUpload(file) {
                        const isJPG = file.type === 'image/jpeg';
                        const isLt2M = file.size / 1024 / 1024 < 2;

                        if (!isJPG) {
                            this.$message.error('上传头像图片只能是 JPG 格式!');
                        }
                        if (!isLt2M) {
                            this.$message.error('上传头像图片大小不能超过 2MB!');
                        }
                        return isJPG && isLt2M;
                    },
                    deletex(id){
                        this.$confirm('您是否确认删除本行数据?', '提示', {
                            confirmButtonText: '确定',
                            cancelButtonText: '取消',
                            type: 'warning'
                        }).then(() => {
                            var data={
                                id:id
                            }
                            var self=this;
                            axios.get("<%=basePath%>admin/manager/delete",{
                                params:data
                            }).
                            then(function (response) {
                                if (response.data.code=='10000'){
                                    self.$message({
                                        type: 'success',
                                        message: '删除成功!'
                                    });
                                    self.getdata();
                                }else {
                                    self.$message({
                                        type: 'error',
                                        message: '删除失败!'
                                    });
                                }
                            }).catch(function (error) {
                                self.$message({
                                    type: 'error',
                                    message: '网络异常!'
                                });
                            });
                        }).catch(() => {
                        });
                    },
                    sizechange(size){
                        this.page.size=size;
                        this.getdata();
                    },
                    pagechange(index){
                        this.page.index=index;
                        this.getdata();
                    },
                    prev(){
                        this.page.index--;
                        this.getdata();
                    },
                    next(){
                        this.page.index++;
                        this.getdata();
                    },
                    <%--changeimg:function(img){--%>
                        <%--alert("test")--%>
                        <%--img.src="<%=basePath%>static/imgs/default.jpg";--%>
                    <%--},--%>


                    getdata:function () {
                        var data={
                            'index':this.page.index,
                            'size' :this.page.size,
                            'order':this.order,
                            'prop':this.pro,
                            'param':this.param
                        };
                        var self=this;
                        axios.get("<%=basePath%>admin/manager/list",{
                            params:data
                        }).
                        then(function (response) {
                            if (response.data.code=='10000'){
                               self.list=response.data.obj.list;
                               self.page.total=response.data.obj.total;
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    }
                }
            });
        </script>
</body>
</html>
