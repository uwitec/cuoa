var grid = null;
$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-courseleave/courseleaveadditional!data.action?role="+role,
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : true,
			toolbar : toolbar,
			isChecked: f_isChecked, 
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
			           { display: '系统姓名',minWidth:60, name: 'teacherNames',isSort:false},
			           { display : '教师编号',minWidth:60, name : 'teacherCodes',isSort:false},
				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '学期',minWidth:60, name : 'termName',isSort:false},
				       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:60,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:60, name : 'classlevelName',isSort:false},
				       { display : '班级名称',minWidth:60, name : 'courseName',isSort:false},
				       { display : '开班日期',minWidth:60, name : 'createTime',isSort:false},
				       { display : '开课日期', minWidth:60,name : 'startDate',isSort:false},
				       { display : '结课日期', minWidth:60,name : 'endDate',isSort:false},
				       { display : '总课次', minWidth:60,name : 'lessonCount',isSort:false},
				       { display : '已上课次',minWidth:60, name : 'passedLessonCount',isSort:false},
				       { display : '剩余课次',minWidth:60, name : 'remainCount',isSort:false},
				       { display : '限额人数', minWidth:60,name : 'limitNumberOfStudent',isSort:false},
				       { display : '地区', minWidth:60,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:60,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:60,name : 'classroomName',isSort:false},
				       { display : '上课日期', minWidth:60,name : 'createTime',isSort:false},
				       { display : '上课时间', minWidth:60,name : 'timeName',isSort:false},
						{ display : '课时', minWidth:60,name : 'hours',isSort:false},
						{ display : '缺勤课次',minWidth:60, name : 'lessonNo',isSort:false},
						{ display : '请假时间',minWidth:60, name : 'leaveDate',isSort:false},
						{ display : '请假类型',minWidth:60, name : 'typeStr',isSort:false},
				         { display : '请假原因',minWidth:60, name : 'reason',isSort:false},
				         { display : '替课老师',minWidth:60, name : 'replaceTeacherName',isSort:false},
				         { display : '班级组备注',minWidth:60, name : 'remarkStr',isSort:false},
				         { display : '是否修改',minWidth:60, name : 'isModifyStr',isSort:false},
				         { display : '修改原因',minWidth:60, name : 'reasonForModify',isSort:false},
				         { display : '请假原因分类',minWidth:150, name : 'sortOfReasonName',isSort:false},
				         { display : '具体原因分类',minWidth:150, name : 'specificSortOfReasonName',isSort:false},
				         
				         
				         { display : '缺勤次数',minWidth:60, name : 'remark',isSort:false},
				         { display : '本学期请假次数',minWidth:120, name : 'leaveTimesOfTerm',isSort:false},
				         { display : '另扣课时',minWidth:60, name : 'deductHours',isSort:false},
				         { display : '扣课时规则',minWidth:60, name : 'deductRule',isSort:false},
				         { display : '最终扣课时',minWidth:60, name : 'finalDeductHours',isSort:false},
				         { display : '是否修正课时',minWidth:80, name : 'isReviseStr',isSort:false},
				         
				         { display : '修正原因',minWidth:60, name : 'reasonForRevise',isSort:false},
				         { display : '是否为班主任',minWidth:80, name : 'isHeadTeacherStr',isSort:false},
				         { display : '是否取消全勤',minWidth:150, name : 'isCancelPerfectAttendanceStr',isSort:false},
				         
				         { display : '状态',minWidth:60, name : 'statusStr',isSort:false},
				         { display : '课时修正人',minWidth:60, name : 'reviseEmployeeName',isSort:false},
				         { display : '修改操作人',minWidth:60, name : 'modifierName',isSort:false},
				         { display : '审核人',minWidth:60, name : 'auditorName',isSort:false},
				         { display : '是否作废',minWidth:60, name : 'isDeletedStr',isSort:false}
						]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}
	

	//修正 
	function f_revise(id) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courseleave/courseleaveadditional!toEdit.action?additional.id=" + id+"&timeStamp="+new Date().getTime(),
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
			contextPath+"/py-courseleave/courseleaveadditional!submit.action?ids=" + ids + "&timeStamp="+new Date().getTime(), 
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
			contextPath+"/py-courseleave/courseleaveadditional!" + method + ".action?ids="+ids + "&timeStamp=" +new Date().getTime(), 
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
			contextPath+"/py-courseleave/courseleave!auditSubmit.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}
	
	
    function f_import(id) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courseleave/courseleaveadditional!toImportAdditional.action?importAction=/py-courseleave/courseleaveadditional!importAdditional.action",
	    	width: 550,
	    	height: 180,
	    	title: "导入补差"
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
			contextPath+"/py-courseleave/courseleave!audit.action?ids="+ids+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}
			});
		});
	}