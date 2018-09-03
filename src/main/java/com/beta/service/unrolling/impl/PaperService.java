package com.beta.service.unrolling.impl;

import java.util.List;
import javax.annotation.Resource;

import com.beta.service.unrolling.PaperManager;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


/** 
 * 说明： 归档文件目录
 * 创建人：FH Q313596790
 * 创建时间：2018-07-06
 * @version
 */
@Service("paperService")
public class PaperService implements PaperManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("PaperMapper.save", pd);
	}

	/**通过馆编档号获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByLN(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PaperMapper.findByLN", pd);
	}

	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("PaperMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("PaperMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PaperMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PaperMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PaperMapper.findById", pd);
	}

	/**通过Library_num获取数据
	 * @param pd
	 *@throws Exception
	 */
	public PageData findByPNum(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PaperMapper.findByNUM",pd);
	}


	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PaperMapper.deleteAll", ArrayDATA_IDS);
	}

	
}

