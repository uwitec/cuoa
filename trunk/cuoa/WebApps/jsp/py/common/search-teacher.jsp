<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
	var grid = null;

	$(function() {
		var isHeadteacher = "<s:property value='isHeadteacher'/>";
		var path = "";
		if (isHeadteacher == "0") {
			path = contextPath + "/common/common!searchTeacher.action";
		} else {
			path = contextPath + "/common/common!searchHeadteacher.action";
		}
		var g = {
			gridid : "maingrid",
			condition : "condition",
			url : path,
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:false,
			columns : [{ display: "操作", minWidth:40, name: "",
					render: function(item) {
					    var html ="";
	         			if (item.isModified != 1) {
	                   // 	html ="<a href='javascript:parent.fetch_return_value(\""+item.id+"\",\""+item.name+"\",\""+parseInt(isHeadteacher)+"\");$(\".l-dialog-winbtn l-dialog-close l-dialog-close-over\", window.parent.document).trigger(\"click\");' class='linkbutton'>选择</a>";
	         				html = "<a href='javascript:link_event(\"" + item.id + "\",\"" + item.name + "\"," + parseInt(isHeadteacher) +")'>选择</a>";
	         			}
	                    return html;
	               }
			   },
	           { display : isHeadteacher == "0"?'教师系统姓名':'班主任系统姓名', minWidth:60, name : 'name',isSort:false}, 
	           { display: isHeadteacher == "0"?'教师编号':'班主任编号',minWidth:100, name: 'code',isSort:false},
	           { display: isHeadteacher == "0"?'教师姓名':'班主任姓名', name: 'realName',isSort:false},
	           { display: isHeadteacher == "0"?'教师状态':'班主任状态', name: 'realName',
	           		render: function(item){
	           			var html ="";
	           			
	           			if (item.state == 0)
	           			{
	           				html = html + "<font > 正常</font >";
	           			}
	           			else if (item.state == 1)
	           			{
	           				html = html + "<font color='red'> 删除</font >";
	           			}
	           			else if (item.state == 2)
	           			{
	           				html = html + "<font color='bule'> 冻结</font >";
	           			}
	           			 return html;
	           		}
	           }
			  ]
		};
		grid = showGrid_top(g);
	});
	function f_search() {
		grid.loadData();
	}
	
	function link_event(teacherId, teacherName, isHeadteacher) {
		parent.fetch_return_value(teacherId, teacherName, isHeadteacher);
		var cc=$(".l-dialog-tc .l-dialog-close", window.parent.document).click();
	}
</script>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<ul>
					<li>
						<label>
							<s:if test="isHeadteacher==0">教师</s:if>
							<s:else>班主任</s:else>
						</label>
						<input type="text" name="condition.teacherName" id="teacher" class="input-text" />
					</li>
					<li>
						<input type="button" id="queryButton" value="查询" class="l-button" onclick="f_search()"/>
						<input type="reset" id="resetButton" value="重置" class="l-button" />
					</li>
				</ul>
			</div>
				
			</form>
				
			</div>
			<div id="maingrid" class="grid">
			</div>


		<div style="display: none;">

		</div>

	</body>

</html>
