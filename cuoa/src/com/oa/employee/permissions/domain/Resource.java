package com.oa.employee.permissions.domain;



/**
 * 权限资源表
 */

public class Resource  implements java.io.Serializable {


    // Fields    

     private String id;
     private String name;
     private String parentId;
     private String url;
     private Integer isMenu;
     private Integer deleted;


    // Constructors

    /** default constructor */
    public Resource() {
    }

	/** minimal constructor */
    public Resource(String name, String parentId) {
        this.name = name;
        this.parentId = parentId;
    }
    
    /** full constructor */
    public Resource(String name, String parentId, String url, Integer isMenu, Integer deleted) {
        this.name = name;
        this.parentId = parentId;
        this.url = url;
        this.isMenu = isMenu;
        this.deleted = deleted;
    }

   
    // Property accessors

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public String getParentId() {
        return this.parentId;
    }
    
    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getUrl() {
        return this.url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getIsMenu() {
        return this.isMenu;
    }
    
    public void setIsMenu(Integer isMenu) {
        this.isMenu = isMenu;
    }

    public Integer getDeleted() {
        return this.deleted;
    }
    
    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }
   








}