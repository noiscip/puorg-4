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
	
}
