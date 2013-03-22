package com.oa.global.routingDataSource.changecity;

public class CustomerContextForCity {
	
	private CustomerContextForCity() {
		throw new AssertionError();
	}
	
	public static final ThreadLocal<String> city_code = new ThreadLocal<String>();
	
	public static void set_city_code(String source) {
		city_code.set(source);
	}
	
	public static String get_city_code() {
		return city_code.get().toString();
	}
	
}
