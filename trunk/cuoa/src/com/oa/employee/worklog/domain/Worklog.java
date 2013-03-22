package com.oa.employee.worklog.domain;

import com.oa.employee.permissions.domain.Employee;
import java.util.Date;


/**
 * 员工工作日志
 */

public class Worklog  implements java.io.Serializable {


    // Fields    

     private String id;
     private String employeeId;
     /**
      * 员工
     */
     private Employee employee;
     private String caption;
     private String logContent;
     private Date logDate;
     private String createrId;
     /**
      * 创建人
     */
     private Employee creater;
     private String modifierId;
     /**
      * 最后修改人
     */
     private Employee modifier;
     private Date createrDate;
     private Date modifyDate;
     private Integer deleted;


    // Constructors

    /** default constructor */
    public Worklog() {
    }

    
    /** full constructor */
    public Worklog(String employeeId, Employee employee, String caption, String logContent, Date logDate, String createrId, Employee creater, String modifierId, Employee modifier, Date createrDate, Date modifyDate, Integer deleted) {
        this.employeeId = employeeId;
        this.employee = employee;
        this.caption = caption;
        this.logContent = logContent;
        this.logDate = logDate;
        this.createrId = createrId;
        this.creater = creater;
        this.modifierId = modifierId;
        this.modifier = modifier;
        this.createrDate = createrDate;
        this.modifyDate = modifyDate;
        this.deleted = deleted;
    }

   
    // Property accessors

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getEmployeeId() {
        return this.employeeId;
    }
    
    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
    /**       
     *      * 员工
     */

    public Employee getEmployee() {
        return this.employee;
    }
    
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public String getCaption() {
        return this.caption;
    }
    
    public void setCaption(String caption) {
        this.caption = caption;
    }

    public String getLogContent() {
        return this.logContent;
    }
    
    public void setLogContent(String logContent) {
        this.logContent = logContent;
    }

    public Date getLogDate() {
        return this.logDate;
    }
    
    public void setLogDate(Date logDate) {
        this.logDate = logDate;
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
     *      * 最后修改人
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
   








}