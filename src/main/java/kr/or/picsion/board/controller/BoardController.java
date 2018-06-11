package kr.or.picsion.board.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;

@Controller

public class BoardController {

	@Autowired
	private View jsonview;

	@Autowired
	private BoardService boardService;
	
		
	
	@RequestMapping("board.ps")
	public String boardList(Model model, String pg) {
		System.out.println("요청게시판 컨트롤러");
		List<Board> list=new ArrayList<Board>();
		int total=0;
		
		int page = 1;
		String Strpg = pg;
		if (Strpg != null) {
			page = Integer.parseInt(Strpg);
		}

		int rowSize = 5;
		int start = (page * rowSize) - (rowSize - 1);
		int end = page * rowSize;

		
		total = boardService.getBoardCount();

		System.out.println("start : " + start);
		System.out.println("end : " + end);
		System.out.println("total : " + total);

		// ... 목록
		int allPage = (int) Math.ceil(total / (double) rowSize); // 페이지수
		// int totalPage = total/rowSize + (total%rowSize==0?0:1);
		System.out.println("페이지수 : " + allPage);

		int block = 5; // 한페이지에 보여줄 범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9]
		// [10] >>
		int fromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
		// ((1-1)/10*10)
		int toPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
		if (toPage > allPage) { // 예) 20>17
			toPage = allPage;
		}

		// start , end
		HashMap<String, Integer> map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		
		
		try {
			list = boardService.boardList(map);

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("list", list);
		model.addAttribute("pg", page);
		model.addAttribute("allPage", allPage);
		model.addAttribute("block", block);
		model.addAttribute("fromPage", fromPage);
		model.addAttribute("toPage", toPage);	
		return "board.board";
	}
	
	
}
