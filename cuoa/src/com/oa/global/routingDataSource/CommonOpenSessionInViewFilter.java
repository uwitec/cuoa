package com.oa.global.routingDataSource;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.orm.hibernate3.support.OpenSessionInViewFilter;

import com.oa.global.routingDataSource.changecity.CustomerContextForCity;

public class CommonOpenSessionInViewFilter extends OpenSessionInViewFilter {
	 protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
     	if (request.getSession().getAttribute("areaCode") != null) {
     	}
     	super.doFilterInternal(request, response, filterChain);
	 }  
}
