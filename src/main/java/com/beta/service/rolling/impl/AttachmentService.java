package com.beta.service.rolling.impl;

import java.util.List;
import javax.annotation.Resource;

import com.beta.service.rolling.AttachmentManager;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


/** 
 * 说明： 文档附件
 * 创建人：FH Q313596790
 * 创建时间：2018-06-10
 * @version
 */
@Service("attachmentService")
public class AttachmentService implements AttachmentManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("AttachmentMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("AttachmentMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("AttachmentMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AttachmentMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AttachmentMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AttachmentMapper.findById", pd);
	}

	/**通过id获取数据
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> findByFileIdlistPage(Page page)throws Exception{
		return (List<PageData>) dao.findForList("AttachmentMapper.findByFileIdlistPage", page);
	}

	/**通过id获取数据
	 * @param id
	 * @throws Exception
	 */
	public List<PageData> findAttachmentByFileId(String id)throws Exception{
		return (List<PageData>) dao.findForList("AttachmentMapper.findAttachmentByFileId", id);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("AttachmentMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

