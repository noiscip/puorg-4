package kr.or.picsion.blame.dao;

import java.util.List;

import kr.or.picsion.blame.dto.Blame;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.blame.dao 
 * @className BlameDao
 * @date 2018. 6. 4.
 */

public interface BlameDao {

	public int complainInsert(Blame blame); //신고 생성
	public List<Blame> blameList();
	public Blame selectBlame(int blameNo);
	public List<Blame> complainSearch(String date);
	
}
