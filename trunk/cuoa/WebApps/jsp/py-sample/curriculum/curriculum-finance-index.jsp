<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
	var grid = null;
	var toolbar = {items : [{ text: '导出', click: excel,icon:'outbox' }]};
	
  	function excel(item) {
        exportData("/py-curriculum/curriculum-finance!exportFinance.action", [0,1]);
    }
  
  
	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-curriculum/curriculum-finance!dataFinance.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			toolbar : toolbar,
			checkbox : true,
			rownumbers:false,
			columns : [
			           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
			           { display: '分校', name: 'cityName',isSort:false},
			           { display : '系统姓名',minWidth:60, name : 'teacherName',isSort:false},
			           { display : '教师编号',minWidth:60, name : 'teacherCode',isSort:false},
				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       
				       { display : '学期',minWidth:50, name : 'termName',isSort:false},
				       { display : '年部', minWidth:40,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:100,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:40,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:90, name : 'classlevelName',isSort:false},
				      
				       { display : '班级名称',minWidth:300, name : 'courseName',isSort:false,
				    	   render: function(item){
				    		   var html = "";
				    		   html = html + "<a href='javascript:queryClassDetails(\""+item.courseId+"\")' class='linkbutton'>"+item.courseName+"</a>";
				    		   return html;
				    	   }
				       },
				       
				       { display : '地区', minWidth:60,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:70,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:70,name : 'classroomName',isSort:false},
				       
				       { display : '系统上课日期', minWidth:120,name : 'courseDate',isSort:false},
			           { display : '系统上课时间', minWidth:120,name : 'timeName',isSort:false},
	
				       { display : '课时', minWidth:120,name : 'hours',isSort:false},
				       { display : '开班日期',minWidth:300, name : 'createTime',isSort:false},
			           { display : '开课日期', minWidth:90,name : 'startDate',isSort:false},
			           { display : '结课日期', minWidth:90,name : 'endDate',isSort:false},
			           { display : '总课次', minWidth:50,name : 'lessonCount',isSort:false},
			           { display : '已上课次',minWidth:60, name : 'passedLessonCount',isSort:false},
				       { display : '剩余课次',minWidth:60, name : 'remainCount',isSort:false},
				       { display : '限额人数', minWidth:60,name : 'limitNumberOfStudent',isSort:false},
				                    
				       { display : '实际上课日期', minWidth:90,name : 'actualCourseDate',isSort:false},
				       { display : '实际上课时间', minWidth:90,name : 'actualCourseTime',isSort:false},
				       { display : '实际课时', minWidth:120,name : 'hours',isSort:false},
				       
				       { display : '实际老师系统姓名',minWidth:120, name : 'actualTeacherName',isSort:false},
				       { display : '实际班主任',minWidth:70, name : 'actualHeadteacherName',isSort:false},
				       
				       
				       { display : '修改类型', minWidth:70,name : 'modifyTypeName',isSort:false},
					   { display : '修改原因',minWidth:60, name : 'reason',isSort:false},
					   { display : '是否为班主任',minWidth:85, name : 'isHeadteacherStr',isSort:false},
					   { display : '审核状态',minWidth:85, name : 'statusStr',isSort:false},
					   { display : '汇总人',minWidth:70, name : '',isSort:false},
					   { display : '审核人',minWidth:70, name : 'auditorName',isSort:false},
					   { display : '操作人',minWidth:70, name : '',isSort:false},
					   { display : '是否停课',minWidth:70, name : 'isSuspendStr',isSort:false}
					]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}
</script>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<!-- 载入班级基本信息联动 -->
				<ul id="basicLinkage">
				</ul>
				<!-- 载入班级上课地点联动信息 -->
				<ul id="locationLinkage">
				</ul>
				<ul>
					<li>
						<label>
							教师
						</label>
						<input type="text" name="condition.teacherName" id="teacher" class="input-text" />
					</li>
					<li>
						<label>
							班主任
						</label>
						<input type="text" name="condition.headteacherName" id="headteacher" class="input-text" />
					</li>
					<li>
						<label>
							是否为班主任
						</label>
						<select id="isHeadteacher" name="condition.isHeadteacher" class="input-select">
							<option value="">请选择</option>
							<option value="1">
								是
							</option>
							<option value="0">
								否
							</option>
						</select>
					</li>
				</ul>
				<ul>
					<li>
						<label>
							原上课日期
						</label>
						<input id="startDate_start" name="condition.startDateStart" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							至
						</label>
						<input id="startDate_end" name="condition.startDateEnd" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							实际上课日期
						</label>
						<input id="lessonDate_start" name="condition.lessonDateStart" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							至
						</label>
						<input id="lessonDate_end" name="condition.lessonDateEnd" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
				</ul>
				<ul>
					<li>
						<label>确认年月</label>
			    			<select id="verify_year" name="condition.verifyYear" class="input-select">
								<option value="">请选择</option>
								<option value="2010">2010年</option>
								<option value="2011">2011年</option>
								<option value="2012">2012年</option>
								<option value="2013">2013年</option>
								<option value="2014">2014年</option>
								<option value="2015">2015年</option>
								<option value="2016">2016年</option>
								<option value="2017">2017年</option>
								<option value="2018">2018年</option>
								<option value="2019">2019年</option>
								<option value="2020">2020年</option>
								<option value="2021">2021年</option>
								<option value="2022">2022年</option>
							</select>
							<select id="verify_month" name="condition.verifyMonth" class="input-select">
								<option value="">请选择</option>
								<option value="01">1月</option>
								<option value="02">2月</option>
								<option value="03">3月</option>
								<option value="04">4月</option>
								<option value="05">5月</option>
								<option value="06">6月</option>
								<option value="07">7月</option>
								<option value="08">8月</option>
								<option value="09">9月</option>
								<option value="10">10月</option>
								<option value="11">11月</option>
								<option value="12">12月</option>
							</select>
						</li>
				</ul>
				<ul>
					
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
