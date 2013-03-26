<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>办公自动化</title>
    <link href="<%=path%>/ligerui/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <script src="<%=path%>/ligerui/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>    
    <script src="<%=path%>/ligerui/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
    <script src="<%=path%>/jsp/index/indexdata.js" type="text/javascript"></script>
        <script type="text/javascript">
            var tab = null;
            var accordion = null;
            var tree = null;

         	var menuInfo =${personalMenuPermissionsJson};
            $(function ()
            {

                //布局
                $("#layout1").ligerLayout({ leftWidth: 190, height: '100%',heightDiff:-34,space:4, onHeightChanged: f_heightChanged });

                var height = $(".l-layout-center").height();

                //Tab
                $("#framecenter").ligerTab({ height: height });

                //面板
                $("#accordion1").ligerAccordion({ height: height - 24, speed: null });

                $(".l-link").hover(function ()
                {
                    $(this).addClass("l-link-over");
                }, function ()
                {
                    $(this).removeClass("l-link-over");
                });
                
                
                tab = $("#framecenter").ligerGetTabManager();
                accordion = $("#accordion1").ligerGetAccordionManager();
                
                
                
                
                //树
                $("#tree_py").ligerTree({
                    data : menuInfo,
                    checkbox: false,
                    slide: true,
                    nodeWidth: 120,
                    attribute: ['nodename', 'url'],
                    onSelect: function (node)
                    {
                        if (!node.data.url) return;
                        var tabid = $(node.target).attr("tabid");
                        if (!tabid)
                        {
                            tabid = new Date().getTime();
                            $(node.target).attr("tabid", tabid)
                        } 
                        f_addTab(tabid, node.data.text, node.data.url);
                    }
                });

                tree = $("#tree_py").ligerGetTreeManager();
                tree.expandAll();
                
                
                
                $("#pageloading").hide();

            });
            function f_heightChanged(options)
            {
                if (tab)
                    tab.addHeight(options.diff);
                if (accordion && options.middleHeight - 24 > 0)
                    accordion.setHeight(options.middleHeight - 24);
            }
            function f_addTab(tabid,text, url)
            { 
            //解决tab甩班的问题
            	if(tab.getTabItemCount()!=0)
            	{
            		tab.removeAll();
            	}
                tab.addTabItem({ tabid : tabid,text: text, url: url });
            } 
             
            
     </script> 
<style type="text/css"> 
    body,html{height:100%;}
    body{ padding:0px; margin:0;   overflow:hidden;}  
    .l-link{ display:block; height:26px; line-height:26px; padding-left:10px; text-decoration:underline; color:#333;}
    .l-link2{text-decoration:underline; color:white; margin-left:2px;margin-right:2px;}
    .l-layout-top{background:#102A49; color:White;}
    .l-layout-bottom{ background:#E5EDEF; text-align:center;}
    #pageloading{position:absolute; left:0px; top:0px; background:white url('loading.gif') no-repeat center; width:100%; height:100%;z-index:99999;}
    .l-link{ display:block; line-height:22px; height:22px; padding-left:16px;border:1px solid white; margin:4px;}
    .l-link-over{ background:#FFEEAC; border:1px solid #DB9F00;} 
    .l-winbar{ background:#2B5A76; height:30px; position:absolute; left:0px; bottom:0px; width:100%; z-index:99999;}
    .space{ color:#E7E7E7;}
    /* 顶部 */ 
	.l-topmenu{ margin:0; padding:0; height:24px; line-height:24px; background:#1B3160 url('<%=path%>/images/top.jpg') repeat-x bottom;  position:relative; border-top:1px solid #7C96AF; border-bottom:2px solid #4E7194;}
	.l-topmenu-logo{ color:#070A0C;  padding-left:130px; background:url('<%=path%>/images/topicon.png') no-repeat 10px 4px;}
	.l-topmenu-welcome{  position:absolute; height:24px; right:30px; top:0px;color:#070A0C;}
	.l-topmenu-welcome a{ color:#070A0C; text-decoration:underline}
	.l-topmenu-username{ color:#070A0C; font-weight:bold;}     
    
 </style>
</head>
<body style="padding:0px;background:#EAEEF5;">  
<div id="pageloading"></div>  
<div id="topmenu" class="l-topmenu">
    <div class="l-topmenu-logo">教师考勤系统 </div>
    <div class="l-topmenu-welcome">
    	<span class="l-topmenu-username"> 欢迎 &nbsp <s:property value="#session.userInfo.name"/> 登录学而思教师考勤系统！ &nbsp;

    	<span class="space">|</span>
    	<a href="login!logout.action" class="l-link2">退出</a>&nbsp;
    	
    </div> 
</div>
  <div id="layout1" style="width:99.2%; margin:0 auto; margin-top:4px; "> 
        <div position="left"  title="培优教师考勤" id="accordion1"> 
        <!--<div title="培优教师考勤" class="l-scroll">
                 <ul id="tree_py" style="margin-top:3px;">
            </div> -->
             <ul id="tree_py" style="margin-top:3px;">
            <!-- 
            <div title="">
            <div style=" height:7px;"></div>
            	<ul id="tree_zk" style="margin-top:3px;">
            </div>    
             <div title="">
            <div style=" height:7px;"></div>
                  <ul id="tree_mb" style="margin-top:3px;">
            </div>
             --> 
        </div>
        <div position="center" id="framecenter"> 
            <div tabid="home" title="我的主页" style="height:300px" >
                <iframe frameborder="0" name="home" id="home" src=""></iframe>
            </div> 
        </div> 
        
    </div>
    <div  style="height:22px; line-height:22px; text-align:center;">
           
    </div>
    <div style="display:none"></div>
</body>
</html>
