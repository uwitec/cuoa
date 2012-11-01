var grid = null;
$(function() {
	
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-rejectcourse/rejectcourseadditional!data.action?role="+role,
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : true,
			isChecked: f_isChecked, 
			toolbar : toolbar,
			onCheckRow: f_onCheckRow, 
			onCheckAllRow: f_onCheckAllRow,
			rownumbers:true,
			columns : [{ display: "操作", minWidth:170, name: "id",
							render: function(item){
			         			var html = "";
			         			//如果已做过考勤，不允许做任何操作
			         			if (item.isCheckAttendance != 0) {
			         				return html;
			         			}
			         			if (role == "2") {
			         				if (item.status == 1 || item.status == 3 || item.status == 5) { //状态为正常或已驳回或已反审核时可修改和提交
			             				html = html + "<a href='javascript:f_revise(\""+item.id+"\",\""+item.deductId+"\")' class='linkbutton'>修正</a>";
					             		html = html + "<a href='javascript:f_submit(\""+item.id+"\")' class='linkbutton'>提交</a>";
			         				}
			         			} else if (role == "3") {
			         				if (item.status == 2) { //状态为待审核时可审核和驳回
					             		html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"4\")' class='linkbutton'>审核</a>";
					             		html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"3\")' class='linkbutton'>驳回</a>";
			         				} else if (item.status == 4) //状态为已审核时可反审核
				             		html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"5\")' class='linkbutton'>反审核</a>";
			         			}
			                    return html;
			               }
			           },
			           {display : '补录扣课时数', minWidth:85,  name : 'addHours',isSort:false},
			           {display : '补录扣课时原因', minWidth:125,  name : 'addReason',isSort:false},
			           {display : '补录人', minWidth:85,  name : 'addEmployeeName',isSort:false},
			           {display : '补录时间', minWidth:135,  name : 'addTime',isSort:false},
			           {display : '最后修改补录人', minWidth:125,  name : 'modifyAddEmployeeName',isSort:false},
			           {display : '最后修改补录时间', minWidth:135,  name : 'modifyAddTime',isSort:false},
			           {display : '补录指向日期', minWidth:125,  name : 'addTargetDate',isSort:false},
			           
						{display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
						{ display: '分校',minWidth:60, name: 'cityName',isSort:false},
						{ display : '学期',minWidth:60, name : 'termName',isSort:false},
						{ display : '年部', minWidth:60,name : 'gtName',isSort:false},
						{ display : '年级', minWidth:60,name : 'gradeName',isSort:false},
						{ display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
						{ display : '班次', minWidth:60, name : 'classlevelName',isSort:false},
						{ display : '班级名称',minWidth:60, name : 'courseName',isSort:false},
						{ display : '老师',minWidth:60, name : 'teacherNames',isSort:false},
						{ display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
						{ display : '地区', minWidth:60,name : 'areaName',isSort:false},
						{ display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false},
						{ display : '教学点', minWidth:60,name : 'venueName',isSort:false},
						{ display : '教室', minWidth:60,name : 'classroomName',isSort:false},
						{ display : '开班日期',minWidth:60, name : 'createTime',isSort:false},
						{ display : '开课日期', minWidth:60,name : 'startDate',isSort:false},
						{ display : '结课日期', minWidth:60,name : 'endDate',isSort:false},
						{ display : '上课日期', minWidth:60,name : 'createTime',isSort:false},
						{ display : '上课时间', minWidth:60,name : 'timeName',isSort:false},
						{ display : '甩班老师', minWidth:60,name : 'rejectingTeacherName',isSort:false},
						{ display : '甩班日期', minWidth:60,name : 'rejectDate',isSort:false},
						{ display : '甩班原因',minWidth:60, name : 'lessonNo',isSort:false},
						{ display : '接课老师',minWidth:60, name : 'receivingTeacherName',isSort:false},
						{ display : '甩班类型',minWidth:60, name : 'rejectCourseTypeStr',isSort:false},
						{ display : '班级组备注',minWidth:60, name : 'remarkStr',isSort:false},
						{ display : '甩班原因分类',minWidth:150, name : 'sortOfReasonName',isSort:false,
			         		render: function(item, rowindex, value, column)//item 行数据    rowindex 行索引 value 当前的值，对应record[column.name] column 列信息 
			         		{
					         	var html = "";
					         	if(role =="3")
					         		html = html+item.sortOfReasonName
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
				         		if(role =="3")
					         		html = html+item.specificSortOfReasonName
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
						{ display : '甩班次数',minWidth:60, name : 'remark',isSort:false},
						{ display : '本学期甩班次数',minWidth:100, name : 'rejectCourseTimesOfTerm',isSort:false},
						{ display : '另扣课时',minWidth:60, name : 'deductHours',isSort:false},
						{ display : '扣课时规则',minWidth:60, name : 'deductRule',isSort:false},
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
						{ display : '修正原因',minWidth:60, name : 'reasonForRevise',isSort:false},
						{ display : '课时修正人',minWidth:60, name : 'reviseEmployeeName',isSort:false},
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
						{ display : '修该原因',minWidth:60, name : 'reasonForModify',isSort:false},
						{ display : '修该操作人',minWidth:60, name : 'modifierName',isSort:false},
						{ display : '状态',minWidth:60, name : 'statusStr',isSort:false},
						{ display : '审核人',minWidth:120, name : 'auditorName',isSort:false},
				        { display : '是否为班主任',minWidth:80, name : 'isHeadTeacherStr',isSort:false},
				        { display : '是否取消工资晋升资格',minWidth:150, name : 'isCancelPromoteSalaryStr',isSort:false,
				         	render: function(item, rowindex, value, column){
					         	var html = "";
					         	if(role =="3")
						         	html = html+item.isCancelPromoteSalaryStr
						         else
						         {
						         	html = html +	"<select id='cancelPromoteSalary"+rowindex+"'  class='input-select'  onchange='isCancelPromote_onChange(\""+item.id+"\",\"cancelPromoteSalary"+rowindex+"\")'> ";
									html = html +	"	<option value=1  ";
									if(item.isCancelPromoteSalary==1)
										html =  html + "  selected='selected' "
									html = html +	" >是</option>";
									html = html +	"	<option value=0 ";
									if(item.isCancelPromoteSalary==0)
										html =  html + "  selected='selected' ";
									html = html +" >否</option>";
									html = html +	"	</select>";
								}	
					         	return html;
				         	}
				         },				         
				         { display : '是否取消全勤',minWidth:150, name : 'isCancelPerfectAttendanceStr',isSort:false,
				         	render: function(item, rowindex, value, column){
					         	var html = "";
					         	if(role =="3")
							         html = html+item.isCancelPerfectAttendanceStr
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
		
		
		initLeaveType("sortOfReasonId",leaveTypes);
	});
	function f_search() {
		grid.loadData();
	}
	
	//初始化甩班原因，Struts标签select使用时，事件不能绑定。
	function initLeaveType(parentId,data)
	{
			$('#'+parentId).empty();
			$('#'+parentId).append("<option value=''>请选择</option>");
			$.each(data, function(i,item){
				  $('#'+parentId).append("<option value='"+item.id+"'>"+item.name+"</option>");
			  });
	}
	
	
	//修正 
	function f_revise(id) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-rejectcourse/rejectcourseadditional!toEdit.action?additional.id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 750,
	    	height: 310,
	    	title: "修正补差"
	    });
	}
	

	//提交
	function f_submit(ids) {
		if (ids == null || ids == "") {
			alertt("请至少选择一项");
			return;
		}
		confirm("提交操作", "确认提交吗？", function() {
		$.getJSON(
			contextPath+"/py-rejectcourse/rejectcourseadditional!submit.action?ids=" + ids + "&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}
	
	

	
	//审核,驳回，反审核
	function f_audit(ids, type) {
		if (ids == null || ids == "") {
			alertt("请至少选择一项");
			return;
		}
		var label = "";
		var message = "";
		var method = "";
		if(type == "3") {
			label = "驳回操作";
			message = "确认驳回吗？";
			method = "reject";
		} else if(type == "4") {
			label = "审核操作";
			message = "确认审核通过吗？";
			method = "audit";
		} else if(type == "5") {
			label = "反审核操作";
			message = "确认反审核吗？";
			method = "reverseAudit";
		} else {
			return;
		}
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-rejectcourse/rejectcourseadditional!" + method + ".action?ids="+ids + "&timeStamp=" +new Date().getTime(), 
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
	    	url: contextPath + "/py-rejectcourse/rejectcourseadditional!toImportAdditional.action?importAction=/py-rejectcourse/rejectcourseadditional!importAdditional.action",
	    	width: 550,
	    	height: 180,
	    	title: "导入补差"
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
					contextPath+"/py-rejectcourse/rejectcourse!auditSubmit.action?ids="+ids+"&value="+2+"&timeStamp="+new Date().getTime(), 
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
			contextPath+"/py-rejectcourse/rejectcourse!audit.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}
	
