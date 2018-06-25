package kr.or.picsion.notice.dao;

import java.util.List;
import java.util.Map;

import kr.or.picsion.notice.dto.Notice;

public interface NoticeDao {

	public int insertNotice(Map<String, Object> map);  //알림등록
	public int readCheckCount(int userNo);   //읽어야 할 알림 갯수 체크
	public List<Notice> noticeList(int userNo);   //받는 유저가 읽어야 할 알림 목록
	public int readCheck(Notice notice);
}
