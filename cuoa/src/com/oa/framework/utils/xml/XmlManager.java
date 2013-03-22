package com.oa.framework.utils.xml;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
public class XmlManager {
	/**
	 * 得到某节点下某个属性的值
	 * @param element	要获取属性的节点
	 * @param attributeName	要取值的属性名称
	 * @return	要获取的属性的值
	 * @author HX_2010-01-12
	 */
	public static String getAttribute( Element element, String attributeName ) {
		return element.getAttribute( attributeName );
	}
	
	/**
	 * 获取指定节点下的文本
	 * @param element	要获取文本的节点
	 * @return	指定节点下的文本
	 * @author HX_2010-01-12
	 */
	public static String getText( Element element ) {
		Node node=element.getFirstChild();
		if(node==null){
			return null;
		}
		return node.getNodeValue();
	}
	
	/**
	 * 解析某个xml文件，并在内存中创建DOM树
	 * @param xmlFile	要解析的XML文件
	 * @return	解析某个配置文件后的Document
	 * @throws Exception	xml文件不存在
	 */
	public static Document parseXmlFile( String xmlFile ) throws Exception {
		// 绑定XML文件，建造DOM树
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document domTree = db.parse( xmlFile );
		return domTree;
	}
	
	/**
	 * 解析xml字符串
	 * @param xmlString
	 * @return
	 * @throws Exception
	 */
	public static Document parseXmlString(String xmlString) throws Exception{
		DocumentBuilderFactory factory = DocumentBuilderFactory .newInstance();
		DocumentBuilder builder;
		Document document;
		builder = factory.newDocumentBuilder();
		InputStream is = new ByteArrayInputStream(xmlString.getBytes());
		document = builder.parse(is);
		is.close();
		return document;
	}
	
	/**
	 * 获得某节点下的某个子节点（指定子节点名称，和某个属性的值）<br>
	 * 即获取parentElement下名字叫childName，并且属性attributeName的值为attributeValue的子结点
	 * @param parentElement	要获取子节点的那个父节点
	 * @param childName	要获取的子节点名称
	 * @param attributeName	要指定的属性名称
	 * @param attributeValue	要指定的属性的值
	 * @return	符合条件的子节点
	 * @throws Exception	子结点不存在或有多个符合条件的子节点
	 * @author HX_2008-12-01
	 */
	public static Element getChildElement( Element parentElement, String childName, String attributeName, String attributeValue ) throws Exception {
		NodeList list = parentElement.getElementsByTagName( childName );
		int count = 0;
		Element curElement = null;
		for ( int i = 0 ; i < list.getLength() ; i ++ ) {
			Element child = ( Element )list.item( i );
			String value = child.getAttribute( attributeName );
			if ( true == value.equals( attributeValue ) ) {
				curElement = child;
				count ++;
			}
		}
		if ( 0 == count ) {
			throw new Exception( "找不到个符合条件的子节点！" );
		} else if ( 1 < count ) {
			throw new Exception( "找到多个符合条件的子节点！" );
		}
		
		return curElement;
	}
	
	public static String getChileElementText(Element parentElement, String childName) throws Exception{
		return getText(getChildElement(parentElement,childName));
	}
	/**
	 * 得到某节点下的某个子节点（通过指定子节点名称）<br>
	 * 即获取parentElement下名字叫childName的子节点
	 * @param parentElement	要获取子节点的父节点
	 * @param childName	要获取的子节点名称
	 * @return	符合条件的子节点
	 * @throws Exception	找不到符合条件的子结点或找到多个符合条件的子节点
	 */
	public static Element getChildElement( Element parentElement, String childName ) throws Exception {
		NodeList list = parentElement.getElementsByTagName( childName );
		Element curElement = null;
		if ( 1 == list.getLength()  ) {
			curElement = ( Element )list.item( 0 );
		} else if ( 0 == list.getLength() ) {
			throw new Exception( "找不到个符合条件的子节点！" );
		} else {
			throw new Exception( "找到多个符合条件的子节点！" );
		}
		return curElement;
	}
	
	/**
	 * 通过tagName 得到xml字符串相关节点的tag字符串
	 * @param xmlString
	 * @param tagName
	 * @return
	 */
	public static String getStringByTagName(String xmlString, String tagName) {
		Document document = null;
		String elementText = "";
		try {
			document = XmlManager.parseXmlString(xmlString);
			Element root = document.getDocumentElement();
			elementText = XmlManager.getChileElementText(root, "tagName");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return elementText;
	}
	
	
//	public static Map<String, String> putChildrenInMap(String xmlString, String parentTagName) {
//		Map<String, String> returnMap = new HashMap<String, String>();
//		Document document = null;
//		try {
//			document = XmlManager.parseXmlString(xmlString);
//			Element root = document.getDocumentElement();
//			Element childrenElement = XmlManager.getChildElement(root, "SOAP-ENV:Body");
//			Element cchildrenElement = XmlManager.getChildElement(childrenElement, "adduserResponse");
//			NodeList nodeList = cchildrenElement.getChildNodes();
//			System.out.println(nodeList);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return returnMap;
//	}
	
	public static void main(String[] args) {
		StringBuilder builder = new StringBuilder();
		System.out.println("dsfdfas");
		builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		builder.append("<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\">");
		builder.append("<SOAP-ENV:Body>");
		  builder.append("<adduserResponse xmlns=\"urn:adduser\">");
		  builder.append("<rlt xmlns=\"\">false</rlt> 布尔型，返回添加的结果");
		      builder.append("<msg xmlns=\"\">消息 </msg> 字符串型 消息");
		      builder.append("</adduserResponse>");
		      builder.append("</SOAP-ENV:Body>");
		  builder.append("</SOAP-ENV:Envelope>");
		Document document = null;
		try {
//			document = XmlManager.parseXmlString(builder.toString());
//			Element root =document.getDocumentElement();
//			System.out.println(root.getNodeName());
//			System.out.println(XmlManager.getChileElementText(root, "rlt"));
//			System.out.println(XmlManager.getChileElementText(root, "msg"));
//			System.out.println(XmlManager.putChildrenInMap(builder.toString(), "adduserResponse"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		 
	}
}
