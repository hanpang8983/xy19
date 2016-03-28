package com.hanpang.framework.base.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Pager {
	/** 每页显示条数:设置一个默认值5 */
	private Integer pageSize = 2;
	/** 当前页数:设置一个默认值1 */
	private Integer pageNow = 1;
	/** 总记录数 */
	private Integer totalCount;
	/** 总页数 */
	private Integer totalPages;
	/** 结果集 */
	private List<?> datas;
	/**存查询提交*/
	private Map<String, Object> query = new HashMap<String, Object>();
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPageNow() {
		return pageNow;
	}
	public void setPageNow(Integer pageNow) {
		this.pageNow = pageNow;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	public Integer getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(Integer totalPages) {
		this.totalPages = totalPages;
	}
	public List<?> getDatas() {
		return datas;
	}
	public void setDatas(List<?> datas) {
		this.datas = datas;
	}
	public Map<String, Object> getQuery() {
		return query;
	}
	public void setQuery(Map<String, Object> query) {
		this.query = query;
	}
	

}
