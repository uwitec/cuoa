var grid = null;
$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-courseleave/courseleave!data.action?role="+role,
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : true,
			toolbar : toolbar,
			isChecked: f_isChecked, 
			onCheckRow: f_onCheckRow, 
			onCheckAllRow: f_onCheckAllRow,
			rownumbers:true,
			columns : [{ display: "操作", minWidth:300, name: "id",
		             		render: function(item){
		             			var html = "";
		             			
		             			if(role =="1"&&item.isCheckAttendance==0)
		             			{	             			
		             				if(item.isLock == 0)
		             				{
				             				html = html + "<a href='javascript:f_edit(\""+item.id+"\")' class='linkbutton'>修改</a>";
				             				
				             				if(item.isDeleted == 1)
				             					html = html + "<a href='javascript:f_is_delete(\""+item.id+"\",\"0\")' class='linkbutton'>启用</a>";
					             			else
					             				html = html + "<a href='javascript:f_is_delete(\""+item.id+"\",\"1\")' class='linkbutton'>作废</a>";
			             			}
		             			}
		             			
		             			else if(role =="2"&&item.isCheckAttendance==0)
		             			{
		             				if(item.status != 2 &&item.status != 4&&item.isDeleted == 0)
		             				{
			             				if(item.isLock==0)
			             					html = html + "<a href='javascript:f_is_lock(\""+item.id+"\",\"1\")' class='linkbutton'>加锁</a>";
			             				else
			             				{	
			             					html = html + "<a href='javascript:f_audit_delete(\""+item.id+"\",\""+item.isCheckAttendance+"\")' class='linkbutton'>解锁</a>";				
				             				html = html + "<a href='javascript:f_revise(\""+item.id+"\",\""+item.deductId+"\")' class='linkbutton'>修正</a>";
			             					html = html + "<a href='javascript:f_submit(\""+item.id+"\")' class='linkbutton'>提交</a>";
										}
									}
		             			}
		             			else if(role =="2"&&item.isCheckAttendance==1)
		             			{
		             				html = html + "<a href='javascript:f_audit_delete(\""+item.id+"\",\""+item.isCheckAttendance+"\")' class='linkbutton'>废除</a>";				
		             			}
		             			else if(role =="3"&&item.isCheckAttendance==0)
		             			{
		             				if(item.status == 4&&item.isDeleted == 0)
		             					html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"5\")' class='linkbutton'>反审核</a>";
		             				else if(item.status == 2&&item.isDeleted == 0)
		             				{	
		             					html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"3\")' class='linkbutton'>驳回</a>";
			             				html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"4\")' class='linkbutton'>审核</a>";
			             			}
		             			}
								
			                    return html;
			               }
			           },
			           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
			           { display: '分校',minWidth:60, name: 'cityName',isSort:false},
			           { display: '系统姓名',minWidth:60, name: 'teacherNames',isSort:false},
			           { display : '教师姓名',minWidth:60, name : 'teacherNames',isSort:false},
			           { display : '教师编号',minWidth:60, name : 'teacherCodes',isSort:false},
				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '学期',minWidth:60, name : 'termName',isSort:false},
				       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:80,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:100, name : 'classlevelName',isSort:false},
				       { display : '班级名称',minWidth:150, name : 'courseName',isSort:false},
				       { display : '开班日期',minWidth:80, name : 'createTime',isSort:false},
				       { display : '开课日期', minWidth:80,name : 'startDate',isSort:false},
				       { display : '结课日期', minWidth:80,name : 'endDate',isSort:false},
				       { display : '总课次', minWidth:60,name : 'lessonCount',isSort:false},
				       { display : '已上课次',minWidth:60, name : 'passedLessonCount',isSort:false},
				       { display : '剩余课次',minWidth:60, name : 'remainCount',isSort:false},
				       { display : '限额人数', minWidth:60,name : 'limitNumberOfStudent',isSort:false},
				       { display : '地区', minWidth:100,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:100,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:100,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:100,name : 'classroomName',isSort:false},
				       { display : '上课日期', minWidth:80,name : 'createTime',isSort:false},
				       { display : '上课时间', minWidth:80,name : 'courseTime',isSort:false},
						{ display : '课时', minWidth:60,name : 'hours',isSort:false},
						{ display : '缺勤课次',minWidth:60, name : 'lessonNo',isSort:false},
						{ display : '缺勤日期',minWidth:80, name : 'leaveDate',isSort:false},
						{ display : '请假时间',minWidth:120, name : 'dateOfAskForLeave',isSort:false},
						{ display : '请假类型',minWidth:100, name : 'typeStr',isSort:false},
						{ display : '请假原因',minWidth:120, name : 'reason',isSort:false},
						{ display : '替课老师',minWidth:60, name : 'replaceTeacherName',isSort:false},
						{ display : '班级组备注',minWidth:80, name : 'remarkStr',isSort:false},
						{ display : '是否修改',minWidth:60, name : 'isModifyStr',isSort:false,
				         	render: function(item){
				         		var html = "";
				         			if(item.isModify == 1)
				         				html = html + "<a href='javascript:f_edit_log(\""+item.id+"\")' class='linkbutton'>是</a>";
				         			else
				         				html = html+"否";
				         			
					         	return html
				         	}
				         },
				         { display : '修改原因',minWidth:120, name : 'reasonForModify',isSort:false},
				         { display : '请假原因分类',minWidth:150, name : 'sortOfReasonName',isSort:false,
				         render: function(item, rowindex, value, column)//item 行数据    rowindex 行索引 value 当前的值，对应record[column.name] column 列信息 
					         {
					         	var html = "";
				         		//是否考勤主管查看
				         		if(role =="3"||item.isCheckAttendance!=0)
				         		{	
				         			if(item.sortOfReasonName) html = html+item.sortOfReasonName;
					         	}	
				         		else
				         		{	
							      	html = html + "<select   id='leaveTypePid"+rowindex+"'  onchange='queryLeaveTypeById(\"leaveTypePid"+rowindex+"\",\"leaveTypeCid"+rowindex+"\")'> ";
										html = html + "<option value=''>请选择</option>";					
									for(var i=0;i<leaveTypes.length;i++)
									{
										html = html + "<option value='"+leaveTypes[i].id+"'"; 
										if(item.sortOfReasonId == leaveTypes[i].id)
											html =  html + "  selected='selected' "
										html =  html + ">"+leaveTypes[i].name+"</option>";	
									}
									html = html + "</select>";
				         		}	
					         	return html;
					         }

				         },
				         { display : '具体原因分类',minWidth:150, name : 'specificSortOfReasonName',isSort:false,
				         render: function(item, rowindex, value, column)//item 行数据    rowindex 行索引 value 当前的值，对应record[column.name] column 列信息 
				         	{
				        	 
					         	var html = "";
				         		//是否考勤主管查看
				         		if(role =="3"||item.isCheckAttendance!=0)
				         		{	
				         			if(item.specificSortOfReasonName) html = html+item.specificSortOfReasonName;
				         		}
				         		else
				         		{
					         		html = html + "<select   id='leaveTypeCid"+rowindex+"'  onchange='f_modfiy_leaveType_onChange(\""+item.id+"\",\"leaveTypeCid"+rowindex+"\")'> ";
									if(item.sortOfReasonId&&item.specificSortOfReasonId)
										html = html + "<option value='"+item.specificSortOfReasonId+"'>"+item.specificSortOfReasonName+"</option>";
									else
										html = html + "<option value=''>请选择</option>";
									html = html + "</select>";
				         		}
								return html;
				         	}
				         },
				         { display : '缺勤次数',minWidth:60, name : 'remark',isSort:false},
				         { display : '本学期请假次数',minWidth:100, name : 'leaveTimesOfTerm',isSort:false},
				         { display : '另扣课时',minWidth:60, name : 'deductHours',isSort:false},
				         { display : '扣课时规则',minWidth:120, name : 'deductRule',isSort:false},
				         { display : '最终扣课时',minWidth:60, name : 'finalDeductHours',isSort:false},
				         { display : '是否修正课时',minWidth:80, name : 'isReviseStr',isSort:false,
				         	render: function(item){
				         		var html = "";
					         	if(item.isRevise == 1)
					         		html = html + "<a href='javascript:f_revise_log(\""+item.deductId+"\")' class='linkbutton'>修正记录</a>";
					         	else
					         		html = html+"否";
					         	return html
				         	} 
				         },
				         { display : '修正原因',minWidth:120, name : 'reasonForRevise',isSort:false},
				         { display : '是否为班主任',minWidth:80, name : 'isHeadTeacherStr',isSort:false},
				         { display : '是否取消全勤',minWidth:130, name : 'isCancelPerfectAttendanceStr',isSort:false,
				         	render: function(item, rowindex, value, column){
					         	var html = "";
				         		//是否考勤主管查看
				         		if(role =="3"||item.isCheckAttendance!=0)
				         		{	
				         			if(item.isCancelPerfectAttendanceStr) html = html+item.isCancelPerfectAttendanceStr;
				         		}	
				         		else
				         		{
						         	html = html +	"<select id='perfectAttendance"+rowindex+"'  class='input-select'  onchange='isPerfect_onChange(\""+item.id+"\",\"perfectAttendance"+rowindex+"\")'> ";
									html = html +	"	<option value=1  ";
									if(item.isCancelPerfectAttendance==1)
										html =  html + "  selected='selected' "
									html = html +	" >是</option>";
									html = html +	"	<option value=0 ";
									if(item.isCancelPerfectAttendance==0)
										html =  html + "  selected='selected' ";
									html = html +" >否</option>";
									html = html +	"	</select>";
				         		}	
				         	return html;
				         	}
				         },
				         
				         { display : '状态',minWidth:80, name : 'statusStr',isSort:false},
				         { display : '课时修正人',minWidth:120, name : 'reviseEmployeeName',isSort:false},
				         { display : '修改操作人',minWidth:120, name : 'modifierName',isSort:false},
				         { display : '审核人',minWidth:120, name : 'auditorName',isSort:false},
				         { display : '是否作废',minWidth:60, name : 'isDeletedStr',isSort:false}
						]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}
	
	//新增
	function f_add() {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courseleave/courseleave!toAdd.action?timeStamp="+new Date().getTime(),
	    	width: 850,
	    	height: 650,
	    	title: "新增请假信息",
	    	buttons : [{
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	}
	
	//编辑 
	function f_edit(id) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courseleave/courseleave!toEdit.action?id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 850,
	    	height: 550,
	    	title: "更改请假信息",
	    	buttons : [ {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	}

	
	//已考勤后，废除或解锁
	function f_audit_delete(id,value)
	{
		dialog = $.ligerDialog.open({ 
	    	url: contextPath+"/py-courseleave/courseleave!toIndexForDeduct.action?id="+id+"&value="+value+"&timeStamp="+new Date().getTime(), 
	    	width: 650,
	    	height: 400,
	    	title: "相关请假信息",
	    	buttons : [ {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	}
	
	
	//是否作废
	function f_is_delete(id,value) {
		var label = "";
		var message = "";
		var action ="";
		if(value == "1")
		{
			label = "删除操作";
			message = "确认删除吗？";
			action = "cancel";
		}	
		else if(value == "0")
		{
			label = "恢复操作";
			message = "确认恢复吗？";
			action = "resume";
		}
		else
			return;
			
		confirm(label, message, function() {
			$.getJSON(
				contextPath+"/py-courseleave/courseleave!"+action+".action?ids="+id+"&timeStamp="+new Date().getTime(), 
				function(json) {
					if (json.success) {
						alert(json.message,"success");
						grid.loadData();
					}else
					{
						alert(json.message,"warn");
					}
				});
		});
	}
	
	
		
	//是否加锁
	function f_is_lock(id,value)
	{
		var label = "";
		var message = "";
		var action = "";
		if(value == "1")
		{
			label = "加锁操作";
			message = "确认加锁吗？";
			action ="lock";
		}	
		else if(value == "0")
		{
			label = "解锁操作";
			message = "确认解锁吗？";
			action ="unlock";
		}	
		else
		 return;
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!"+action+".action?ids="+id+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alert(json.message,"warn");
				}
			});
		});
	}
	
	
	//提交
	function f_submit(id)
	{
		confirm("提交操作", "确认提交吗？", function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!submitAudit.action?ids="+id+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alert(json.message,"warn");
				}
			});
		});
	}
	

	
	//审核
	function f_audit(id,value)
	{
		var label = "";
		var message = "";
		var action ="";
		if(value == "3")
		{
			label = "驳回操作";
			message = "确认驳回吗？";
			action  ="rejectAudit";
		}	
		else if(value == "4")
		{
			label = "审核操作";
			message = "确认审核通过吗？";
			action  = "passAudit";
		}
		else if(value == "5")
		{
			label = "反审核操作";
			message = "确认反审核吗？";
			action  = "reverseAudit";
		}	
		else
		 return;
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!"+action+".action?ids="+id+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alert(json.message,"warn");
				}
			});
		});
	}
	
	

	
	//查看修改记录
	function f_edit_log(id)
	{
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courseleave/courseleave!toQueryLeaveLog.action?id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 650,
	    	height: 400,
	    	title: "查看修改记录",
	    	buttons : [ {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
		
	}

	
	//修正
	function f_revise(entityId,deductId)
	{
		
		var url = contextPath + "/common/revise!toRevise.action";
		url = url + "?modifyDeductLessonCondition.entityId="+entityId;
		url = url + "&modifyDeductLessonCondition.deductId="+deductId;
		url = url + "&modifyDeductLessonCondition.type="+4;
		url = url + "&timeStamp="+new Date().getTime();
		
		dialog = $.ligerDialog.open({ 
	    	url: url,
	    	width: 650,
	    	height: 400,
	    	title: "教师请假修正",
	    	buttons : [{
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	}
	
	//修正记录
	function f_revise_log(id)
	{
			if(id == '')
			{
				alert("id:"+id);
				return;
			}
				
			dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/common/revise!toQueryReviseLog.action?id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 650,
	    	height: 550,
	    	title: "教师请假修正记录",
	    	buttons : [{
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	}
	
	
	
	//修改  确认/取消全勤
	function isPerfect_onChange (id,valueId)
	{
	
		var value = $("#"+valueId).val();
		
		if(value=='')
			return ;
		
		var label = "";
		var message = "";
		var action = "";
		
		if(value == "0")
		{
			label = "确认全勤操作";
			message = "确认全勤吗？";
			action = "IsPerfect";
		}	
		else if(value == "1")
		{
			label = "取消全勤操作";
			message = "确认取消全勤吗？";
			action = "IsCancelPerfect";
		}	
		else
		 return;
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!"+action+".action?ids="+id+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alert(json.message,"warn");
				}
			});
		});
	}
	
	//修改 请假分类
	function f_modfiy_leaveType_onChange(id,chindId)
	{
		
		if($('#'+chindId).val()=='')
			return ;	
		var label = "修改请假类型";
		var message = "确认修改请教类型吗？"
		
		var param = {"leave.id":id,"leave.specificSortOfReasonId":$('#'+chindId).val(),"timeStamp":new Date().getTime()};
		
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!modifyLeaveCourseLeaveType.action", 
			param,
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}
	
	//请假具有原因分类
	function queryLeaveTypeByIds(parentId,chindId)
	{
			if($('#'+parentId).val()=='')
				return;
			var param = {"leaveTypeCondition.parentId":$('#'+parentId).val(),"timeStamp":new Date().getTime()};
			$.getJSON(
			contextPath+"/common/common!queryLeaveTypes.action", param,
			function(data) {
				if(data.json){
				  $('#'+chindId).empty();
				  $('#'+chindId).append("<option value=''>请选择</option>");
				  $.each(data.json, function(i,item){
					  $('#'+chindId).append("<option value='"+item.id+"'>"+item.name+"</option>");
				  });
			  }
			});
	}
	
	

	        /*
     实现 表单分页多选
        即利用onCheckRow将选中的行记忆下来，并利用isChecked将记忆下来的行初始化选中
        */
	
	     function f_onCheckAllRow(checked)
        {
            for (var rowid in this.records)
            {
                if(checked)
                    addCheckedIds(this.records[rowid]['id']);
                else
                    removeCheckedIds(this.records[rowid]['id']);
            }
        }
 

        var checkedIds = [];
        function findCheckedIds(id)
        {
            for(var i =0;i<checkedIds.length;i++)
            {
                if(checkedIds[i] == id) return i;
            }
            return -1;
        }
        function addCheckedIds(id)
        {
            if(findCheckedIds(id) == -1)
                checkedIds.push(id);
        }
        function removeCheckedIds(id)
        {
            var i = findCheckedIds(id);
            if(i==-1) return;
            checkedIds.splice(i,1);
        }
        function f_isChecked(rowdata)
        {
            if (findCheckedIds(rowdata.id) == -1)
                return false;
            return true;
        }
        function f_onCheckRow(checked, data)
        {
            if (checked) addCheckedIds(data.id);
            else removeCheckedIds(data.id);
        }
        function f_getChecked()
        {
            alert(checkedIds.join(','));
        }
	
	
	
	//导入
    function f_import() {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courseleave/courseleave!toImportLeave.action?importAction=/py-courseleave/courseleave!importLeave.action",
	    	width: 550,
	    	height: 180,
	    	title: "导入教师请假"
	    });
	}
	
	//导出
	function f_export()
	{
	
	}
	
	
	//批量锁定
	function f_batch_isLock()
	{
		var ids = checkedIds.join(',')
		
		if(ids == '')
		{
			alert("请选择行！");
			return ;
		}
	
		var label = "批量锁定";
		var message = "你确认批量锁定吗？";
		var value  = 1;
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!lock.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alert(json.message,"warn");
				}
			});
		});
	}
	
	
	
	//批量提交
	function f_batch_submit()
	{
		var ids = checkedIds.join(',')
		
		if(ids == '')
		{
			alert("请选择行！");
			return ;
		}
	
		var label = "批量提交";
		var message = "你确认批量提交吗？";

		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!submitAudit.action?ids="+ids+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alert(json.message,"warn");
				}
			});
		});
	}
	
	
	
		
	//批量审核
	function f_batch_audit()
	{
		var ids = checkedIds.join(',')
		
		if(ids == '')
		{
			alert("请选择行！");
			return ;
		}
	
		var label = "批量审核";
		var message = "你确认批量审核吗？";
		
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!passAudit.action?ids="+ids+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alert(json.message,"warn");
				}
			});
		});
	}