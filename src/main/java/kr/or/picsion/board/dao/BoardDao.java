package kr.or.picsion.board.dao;

import java.util.HashMap;
import java.util.List;

import kr.or.picsion.board.dto.Board;

public interface BoardDao {

	public List<Board> boardList(HashMap<String, Integer> map);
	public int insertBoard(Board board);
	public int deleteBoard(int boardNo);
	public int updateBoard(Board board);
	public Board selectBoard(int boardNo);
	public List<Board> writerBoard(int userNo);
	public int getBoardCount();
}
