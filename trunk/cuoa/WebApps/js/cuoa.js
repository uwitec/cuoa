/**
 * public
 */
/*根绝ID获得页面元素*/
var conditionFormId="";
function gg(id) {
	return document.getElementById(id);
};
/*刷新父页面-子窗口调用*/
function home_fresh() {
	//window.top.frames[0].location.reload();
	window.parent.location.reload();
}
/*关闭子窗口-子窗口调用*/
function closeWindow(){
	$(".l-dialog,.l-window-mask",parent.document).remove();
}
/*表单验证*/
$(function () {
	// <form class="validate"></form>
	$('form.validate').validate({
		errorPlacement: function(error, element) {
			error.appendTo(element.parents("li"));
		}
	});
});

function f_param(){
	removeDivContent("export_param_div");
	var param = [];
	param_instance = '';
	$("#"+conditionFormId+" select, input[type=text],input[type=hidden], textarea").each(function(){
		var dom=$(this).get(0);
		param.push({name:dom.name, value:dom.value});
		putValueInHidden("", dom.name, dom.value);
	});
	return param;
}

function exportData(requestURL, exclusiveColumns, role) {
	putValueInHidden("requestUrlE","condition.requestUrlE",requestURL);
	putValueInHidden("","title",getTitle(exclusiveColumns));
	putValueInHidden("","key",getKey(exclusiveColumns));
	if (role != null) {
		putValueInHidden("", "condition.role", role);		
	}
	putValueInHidden("batchIds","batchIds",checkedIds.join(','));

	dialog = $.ligerDialog.open({ 
    	url: contextPath + "/common/export!exportDataIndex.action",
    	width: 700,
    	height: 270,
    	title: "导出数据"
    });
	return url;
}

function removeDivContent(div_id) {
	$("#" + div_id).remove();
}

//把需要用到的参数动态存入hidden中
function putValueInHidden(id, name, value) {
	if (!document.getElementById("export_param_div")) {
		$("form").before("<div id='export_param_div'><div>");
	}
	if (!document.getElementById("export_other_param_div")) {
		$("form").before("<div id='export_other_param_div'><div>");
	}
	if (id == "") {
		$("#export_param_div > input[name='" + name + "']").remove();
		$("#export_param_div").append("<input type='hidden' value='" + value + "'name='" + name +  "'/>");
		
	} else {
		if (name !="pageNumE" && name != "pageSizeE") {
			$("#" + id).remove();
			$("#export_other_param_div").append("<input type='hidden' id='"+ id + "'value='" + value + "'name='" + name +  "'/>");
		}
	}

}


/*显示表格列表*/
function showGrid(grid){
	if(!grid)return null;
	var _gridid=grid.gridid; //必填
	var _columns=grid.columns; //必填
	var _conditionname=grid.condition||"condition";
	var _url=grid.url;//必填
	var _formid=grid.formid;//必填
	conditionFormId=_formid;
	var _toolbar=grid.toolbar;
	var _checkbox=grid.checkbox||false;
	
	var _grid=$("#"+_gridid).ligerGrid({
	        columns: _columns,//表头
	        url: _url,//服务器地址 返回json格式
	        parms:f_param,//查询参数  可以是 function(返回数组)、数组  -------数组格式必须是[{name:'xxx',value,'yyy'},{name:'nnn',value,'mmm'}...]
	        toolbar:_toolbar,//工具条--在表头的上面
	        checkbox: _checkbox,                         //是否显示复选框 默认不显示
	        
	        switchPageSizeApplyComboBox: true,     //切换每页记录数是否应用ligerComboBox
	        root:'data',//返回json格式数组的key
	        record:'recordSize',//总记录数
	        pageParmName:_conditionname+'.pageNo', //页索引参数名，(提交给服务器)
	        pagesizeParmName:_conditionname+'.pageSize',//页记录数参数名，(提交给服务器)
	        sortnameParmName: _conditionname+'.sortname',//页排序列名(提交给服务器)
	        sortorderParmName: _conditionname+'.sortorder',//页排序方向(提交给服务器)
	        pageSize: 20, //每页默认的结果数
	        page:1, //默认当前页 
	        pageSizeOptions: [10,20, 50 ,100], //可选择设定的每页结果数
	        selectRowButtonOnly: true, //复选框模式时，是否只允许点击复选框才能选择行
	        
	    	isChecked: f_isChecked, 
	    	onCheckRow: f_onCheckRow, 
	    	onCheckAllRow: f_onCheckAllRow

	        
    	});
	return _grid;
}
/*弹出窗口*/
function showWindow(win){
	if(!win)return null;
	var _url=win.url||"";
	var _title=win.title||"";
	var _name=win.name||"";
	var _height=win.height||500;
	var _width=win.width||700;
	var _buttons=win.buttons||null;
	
    var  dialog = $.ligerDialog.open({ 
    	url:_url,//地址
    	height:_height,//窗口高度 默认是500
    	width: _width, //窗口宽度 默认是700
    	buttons:_buttons//按钮数组
    });
    return dialog;
}
/*弹出确认框*/
function confirm(title,message,callback){
	$.ligerMessageBox.confirm(title,message, function (yes){
        if(yes&&callback&&typeof(callback)=="function"){
			callback();
		}
    });
}
/*弹出提示对话框*/
function alertt(content, type,callback){
	var _callback=null;
	var _type=null;
	if(typeof(type)=="string"){
		_type=type;
		_callback=callback;
	}else if(typeof(type)=="function"){
		_callback=type;
		_type=null;
	}
	if(!_type){
		return $.ligerMessageBox.alert("提示",content,"",_callback);
	}
	switch (_type)
    {
        case "success":
        	$.ligerMessageBox.success("成功",content,_callback);
            break;
        case "warn":
        	$.ligerMessageBox.warn("警告",content,_callback);
            break;
        case "question":
        	$.ligerMessageBox.question("问题",content,_callback);
            break;
        case "error":
        	$.ligerMessageBox.error("错误",content,_callback);
            break;
    }
}
/**
 * alert 的callback 方法：刷新父窗口页面、关闭子窗口
 */
function alert_btnclick(){
	home_fresh();
  	closeWindow();
}

function getTitle(exclusiveColumns) {
	var title = "";
	for (i = effectiveCount = 0; i < grid.columns.length; i ++) {
		if (getIsExclusive(exclusiveColumns, i)) {
			continue;
		}
		title = title + (effectiveCount == 0 ? grid.columns[i].display : "," + grid.columns[i].display);
		effectiveCount ++;
	}
	return title;
}
function getKey(exclusiveColumns) {
	var key = "";
	for (i = effectiveCount = 0; i < grid.columns.length; i ++) {
		if (getIsExclusive(exclusiveColumns, i)) {
			continue;
		}
		key = key + (effectiveCount == 0 ? grid.columns[i].name : "," + grid.columns[i].name);
		effectiveCount ++;
	}
	return key;
}

function getIsExclusive(exclusiveColumns, column) {
	for (j = 0; j < exclusiveColumns.length; j ++) {
		if (exclusiveColumns[j] == column) {
			return true;
		}
	}
	return false;
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
function f_getChecked()
{
    alert(checkedIds.join(','));
}

