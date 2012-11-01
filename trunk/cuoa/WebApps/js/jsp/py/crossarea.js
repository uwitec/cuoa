var grid = null;
$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-crossarea/crossarea!data.action",
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
		             			
	             				html = html + "<a href='javascript:f_edit(\""+item.id+"\")' class='linkbutton'>修改</a>";
	             				
	             				if(item.isDeleted == 1)
	             					html = html + "<a href='javascript:f_is_delete(\""+item.id+"\",\"0\")' class='linkbutton'>启用</a>";
		             			else
		             				html = html + "<a href='javascript:f_is_delete(\""+item.id+"\",\"1\")' class='linkbutton'>作废</a>";

			                    return html;
			               }
			           },
			           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
			           { display: '分校',minWidth:60, name: 'cityName',isSort:false},
			           { display : '班级名称',minWidth:150, name : 'courseName',isSort:false},
			           { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '学期',minWidth:60, name : 'termName',isSort:false},
				       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:60,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:60, name : 'classlevelName',isSort:false},
			           
				       { display : '地区', minWidth:60,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:60,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:60,name : 'classroomName',isSort:false},
				       
				       { display : '教师',minWidth:60, name: 'teacherNames',isSort:false},
				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '上课时间',minWidth:80, name : 'startDate',isSort:false},
				       
				       { display : '上课日期', minWidth:80,name : 'startDate',isSort:false},
				       { display : '开课日期', minWidth:80,name : 'startDate',isSort:false},
				       { display : '结课日期', minWidth:80,name : 'endDate',isSort:false},
				       
				       { display : '课次', minWidth:60,name : 'lessonNo',isSort:false},
						
				       { display : '跨点原因', minWidth:150,name : 'reasonForCross',isSort:false},
				       { display : '通知教学点', minWidth:60,name : 'ifNoticeToVenueStr',isSort:false},
				       { display : '通知督查', minWidth:60,name : 'ifNoticeToSuperviseStr',isSort:false},
				       { display : '记录人', minWidth:60,name : 'recorderName',isSort:false},
				       { display : '是否为班主任', minWidth:100,name : 'isHeadTeacherStr',isSort:false},
				       { display : '备注', minWidth:120,name : 'remark',isSort:false},
				     
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
				        { display : '修改操作人',minWidth:120, name : 'modifierName',isSort:false},
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
	    	url: contextPath + "/py-crossarea/crossarea!toAdd.action?timeStamp="+new Date().getTime(),
	    	width: 850,
	    	height: 650,
	    	title: "新增跨点上课",
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
	    	url: contextPath + "/py-crossarea/crossarea!toEdit.action?id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 850,
	    	height: 550,
	    	title: "更改跨点上课",
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
				contextPath+"/py-crossarea/crossarea!delete.action?ids="+id+"&value="+value+"&timeStamp="+new Date().getTime(), 
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
	    	url: contextPath + "/py-crossarea/crossarea!toQueryCrossAreaLog.action?id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 850,
	    	height: 550,
	    	title: "查看修改记录",
	    	buttons : [ {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
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
	    	url: contextPath + "/py-crossarea/crossarea!toImportCrossArea.action?importAction=/py-crossarea/crossarea!importCrossArea.action",
	    	width: 550,
	    	height: 180,
	    	title: "导入教师请假"
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
				contextPath+"/py-crossarea/crossarea!delete.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
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
				contextPath+"/py-crossarea/crossarea!delete.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
				function(json) {
					if (json.success) {
						alert(json.message,"success");
						grid.loadData();
					}
				});
		});
	}
	