package com.oa.framework.struts;

import com.oa.global.constants.EMessageCode;

import net.sf.json.JSON;


/**
 * 结果类：service 或者 action 返回值 
 * @author sunchuanbao
 */
public class Result<T extends Object> {
	
	private boolean success;//操作 是否成功
	private String code;//返回值编号   参照sixt-web/classes/message_zh_CN.properties
	private String message;//返回消息
	private T data;//返回附加信息 可以是String、List、JSON、Map 类型
	
	private Object[] codeParams; //返回值参数
	
	@Deprecated
	private boolean jumpType;
	@Deprecated
	private String returnMessage;
	@Deprecated
	private String jumpUrl;
	@Deprecated
	private JSON json;
	
	public Result(boolean success) {
		this.success = success;
		if(success){
			this.setCode(EMessageCode.SUCCESS.getCode());//操作成功
		}else{
			this.setCode(EMessageCode.FAIL.getCode());//操作失败
		}
		
	}
	public Result(boolean success, String code) {
		super();
		this.success = success;
		this.code = code;
	}
	
	public Result(boolean success, String code, Object[] codeParams) {
		super();
		this.success = success;
		this.code = code;
		this.codeParams = codeParams;
	}
	
	@Deprecated
	/**
	 * Description: 仅用于联动
	 */
	public Result(boolean jumpType, String returnMessage, String jumpUrl) {
		this.jumpType = jumpType;
		this.returnMessage = returnMessage;
		this.jumpUrl = jumpUrl;
	}

	@Deprecated
	/**
	 * Description: 仅用于联动
	 */
	public Result(boolean jumpType, String returnMessage, String jumpUrl,JSON json) {
		this.jumpType = jumpType;
		this.returnMessage = returnMessage;
		this.jumpUrl = jumpUrl;
		this.json = json;
	}
	
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public T getData() {
		return data;
	}
	public void setData(T data) {
		this.data = data;
	}
	
	public Object[] getCodeParams() {
		return codeParams;
	}
	public void setCodeParams(Object[] codeParams) {
		this.codeParams = codeParams;
	}
	
	
	public boolean isJumpType() {
		return jumpType;
	}
	public void setJumpType(boolean jumpType) {
		this.jumpType = jumpType;
	}
	public String getReturnMessage() {
		return returnMessage;
	}
	public void setReturnMessage(String returnMessage) {
		this.returnMessage = returnMessage;
	}
	public String getJumpUrl() {
		return jumpUrl;
	}
	public void setJumpUrl(String jumpUrl) {
		this.jumpUrl = jumpUrl;
	}
	public JSON getJson() {
		return json;
	}
	public void setJson(JSON json) {
		this.json = json;
	}
	
	
}
