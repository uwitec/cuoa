package com.oa.global.routingDataSource;

import java.io.IOException;

import javax.mail.Session;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.orm.hibernate3.support.OpenSessionInViewFilter;

import com.oa.global.routingDataSource.changecity.CustomerContextForCity;


public class DWROpenSessionInViewFilter extends OpenSessionInViewFilter { 
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
    		System.out.println("$$$$$$$$$$$$$$$$ dwr filter: " + request.getSession().getAttribute("areaCode").toString());
        	CustomerContextHolder.setCustomerType(DataSourceMap.SLAVE + request.getSession().getAttribute("areaCode").toString());
        	CustomerContextForCity.set_city_code(request.getSession().getAttribute("areaCode").toString());
        	super.doFilterInternal(request, response, filterChain);
    }  
}
