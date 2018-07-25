package com.beta.service.finance.impl;

import com.beta.service.finance.Finance_AttachmentManager;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/** 
 * 说明： 文档附件
 * 创建人：FH Q313596790
 * 创建时间：2018-06-10
 * @version
 */
@Service("finance_attachmentService")
public class Finance_AttachmentService implements Finance_AttachmentManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Finance_AttachmentMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Finance_AttachmentMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Finance_AttachmentMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Finance_AttachmentMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Finance_AttachmentMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Finance_AttachmentMapper.findById", pd);
	}

	/**通过id获取数据
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> findByFileIdlistPage(Page page)throws Exception{
		return (List<PageData>) dao.findForList("Finance_AttachmentMapper.findByFileIdlistPage", page);
	}

	/**通过id获取数据
	 * @param id
	 * @throws Exception
	 */
	public List<PageData> findAttachmentByFileId(String id)throws Exception{
		return (List<PageData>) dao.findForList("Finance_AttachmentMapper.findAttachmentByFileId", id);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Finance_AttachmentMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

