package kr.or.picsion.operation.dao;

import kr.or.picsion.operation.dto.OperPicture;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operation.dao 
 * @className OperPictureDao
 * @date 2018. 7. 2.
 */

public interface OperPictureDao {

	public int insertOperPicture(OperPicture operpicture);
	public int operPictureCancle(int operNo);
	public OperPicture selectOperpicture(int operNo);
	public int updatepicOperPicture(OperPicture operPicture);
	public int updatewpicOperPicture(OperPicture operPicture);
}
