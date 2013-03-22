var indexdata = 
[
 	{ text: '课程表管理', isexpand: false, children: [
                                            { url: "py-curriculum/curriculum-original!index.action", text: "原始课表" },
                                            { url: "py-curriculum/curriculum-modified!index.action", text: "特殊课次" },
                                            { url: "py-curriculum/curriculum-summary!index.action", text: "最终课表" } 
                                            ]},
/**
    { text: '确认课次',isexpand:false, url:"py-confirmlesson/confirmlesson!index.action"},                                        
    { text: '确认课次',isexpand:false, url:"py-confirmlesson/confirmlesson!index.action"},
    { text: '特殊课次',isexpand:false, url:"py-speciallesson/speciallesson!index.action"},
*/
    { text: '请假管理',isexpand:false, children:[
                                             { url: "py-courseleave/courseleave!indexCourse.action", text: "请假管理--班级" },
                                             { url: "py-courseleave/courseleave!indexAttMumber.action", text: "请假管理--考勤员" },
                                             { url: "py-courseleave/courseleaveadditional!indexAttMumber.action", text: "请假补差--考勤员" },
                                             { url: "py-courseleave/courseleave!indexAttChief.action", text: "请假管理--考勤主管" },
                                             { url: "py-courseleave/courseleaveadditional!indexAttChief.action", text: "请假补差--考勤主管" }
                                             ]},
    { text: '迟到管理',isexpand:false, children:[
                                             { url: "py-courselate/courselate!indexCourse.action", text: "迟到管理--班级" },
                                             { url: "py-courselate/courselate!indexAttMumber.action", text: "迟到管理--考勤员" },
                                             { url: "py-courselate/courselateadditional!indexAttMumber.action", text: "迟到补差--考勤员" },
                                             { url: "py-courselate/courselate!indexAttChief.action", text: "迟到管理--考勤主管" },
                                             { url: "py-courselate/courselateadditional!indexAttChief.action", text: "迟到补差--考勤主管" } 
                                             ]},
	 { text: '甩班管理',isexpand:false, children:[
	                                          { url: "py-rejectcourse/rejectcourse!indexCourse.action", text: "甩班管理--班级" },
	                                          { url: "py-rejectcourse/rejectcourse!indexAttMumber.action", text: "甩班管理--考勤员" },
	                                          { url: "py-rejectcourse/rejectcourseadditional!indexAttMumber.action", text: "甩班补差--考勤员" },
	                                          { url: "py-rejectcourse/rejectcourse!indexAttChief.action", text: "甩班管理--考勤主管" },
	                                          { url: "py-rejectcourse/rejectcourseadditional!indexAttChief.action", text: "甩班补差--考勤主管" } 
	                                          ]},
	 { text: '例会缺勤管理',isexpand:false, children:[
	                                          { url: "py-meeting/meeting!indexCourse.action", text: "例会管理--班级" },
	                                          { url: "py-meeting/meeting!indexAttMumber.action", text: "例会管理--考勤员" },
	                                          { url: "py-meeting/meeting!indexAttChief.action", text: "例会管理--考勤主管" }
	                                          ]} ,
	 { text: '跨点上课管理',isexpand:false, url:"py-crossarea/crossarea!index.action"},
	 { text: '考勤表',isexpand:false, url: "py-attendsummary/attendSummary!index.action"},
 	 { text: '财务监控管理',isexpand:false, url: "py-curriculum/curriculum-finance!indexFinance.action"}                                            
                                      
];


var indexdata2 =
[
    { isexpand: "true", text: "表格", children: [
        { isexpand: "true", text: "可排序", children: [
		    { url: "dotnetdemos/grid/sortable/client.aspx", text: "客户端" },
            { url: "dotnetdemos/grid/sortable/server.aspx", text: "服务器" }
	    ]
        },
        { isexpand: "true", text: "可分页", children: [
		    { url: "dotnetdemos/grid/pager/client.aspx", text: "客户端" },
            { url: "dotnetdemos/grid/pager/server.aspx", text: "服务器" }
	    ]
        },
        { isexpand: "true", text: "树表格", children: [
		    { url: "dotnetdemos/grid/treegrid/tree.aspx", text: "树表格" } 
	    ]
        }
    ]
    }
];
