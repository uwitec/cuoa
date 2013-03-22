package com.oa.global.routingDataSource;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

import com.oa.global.routingDataSource.changecity.CustomerContextForCity;

public class StrutsPrepareAndExecuteImplFilter extends StrutsPrepareAndExecuteFilter {
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
    	super.doFilter(request, response, filterChain);
	}  
}
