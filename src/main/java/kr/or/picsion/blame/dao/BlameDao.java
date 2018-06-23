package kr.or.picsion.blame.dao;

import java.util.List;

import kr.or.picsion.blame.dto.Blame;

public interface BlameDao {

	public int complainInsert(Blame blame,String table,int no);
	public List<Blame> blameList();
	public Blame selectBlame(int blameNo);
	public List<Blame> complainSearch(String date);
	
}
