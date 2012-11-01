/**
 * @author YJN 班级基本信息联动
 */

function loadBasicLinkage() {
	var str = "";
	str += "<li>";
	str += "	<label>班级</label>";
	str += "    <select id='year' name='condition.year' class='input-select' onchange=\"basicLinkage(2, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');\">";
	str += "	<option value=''>年份</option>";
	str += "   	<option value='2010'>2010年</option>";	
	str += "   	<option value='2011'>2011年</option>";
	str += "		<option value='2012'>2012年</option>";
	str += "		<option value='2013'>2013年</option>";
	str += "		<option value='2014'>2014年</option>";
	str += "		<option value='2015'>2015年</option>";
	str += "	<option value='2016'>2016年</option>";
	str += "</select>";
	str += "</li>";
	str += "<li>";
	str += "	<select id='term' name='condition.termId' class='input-select' onchange=\"basicLinkage(3, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');\">";
	str += "	<option value=''>学期</option>";
	str += " 	</select>";
	str += "   </li>";
	str += "   <li>";
	str += "   	<select id='gradeType' name='condition.gtId' class='input-select' onchange=\"basicLinkage(4, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');\">";
	str += "   		<option value=''>学部</option>";
	str += "   	</select>";
	str += "   </li>";
	str += "   <li>";
	str += "   	<select id='grade' name='condition.gradeId' class='input-select' onchange=\"basicLinkage(5, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');\">";
	str += "    		<option value=''>年级</option>";
	str += "    	</select>";
	str += "    </li>";
	str += "    <li>";
	str += "   	<select id='subject' name='condition.subjectIds' class='input-select' onchange=\"basicLinkage(6, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');\">";
	str += "   		<option value=''>学科</option>";
	str += "   	</select>";
	str += "   </li>";
	str += "   <li>";
	str += "   	<select id='classLevel' name='condition.classlevelId' class='input-select'>";
	str += "  		<option value=''>班次</option>";
	str += "  	</select>";
	str += "	</li>";
	$("#basicLinkage").html(str);
}

function basicLinkage(which_level, year, termId, gradeTypeId, gradeId,
		subjectIds, classLevelId) {
	var requestPath;
	if (which_level == 2) {
		requestPath = "/py-linkage/select!queryTermOfLinkage.action";
	} else if (which_level == 3) {
		requestPath = "/py-linkage/select!queryGradeTypeOfLinkage.action";
	} else if (which_level == 4) {
		requestPath = "/py-linkage/select!queryGradeOfLinkage.action";
	} else if (which_level == 5) {
		requestPath = "/py-linkage/select!querySubjectsOfLinkage.action";
	} else if (which_level == 6) {
		requestPath = "/py-linkage/select!queryClasslevelOfLinkage.action";
	}

	if (which_level == 2) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {year : $('#' + year).val(),
				r_m : Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetTeamId(termId);
					$.each(data.json, function(i, item) {
						$('#' + termId).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
					resetGradeTypeId(gradeTypeId);
					resetGradeId(gradeId);
					resetSubjectIds(subjectIds);
					resetClassLevelId(classLevelId);
				}
		    }
		});

	} else if (which_level == 3) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {year : $('#' + year).val(),
				termId : $('#' + termId).val(),
				r_m : Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetGradeTypeId(gradeTypeId);
					$.each(data.json, function(i, item) {
						$('#' + gradeTypeId).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
					resetGradeId(gradeId);
					resetSubjectIds(subjectIds);
					resetClassLevelId(classLevelId);
				}
		    }
		});

	} else if (which_level == 4) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {year : $('#' + year).val(),
				termId : $('#' + termId).val(),
				gradeTypeId : $('#' + gradeTypeId).val(),
				r_m : Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetGradeId(gradeId);
					$.each(data.json, function(i, item) {
						$('#' + gradeId).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
					resetSubjectIds(subjectIds);
					resetClassLevelId(classLevelId);
				}
		    }
		});

	} else if (which_level == 5) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {year : $('#' + year).val(),
				termId : $('#' + termId).val(),
				gradeTypeId : $('#' + gradeTypeId).val(),
				gradeId : $('#' + gradeId).val(),
				r_m : Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetSubjectIds(subjectIds);
					$.each(data.json, function(i, item) {
						$('#' + subjectIds).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
					resetClassLevelId(classLevelId);
				}
		    }
		});

	} else if (which_level == 6) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {year : $('#' + year).val(),
				termId : $('#' + termId).val(),
				gradeTypeId : $('#' + gradeTypeId).val(),
				gradeId : $('#' + gradeId).val(),
				subjectIds : $('#' + subjectIds).val(),
				r_m : Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetClassLevelId(classLevelId);
					$.each(data.json, function(i, item) {
						$('#' + classLevelId).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
				}
		    }
		});
	}
}
function resetTeamId(termId) {
	$('#' + termId).empty();
	$('#' + termId).append("<option value=''>学期</option>");
}
function resetGradeTypeId(gradeTypeId) {
	$('#' + gradeTypeId).empty();
	$('#' + gradeTypeId).append("<option value=''>学部</option>");
}
function resetGradeId(gradeId) {
	$('#' + gradeId).empty();
	$('#' + gradeId).append("<option value=''>年级</option>");
}
function resetSubjectIds(subjectIds) {
	$('#' + subjectIds).empty();
	$('#' + subjectIds).append("<option value=''>学科</option>");
}
function resetClassLevelId(classLevelId) {
	$('#' + classLevelId).empty();
	$('#' + classLevelId).append("<option value=''>班次</option>");
}

