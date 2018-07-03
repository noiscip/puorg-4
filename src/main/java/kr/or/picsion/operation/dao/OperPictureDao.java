package kr.or.picsion.operation.dao;

import kr.or.picsion.operation.dto.OperPicture;

public interface OperPictureDao {

	public int insertOperPicture(OperPicture operpicture);
	public int updateOperation(OperPicture operpicture);
	public OperPicture selectOperpicture(int operNo);
}
