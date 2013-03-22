package com.oa.employee.permissions.domain;

import java.util.Date;


/**
 * 员工基本信息
 */

public class Employee  implements java.io.Serializable {


    // Fields    

     private String id;
     private String loginName;
     private String name;
     private String loginPassword;
     private String serial;
     private String createrId;
     /**
      * 创建人
     */
     private Employee creater;
     private String modifierId;
     /**
      * 最后修改人ID
     */
     private Employee modifier;
     private Date createrDate;
     private Date modifyDate;
     private Integer deleted;
     private String roleId;
     /**
      * 角色
     */
     private Role role;


    // Constructors

    /** default constructor */
    public Employee() {
    }

	/** minimal constructor */
    public Employee(String loginName, String name, String loginPassword, String serial, String createrId, Date createrDate) {
        this.loginName = loginName;
        this.name = name;
        this.loginPassword = loginPassword;
        this.serial = serial;
        this.createrId = createrId;
        this.createrDate = createrDate;
    }
    
    /** full constructor */
    public Employee(String loginName, String name, String loginPassword, String serial, String createrId, Employee creater, String modifierId, Employee modifier, Date createrDate, Date modifyDate, Integer deleted, String roleId, Role role) {
        this.loginName = loginName;
        this.name = name;
        this.loginPassword = loginPassword;
        this.serial = serial;
        this.createrId = createrId;
        this.creater = creater;
        this.modifierId = modifierId;
        this.modifier = modifier;
        this.createrDate = createrDate;
        this.modifyDate = modifyDate;
        this.deleted = deleted;
        this.roleId = roleId;
        this.role = role;
    }

   
    // Property accessors

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getLoginName() {
        return this.loginName;
    }
    
    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public String getLoginPassword() {
        return this.loginPassword;
    }
    
    public void setLoginPassword(String loginPassword) {
        this.loginPassword = loginPassword;
    }

    public String getSerial() {
        return this.serial;
    }
    
    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getCreaterId() {
        return this.createrId;
    }
    
    public void setCreaterId(String createrId) {
        this.createrId = createrId;
    }
    /**       
     *      * 创建人
     */

    public Employee getCreater() {
        return this.creater;
    }
    
    public void setCreater(Employee creater) {
        this.creater = creater;
    }

    public String getModifierId() {
        return this.modifierId;
    }
    
    public void setModifierId(String modifierId) {
        this.modifierId = modifierId;
    }
    /**       
     *      * 最后修改人ID
     */

    public Employee getModifier() {
        return this.modifier;
    }
    
    public void setModifier(Employee modifier) {
        this.modifier = modifier;
    }

    public Date getCreaterDate() {
        return this.createrDate;
    }
    
    public void setCreaterDate(Date createrDate) {
        this.createrDate = createrDate;
    }

    public Date getModifyDate() {
        return this.modifyDate;
    }
    
    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public Integer getDeleted() {
        return this.deleted;
    }
    
    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public String getRoleId() {
        return this.roleId;
    }
    
    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
    /**       
     *      * 角色
     */

    public Role getRole() {
        return this.role;
    }
    
    public void setRole(Role role) {
        this.role = role;
    }
   








}