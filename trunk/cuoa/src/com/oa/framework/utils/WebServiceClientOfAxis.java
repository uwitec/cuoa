package com.oa.framework.utils;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.xml.namespace.QName;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.rpc.ServiceException;

import org.apache.axis.client.Call;
import org.apache.axis.constants.Style;
import org.apache.axis.message.SOAPBodyElement;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class WebServiceClientOfAxis {
//	static final String ns = "http://www.uctest.com/webservices";
	
	
	public static Call createCall(String ns,String url,String actionURI,String operationName,String portName,String portTypeName) throws MalformedURLException, ServiceException{   
	      org.apache.axis.client.Service s = new org.apache.axis.client.Service();   
	      Call call = (Call) s.createCall();   
	      call.setTargetEndpointAddress(new URL(url));//"http://www.uctest.com/webservices/validpass.php?wsdl"
	      call.setSOAPActionURI(actionURI);//validpass   
	      call.setOperationName(operationName);//validpass   
	      call.setProperty(Call.OPERATION_STYLE_PROPERTY, Style.DOCUMENT.getName());   
	      call.setPortName(new QName(ns, portName));//validpassPort
	      call.setPortTypeName(new QName(ns,portTypeName));//validpass

	      return call;   
	  }   

	    /**创建请求参数，实际上就是构建DOM片断，根据Web service对输入参数的要求来构建，要多复杂，都可以实现，       *这就是Docuemnt的好处，省去了复杂对象的序列化。       */  
	  public static Object[] createRequest(String ns,String requestRootName,List<Map<String,String>> params) throws ParserConfigurationException, FactoryConfigurationError{   
	      DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();   
	      Document doc = db.newDocument();   
	      Element root = doc.createElementNS(ns, requestRootName);//validpass  

	      for(Map<String,String> map:params){
	    	  String key=map.keySet().iterator().next();
	    	  Element element=doc.createElementNS(ns,key);
	    	  element.appendChild(doc.createTextNode(map.get(key)));
	    	  root.appendChild(element);
	      }
	      doc.appendChild(root);   

	      return new Object[]{new SOAPBodyElement(root)};   
	  }   

	    // 对返回结果进行解析 
	  public static Map<String,String> parseSoapResponse(Vector v,List<String> keyList) throws Exception{   
	      Document doc = ((SOAPBodyElement) v.get(0)).getAsDocument();   
	      
	      Element root = doc.getDocumentElement();
	      Map<String,String> result=new HashMap();
	      for(String key:keyList){
	    	  result.put(key,XmlManager.getChileElementText(root,key));
	      }
	      
	      return result;
	       
	      
	  } 
	  
	  
	  //通用方法
	  @SuppressWarnings("unchecked")
	public static Map<String,String> callService(String ns, String wsdl, String actionURI,String operationName,String portName,String portTypeName,
			  List<String> paramNames, List<String> paramValues) {
		  Call call = null;
		  Map<String,String> returnMap = new HashMap<String,String>();
		  try {
			  call = createCall(ns, wsdl, actionURI, operationName, portName, portTypeName);
			  List<Map<String,String>> paramsList = new ArrayList<Map<String,String>>();
			  int i = 0;
	          for (String paramName: paramNames) {
	        	  Map<String, String> paramsMap = new HashMap<String, String>();
	        	  System.out.println(paramName + ": " +  paramValues.get(i));
	        	  paramsMap.put(paramName, paramValues.get(i) == null ? "" : paramValues.get(i));
	        	  paramsList.add(paramsMap);
	        	  i ++;
	          }
	          Vector rtn = (Vector) call.invoke(createRequest(ns,actionURI,paramsList));
	          List<String> list = new ArrayList();
	          list.add("rlt");
	          list.add("msg");
	          returnMap = parseSoapResponse(rtn,list); 
	          System.out.println("returnMap: " + returnMap);
		  } catch (Exception e) {
			  e.printStackTrace();
		  }
	       return returnMap;
	  }
	  
	  
	  
	  public static void main(String[] args){
		  Call call = null;   
	       try {
	    	   String ns = "http://www.uctest.com/webservices";
	           call = createCall(ns,"http://www.uctest.com/webservices/validpass.php?wsdl","validpass","validpass","validpassPort","validpass"); 
	           List<Map<String,String>> params=new ArrayList();
	           Map<String,String> map=new HashMap();
	           map.put("type", "2");
	           params.add(map);
	           map=new HashMap();
	           map.put("loginval","15101062622");
	           params.add(map);
	           map=new HashMap();
	           map.put("pass", "82026833");
	           params.add(map);
	           Vector rtn = (Vector) call.invoke(createRequest(ns,"validpass",params));  
	           List<String> list=new ArrayList();
	           list.add("rlt");
	           list.add("msg");
	           Map<String,String> result=parseSoapResponse(rtn,list);  
	           System.out.println(result.toString());
	       } catch (MalformedURLException e) {   
	           // TODO Auto-generated catch block   
	           e.printStackTrace();   
	       } catch (RemoteException e) {   
	           // TODO Auto-generated catch block   
	           e.printStackTrace();   
	       } catch (ParserConfigurationException e) {   
	           // TODO Auto-generated catch block   
	           e.printStackTrace();   
	       } catch (FactoryConfigurationError e) {   
	           // TODO Auto-generated catch block   
	           e.printStackTrace();   
	       } catch (Exception e) {   
	           // TODO Auto-generated catch block   
	           e.printStackTrace();   
	       }   
	  
			
		}
}
