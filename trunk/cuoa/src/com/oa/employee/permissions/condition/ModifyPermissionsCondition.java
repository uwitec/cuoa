package com.oa.employee.permissions.condition;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;

import com.oa.framework.paginaction.Condition;
import com.oa.framework.utils.string.StringUtil;

public class ModifyPermissionsCondition extends Condition {

	private static final long serialVersionUID = 1377767992907054904L;

	private String roleId;
	private String resourceIds;
	private String operateType;
	@Override
	public String getInitialHql() {
		StringBuilder builder = new StringBuilder();
		if (operateType.equals("delete")) {
			 builder.append("delete from tb_role_resource where rr_role_id=:roleId and rr_resource_id in (:resourceIdList)");
			 
		} else if (operateType.equals("add")) {
			String[] resourceIdArr = resourceIds.split(",");
			builder.append("insert into tb_role_resource (rr_id, rr_role_id, rr_resource_id) values ");
			for (int i = 0; i < resourceIdArr.length; i ++) {
				builder.append("('").append(StringUtil.generateString()).append("', :roleId, '").append(resourceIdArr[i]) .append("')");
				if (i < resourceIdArr.length - 1) {
					builder.append(",");
				}
			}
			builder.append("");
		}
		return builder.toString();
	}
	
	@Override
	public Query preparedParams(Query query) {
		if (operateType.equals("delete")) {
			List<String> resourceIdList = new ArrayList<String>();
			String[] resourceIdArr = resourceIds.split(",");
			for (String resourceId: resourceIdArr) {
				resourceIdList.add(resourceId);
			}
			query.setParameterList("resourceIdList", resourceIdList);
		} else if (operateType.equals("add")) {
			;
		}
		query.setParameter("roleId", roleId);
		return query;
	}
	
	public String getResourceIds() {
		return resourceIds;
	}
	public void setResourceIds(String resourceIds) {
		this.resourceIds = resourceIds;
	}
	public String getOperateType() {
		return operateType;
	}
	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
}
