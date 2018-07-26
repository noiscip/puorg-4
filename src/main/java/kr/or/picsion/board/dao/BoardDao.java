package kr.or.picsion.board.dao;

import java.util.List;

import kr.or.picsion.board.dto.Board;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.board.dao 
 * @className BoardDao
 * @date 2018. 6. 4.
 */

public interface BoardDao {

	public List<Board> boardList();
	public int insertBoard(Board board);
	public int deleteBoard(int brdNo);
	public int updateBoard(Board board);
	public Board selectBoard(int brdNo);
	public List<Board> writerBoard(int userNo);
	public int getBoardCount();
	public List<Board> operationBoardList(int userNo);
	public List<Board> requestBoardList(int userNo);
}
