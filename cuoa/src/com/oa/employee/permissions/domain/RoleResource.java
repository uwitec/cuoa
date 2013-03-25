package com.oa.employee.permissions.domain;



/**
 * 角色－权限资源 关系表
 */

public class RoleResource  implements java.io.Serializable {


    // Fields    

     private String id;
     private String roleId;
     /**
      * role
     */
     private Role role;
     private String resourceId;
     /**
      * 权限资源
     */
     private Resource resource;


    // Constructors

    /** default constructor */
    public RoleResource() {
    }

	/** minimal constructor */
    public RoleResource(String roleId, String resourceId) {
        this.roleId = roleId;
        this.resourceId = resourceId;
    }
    
    /** full constructor */
    public RoleResource(String roleId, Role role, String resourceId, Resource resource) {
        this.roleId = roleId;
        this.role = role;
        this.resourceId = resourceId;
        this.resource = resource;
    }

   
    // Property accessors

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getRoleId() {
        return this.roleId;
    }
    
    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
    /**       
     *      * role
     */

    public Role getRole() {
        return this.role;
    }
    
    public void setRole(Role role) {
        this.role = role;
    }

    public String getResourceId() {
        return this.resourceId;
    }
    
    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }
    /**       
     *      * 权限资源
     */

    public Resource getResource() {
        return this.resource;
    }
    
    public void setResource(Resource resource) {
        this.resource = resource;
    }
   








}