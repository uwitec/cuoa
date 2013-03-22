package com.oa.global.interceptor;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class ReplaceInvalidCharInterceptor extends AbstractInterceptor 
{
    private static Logger logger=Logger.getLogger(ReplaceInvalidCharInterceptor.class);
	public String intercept(ActionInvocation actionInvocation) throws Exception 
	{
		Map params=actionInvocation.getInvocationContext().getParameters();
		Set keys=params.keySet();
		Iterator it=keys.iterator();
		while(it.hasNext())
		{
			Object obj=it.next();
			
			if(!(params.get(obj) instanceof String[]))
			{
				continue;
			}
			
			String[] strs=(String[])params.get(obj);
			for(int i=0;i<strs.length;i++)
			{
				
				String message=StringUtils.trim(((String[])params.get(obj))[i]);

//				if(!StringUtils.isBlank(message))
//				{   
					//message = message.replace(" exec ", "_");
					//message = message.replace(" insert ", "_");
					//message = message.replace(" select ", "_");
					//message = message.replace(" delete ", "_");
					//message = message.replace(" from ", "_");
					//message = message.replace(" update ", "_");
					//message = message.replace(" count ", "_");
					//message = message.replace(" user ", "_");
					//message = message.replace(" xp_cmdshell ", "_");
					//message = message.replace(" add ", "_");
					//message = message.replace(" net ", "_");
					//message = message.replace(" Asc ", "_");
					//message = message.replace("'", "_");
					//message = message.replace('"', '_');
					
								
					//message = message.replace("javascript", "_");
					//message = message.replace("jscript", "_");
					//message = message.replace("vbscript", "_");
					
					//message = message.replace('<','_');
		            //message = message.replace('>','_');
		           //message = message.replace('\'','_');
		           // message = message.replace('#','_');
		            //message = message.replace('\\','_');
		            //message = message.replace('/','_');
		            //message = message.replace('%','_');
					//message = message.replace(';','_');
					//message = message.replace('(','_');
					//message = message.replace(')','_');
					//message = message.replace('&','_');
					//message = message.replace('+','_');
					//message = message.replace('*','_');
					//message = message.replace('=','_');
					
				//}
				
				strs[i]=message;
			}
			params.put(obj, strs);
			
		}
		actionInvocation.getInvocationContext().setParameters(params);
		
		return actionInvocation.invoke();
	}

}
