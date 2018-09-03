package com.beta.service.rolling.impl;

import java.awt.peer.ListPeer;
import java.util.List;
import javax.annotation.Resource;

import com.beta.service.rolling.FileManager;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


/** 
 * 说明： 卷内文件目录
 * 创建人：FH Q313596790
 * 创建时间：2018-07-04
 * @version
 */
@Service("fileService")
public class FileService implements FileManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("FileMapper.save", pd);
	}
	/**通过编号获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findBySN(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileMapper.findBySN", pd);
	}


	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("FileMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("FileMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FileMapper.datalistPage", page);
	}

	/**查找列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listW(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FileMapper.datalistPageSearch",page);
	}

	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileMapper.findById", pd);
	}

	/**通过num获取数据
	 *@param pd
	 *@throws Exception
	 */
	public List<PageData> findByNum(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileMapper.findByNum",pd);
	}

	/**查找volume_num和file_sn
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByFName(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileMapper.findByName", pd);
	}


	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FileMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

