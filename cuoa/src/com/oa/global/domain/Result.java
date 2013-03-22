package com.oa.global.domain;

import net.sf.json.JSON;
import net.sf.json.JSONObject;

public class Result {

	private boolean jumpType;
	private String returnMessage;
	private String jumpUrl;
	private JSON json;
	private String asyncTokenId;
	public Result() {

	}

	public Result(boolean jumpType, String returnMessage, String jumpUrl) {
		this.jumpType = jumpType;
		this.returnMessage = returnMessage;
		this.jumpUrl = jumpUrl;
	}

	public Result(boolean jumpType, String returnMessage, String jumpUrl,JSON json) {
		this.jumpType = jumpType;
		this.returnMessage = returnMessage;
		this.jumpUrl = jumpUrl;
		this.json = json;
	}
	
	/**包含自定义TOKEN的构造方法*/
	public Result(boolean jumpType, String returnMessage, String jumpUrl, String asyncTokenId) {
		this.jumpType = jumpType;
		this.returnMessage = returnMessage;
		this.jumpUrl = jumpUrl;
		this.asyncTokenId = asyncTokenId;
	}
	
	/**包含自定义TOKEN的构造方法*/
	public Result(boolean jumpType, String returnMessage, String jumpUrl, JSON json, String asyncTokenId) {
		this.jumpType = jumpType;
		this.returnMessage = returnMessage;
		this.jumpUrl = jumpUrl;
		this.json = json;
		this.asyncTokenId = asyncTokenId;
	}
	
	public boolean getJumpType() {
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

	public String getAsyncTokenId() {
		return asyncTokenId;
	}

	public void setAsyncTokenId(String asyncTokenId) {
		this.asyncTokenId = asyncTokenId;
	}
	
	
}
