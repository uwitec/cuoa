package com.oa.global.routingDataSource;

public class CustomerContextHolder {
	
	private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();  
      
	public static void setCustomerType(String customerType) {
      contextHolder.set(customerType);
      System.out.println("DataSource -> -> " + contextHolder.get());
    }  
      
    public static String getCustomerType() {  
      return (String) contextHolder.get();  
    }  
      
    public static void clearCustomerType() {  
      contextHolder.remove();  
    }  
  
}
