var grid = null;
$(function() {
	
	$("#classLevel").attr("name","");
	$("#classLevel").hide();
	
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-meeting/meeting!data.action?role="+role,
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
				             				html = html + "<a href='javascript:f_is_lock(\""+item.id+"\",\"0\")' class='linkbutton'>解锁</a>";
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
						{ display : '学期',minWidth:60, name : 'termName',isSort:false},
						{ display : '年部', minWidth:60,name : 'gtName',isSort:false},
						{ display : '年级', minWidth:60,name : 'gradeName',isSort:false},
						{ display : '学科', minWidth:60,name : 'subjectName',isSort:false},
						{ display : '老师名称',minWidth:60, name : 'teacherName',isSort:false},
						{ display : '会议名称',minWidth:120, name : 'meetingName',isSort:false},
						{ display : '会议日期', minWidth:80,name : 'startDate',isSort:false},
						{ display : '补看录像截止日期', minWidth:100,name : 'reviewVideoDeadline',isSort:false},
						{ display : '例会缺勤原因', minWidth:100,name : 'reasonForAbsence',isSort:false},
						{ display : '未补看录像原因', minWidth:100,name : 'reasonForNoReview',isSort:false},
						{ display : '班级组备注',minWidth:60, name : 'remarkStr',isSort:false},
						{ display : '缺勤次数', minWidth:60,name : 'remark',isSort:false},
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
						{ display : '课时修正人',minWidth:120, name : 'reviseEmployeeName',isSort:false},
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
						{ display : '修该原因',minWidth:120, name : 'reasonForNoReview',isSort:false},
						{ display : '修该操作人',minWidth:120, name : 'modifierName',isSort:false},
						{ display : '状态',minWidth:60, name : 'statusStr',isSort:false},
						{ display : '审核人',minWidth:120, name : 'auditorName',isSort:false},
				         { display : '是否取消全勤',minWidth:150, name : 'isCancelPerfectAttendanceStr',isSort:false,
				         	render: function(item, rowindex, value, column){
					         	var html = "";
				         		//是否考勤主管查看
				         		if(role =="3"||item.isCheckAttendance!=0)
				         		{	
				         			if(item.isCancelPerfectAttendanceStr) html = html+item.isCancelPerfectAttendanceStr;
				         		}
							    else
							    {
						         	html = html +	"<select id='cancelPerfectAttendance"+rowindex+"'  class='input-select'  onchange='isCancelPerfect_onChange(\""+item.id+"\",\"cancelPerfectAttendance"+rowindex+"\")'> ";
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
	    	url: contextPath + "/py-meeting/meeting!toAdd.action?timeStamp="+new Date().getTime(),
	    	width: 950,
	    	height: 650,
	    	title: "新增例会考勤",
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
	    	url: contextPath + "/py-meeting/meeting!toEdit.action?id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 850,
	    	height: 550,
	    	title: "更改例会考勤",
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
		var label = "已考勤废除操作";
		var message = "确认废除吗？";
		confirm(label, message, function() {
			$.getJSON(
					contextPath+"/py-meeting/meeting!auditDelete.action?id="+id+"&value="+value+"&timeStamp="+new Date().getTime(), 
				function(json) {
					if (json.success) {
						alert(json.message,"success");
						grid.loadData();
					}
				});
		});
	}	
	
	
	//是否作废
	function f_is_delete(id,value) {
		var label = "";
		var message = "";
		if(value == "1")
		{
			label = "删除操作";
			message = "确认删除吗？";
		}	
		else if(value == "0")
		{
			label = "恢复操作";
			message = "确认恢复吗？";
		}
		else
			return;
			
		confirm(label, message, function() {
			$.getJSON(
				contextPath+"/py-meeting/meeting!delete.action?ids="+id+"&value="+value+"&timeStamp="+new Date().getTime(), 
				function(json) {
					if (json.success) {
						alert(json.message,"success");
						grid.loadData();
					}
				});
		});
	}
	
	
		
	//是否加锁
	function f_is_lock(id,value)
	{
		var label = "";
		var message = "";
		if(value == "1")
		{
			label = "加锁操作";
			message = "确认加锁吗？";
		}	
		else if(value == "0")
		{
			label = "解锁操作";
			message = "确认解锁吗？";
		}	
		else
		 return;
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-meeting/meeting!lock.action?ids="+id+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}
	
	
	//提交
	function f_submit(id)
	{
		confirm("提交操作", "确认提交吗？", function() {
		$.getJSON(
			contextPath+"/py-meeting/meeting!auditSubmit.action?ids="+id+"&value="+2+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}
	

	
	//审核
	function f_audit(id,value)
	{
		var label = "";
		var message = "";
		if(value == "3")
		{
			label = "驳回操作";
			message = "确认驳回吗？";
		}	
		else if(value == "4")
		{
			label = "审核操作";
			message = "确认审核通过吗？";
		}
		else if(value == "5")
		{
			label = "反审核操作";
			message = "确认反审核吗？";
		}	
		else
		 return;
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-meeting/meeting!audit.action?ids="+id+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}
	
	

	
	//查看修改记录
	function f_edit_log(id)
	{
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-meeting/meeting!toQueryMeetingLog.action?id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 950,
	    	height: 650,
	    	title: "修改记录",
	    	buttons : [{
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
		url = url + "&modifyDeductLessonCondition.type="+3;
		url = url + "&timeStamp="+new Date().getTime();
		
		dialog = $.ligerDialog.open({ 
	    	url: url,
	    	width: 950,
	    	height: 650,
	    	title: "例会缺勤修正",
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
	    	width: 950,
	    	height: 650,
	    	title: "教师甩班修正记录",
	    	buttons : [{
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	}
	
	
	
	//修改  确认/取消全勤
	function isCancelPerfect_onChange (id,valueId)
	{
	
		var value = $("#"+valueId).val();
		alert(value);
		
		if(value=='')
			return ;
		
		var label = "";
		var message = "";
		
		if(value == "0")
		{
			label = "确认全勤操作";
			message = "确认全勤吗？";
		}	
		else if(value == "1")
		{
			label = "取消全勤操作";
			message = "确认取消全勤吗？";
		}	
		else
		 return;
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-meeting/meeting!isPerfect.action?ids="+id+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
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
	function f_import()
	{
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-meeting/meeting!toImportMeeting.action?importAction=/py-meeting/meeting!importMeeting.action",
	    	width: 550,
	    	height: 180,
	    	title: "导入例会缺勤"
	    });
	}
	
	//导出
	function f_export()
	{
	
	}
	
	//批量作废
	function f_batch_delete()
	{
		
		
		
		var ids = checkedIds.join(',')
		
		if(ids == '')
		{
			alert("请选择行！");
			return ;
		}
		
		var label = "批量作废";
		var message = "确认批量作废吗？";
		var value = "1";
		
			
		confirm(label, message, function() {
			$.getJSON(
				contextPath+"/py-meeting/meeting!delete.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
				function(json) {
					if (json.success) {
						alert(json.message,"success");
						grid.loadData();
					}
				});
		});
		
	}
	
	//批量恢复
	function f_batch_recover()
	{
		var ids = checkedIds.join(',')
		
		if(ids == '')
		{
			alert("请选择行！");
			return ;
		}
		
		var label = "批量作废";
		var message = "确认批量恢复吗？";
		var value = "0";
		
		confirm(label, message, function() {
			$.getJSON(
				contextPath+"/py-meeting/meeting!delete.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
				function(json) {
					if (json.success) {
						alert(json.message,"success");
						grid.loadData();
					}
				});
		});
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
			contextPath+"/py-meeting/meeting!lock.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
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
		var value  = 2;
	
		confirm(label, message, function() {
			$.getJSON(
					contextPath+"/py-meeting/meeting!auditSubmit.action?ids="+ids+"&value="+2+"&timeStamp="+new Date().getTime(), 
					function(json) {
						if (json.success) {
							alert(json.message,"success");
							grid.loadData();
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
		var value = "4";
		
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-meeting/meeting!audit.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}
	

	