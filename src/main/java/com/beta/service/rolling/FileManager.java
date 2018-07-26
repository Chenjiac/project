package com.beta.service.rolling;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 卷内文件目录接口
 * 创建人：FH Q313596790
 * 创建时间：2018-07-04
 * @version
 */
public interface FileManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;

	/**查找列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listW(Page page) throws Exception;

	/**列表(全部)
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;


	/**通过NUM获取数据
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByNum(PageData pd) throws Exception;


	/**查找volume_num和file_sn
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByFName(PageData pd)throws Exception;


	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

