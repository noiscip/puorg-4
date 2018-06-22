package kr.or.picsion.board.dao;

import java.util.HashMap;
import java.util.List;

import kr.or.picsion.board.dto.Board;

public interface BoardDao {

	public List<Board> boardList(HashMap<String, Integer> map);
	public int insertBoard(Board board);
	public int deleteBoard(int brdNo);
	public int updateBoard(Board board);
	public Board selectBoard(int brdNo);
	public List<Board> writerBoard(int userNo);
	public int getBoardCount();
	public List<Board> operationBoardList(int userNo);
	public List<Board> requestBoardList(int userNo);
}
