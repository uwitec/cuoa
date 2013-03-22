package com.oa.global.domain;

import net.sf.json.JSON;
import net.sf.json.JSONObject;

public class ServiceResult {

	private boolean isSuccess;
	private String returnCode;
	private String returnMessage;
	public ServiceResult() {
	}

	public ServiceResult(boolean isSuccess,String returnMessage){
		this.isSuccess=isSuccess;
		this.returnMessage=returnMessage;
	}

	public boolean isSuccess() {
		return isSuccess;
	}

	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}

	public String getReturnMessage() {
		return returnMessage;
	}

	public void setReturnMessage(String returnMessage) {
		this.returnMessage = returnMessage;
	}

	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}
	
}
