package com.oa.global.constants;
public enum EStatus {
	TRUE(1),//是
	FALSE(0);//否
	private int code;

    EStatus(int code) {
        this.code = code;
    }

    public int getCode() {
        return this.code;
    }
    
}
