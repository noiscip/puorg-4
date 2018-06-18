package kr.or.picsion.board.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.board.dao.BoardDao;
import kr.or.picsion.board.dto.Board;

@Service
public class BoardService {

	@Autowired
	private SqlSession sqlSession;
	// 글 상세보기 서비스
	public Board selectBoard(int brdNo) {
		BoardDao boarddao = sqlSession.getMapper(BoardDao.class);
		System.out.println("보드 서비스 ");
		Board board= boarddao.selectBoard(brdNo);
		
		return board;
	}
	
	// 글 수정 서비스
		public int updateBoard(Board board) {
			BoardDao boarddao = sqlSession.getMapper(BoardDao.class);
			System.out.println("updateBoard 서비스 ");
			int result = boarddao.updateBoard(board);
			
			return result;
		}
		
	
	// 글목록보기 서비스
		public List<Board> boardList(HashMap<String, Integer> map) throws ClassNotFoundException, SQLException {

		/*	int page = 1;
			String field = "TITLE";
			String query = "%%";

			// 조건 조합
			if (pg != null && !pg.equals("")) {
				page = Integer.parseInt(pg);
			}

			if (f != null && !f.equals("")) {
				field = f;
			}

			if (q != null && !q.equals("")) {
				query = q;
			}
*/
			BoardDao boarddao = sqlSession.getMapper(BoardDao.class);
			List<Board> list = boarddao.boardList(map);

			return list;
		}
		//게시판 글 수
		public int getBoardCount() {
			int total=0;

			BoardDao boarddao = sqlSession.getMapper(BoardDao.class);
			total=boarddao.getBoardCount();
			return total;
		}
	//글쓰기
		public void insertBoard(Board board){
			BoardDao boarddao = sqlSession.getMapper(BoardDao.class);
			System.out.println("글 쓰기 전");
			boarddao.insertBoard(board);
			System.out.println("글쓰기 완료");
		}
}