function loadLocationLinkage() {
	var str = "";
	str += "	<li>";
	str += "	<label>地点</label>";
	str += "	<select id='city' name='condition.cityNo' class='input-select' onchange=\"locationLinkage(2, 'city', 'area', 'serviceCenter', 'venue', 'classroom');\">";
	str += "		<option value=''>城市</option>";
	str += "		<option value='010'>北京</option>";
	str += "		<option value='021'>上海</option>";
	str += "		<option value='020'>广州</option>";
	str += "		<option value='022'>天津</option>";
	str += "	</select>";
	str += "</li>";
	str += "<li>";
	str += "	<select id='area' name='condition.areaId' class='input-select' onchange=\"locationLinkage(3, 'city', 'area', 'serviceCenter', 'venue', 'classroom');\">";
	str += "<option value=''>地区</option>";
	str += "	</select>";
	str += "</li>";
	str += "<li>";
	str += "	<select id='serviceCenter' name='condition.servicecenterId' class='input-select' onchange=\"locationLinkage(4, 'city', 'area', 'serviceCenter', 'venue', 'classroom');\">";
	str += "<option value=''>服务中心</option>";
	str += "	</select>";
	str += "</li>";
	str += "<li>";
	str += "	<select id='venue' name='condition.venueId' class='input-select' onchange=\"locationLinkage(5, 'city', 'area', 'serviceCenter', 'venue', 'classroom');\">";
	str += "<option value=''>教学点</option>";
	str += "	</select>";
	str += "</li>";
	str += "<li>";
	str += "	<select id='classroom' name='condition.classroomId' class='input-select'>";
	str += "<option value=''>教室</option>";
	str += "	</select>";
	str += "</li>";
	$("#locationLinkage").html(str);
}

/**
 * 班级位置信息联动
 */
