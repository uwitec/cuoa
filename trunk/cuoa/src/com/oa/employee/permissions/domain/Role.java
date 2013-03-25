package com.oa.employee.permissions.domain;

import java.util.Date;


/**
 * 角色表
 */

public class Role  implements java.io.Serializable {


    // Fields    

     private String id;
     private String name;
     private Integer deleted;
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
     private Date createDate;
     private Date modifyDate;


    // Constructors

    /** default constructor */
    public Role() {
    }

	/** minimal constructor */
    public Role(String name, String createrId, Date createDate) {
        this.name = name;
        this.createrId = createrId;
        this.createDate = createDate;
    }
    
    /** full constructor */
    public Role(String name, Integer deleted, String createrId, Employee creater, String modifierId, Employee modifier, Date createDate, Date modifyDate) {
        this.name = name;
        this.deleted = deleted;
        this.createrId = createrId;
        this.creater = creater;
        this.modifierId = modifierId;
        this.modifier = modifier;
        this.createDate = createDate;
        this.modifyDate = modifyDate;
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

    public Integer getDeleted() {
        return this.deleted;
    }
    
    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
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

    public Date getCreateDate() {
        return this.createDate;
    }
    
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getModifyDate() {
        return this.modifyDate;
    }
    
    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }
   








}