function locationLinkage(which_level, cityNo, areaId, servicecenterId, venueId,
		classroomId) {
	var requestPath;
	if (which_level == 2) {
		requestPath = "/py-linkage/select!queryAreaOfLinkage.action";
	} else if (which_level == 3) {
		requestPath = "/py-linkage/select!queryServicecenterOfLinkage.action";
	} else if (which_level == 4) {
		requestPath = "/py-linkage/select!queryVenueOfLinkage.action";
	} else if (which_level == 5) {
		requestPath = "/py-linkage/select!queryClassroomOfLinkage.action";
	}

	if (which_level == 2) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {cityNo: $('#' + cityNo).val(), r_m: Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetAreaId(areaId);
					$.each(data.json, function(i, item) {
						$('#' + areaId).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
					resetServicecenterId(servicecenterId);
					resetVenueId(venueId);
					resetClassroomId(classroomId);
				}
		    }
		});

	} else if (which_level == 3) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {cityNo: $('#' + cityNo).val(),areaId : $('#' + areaId).val(), r_m: Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetServicecenterId(servicecenterId);
					$.each(data.json, function(i, item) {
						$('#' + servicecenterId).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
					resetVenueId(venueId);
					resetClassroomId(classroomId);
				}
		    }
		});

	} else if (which_level == 4) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {cityNo: $('#' + cityNo).val(),areaId : $('#' + areaId).val(),servicecenterId : $('#' + servicecenterId).val(), r_m: Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetVenueId(venueId);
					$.each(data.json, function(i, item) {
						$('#' + venueId).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
					resetClassroomId(classroomId);
				}
		    }
		});
		
	} else if (which_level == 5) {
		$.ajax({
			type: 'POST',
			async: false,
			url: contextPath + requestPath,
			data: {cityNo: $('#' + cityNo).val(),areaId : $('#' + areaId).val(),servicecenterId : $('#' + servicecenterId).val(),venueId : $('#' + venueId).val(), r_m: Math.random()},
			success: function(data){
				if (data.jumpType) {
					resetClassroomId(classroomId);
					$.each(data.json, function(i, item) {
						$('#' + classroomId).append(
								"<option value='" + item.id + "'>" + item.name
										+ "</option>");
					});
				}
		    }
		});
	}
}
function resetAreaId(areaId) {
	$('#' + areaId).empty();
	$('#' + areaId).append("<option value=''>地区</option>");
}
function resetServicecenterId(servicecenterId) {
	$('#' + servicecenterId).empty();
	$('#' + servicecenterId).append("<option value=''>服务中心</option>");
}
function resetVenueId(venueId) {
	$('#' + venueId).empty();
	$('#' + venueId).append("<option value=''>教学点</option>");
}
function resetClassroomId(classroomId) {
	$('#' + classroomId).empty();
	$('#' + classroomId).append("<option value=''>教室</option>");
}

function load_location(cityNo, areaId, servicecenterId, venueId, classroomId) {
	$("#city").val(cityNo);
	locationLinkage(2, 'city', 'area', 'serviceCenter', 'venue', 'classroom');
	$("#area").val(areaId);
	locationLinkage(3, 'city', 'area', 'serviceCenter', 'venue', 'classroom');
	$("#serviceCenter").val(servicecenterId);
	locationLinkage(4, 'city', 'area', 'serviceCenter', 'venue', 'classroom');
	$("#venue").val(venueId);
	locationLinkage(5, 'city', 'area', 'serviceCenter', 'venue', 'classroom');
	$("#classroom").val(classroomId);
}


function load_basic(year, termId, gradeTypeId, gradeId,subjectIds, classLevelId) {	
	$("#year").val(year);
	basicLinkage(2, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');
	$("#term").val(termId);
	
	var term = $("#term");
	
	basicLinkage(3, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');
	$("#gradeType").val(gradeTypeId);
	basicLinkage(4, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');
	$("#grade").val(gradeId);
	basicLinkage(5, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');
	$("#subject").val(subjectIds);
	basicLinkage(6, 'year', 'term', 'gradeType', 'grade', 'subject', 'classLevel');
	$("#classLevel").val(classLevelId);
}

//请假具有原因分类
function queryLeaveTypeById(parentId,chindId)
{
		if($('#'+parentId).val()=='')
		{
			$('#'+chindId).empty();
			return;
		}
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




