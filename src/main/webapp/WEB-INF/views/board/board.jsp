<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script type="text/javascript">
$(document).ready( function () {
    $('#datatable').DataTable( {
        "order": [[ 0, "desc" ]],
    	"bInfo": false,    	
    	"bLengthChange": false
    } );
    
} );


</script>
<style>
	.board-top-pad{
		margin-top: -11em;
	}
</style>

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="main">
	<div class="profile-content board-top-pad">
		<div class="container" id="boardcontainer">
			<div class="row">
				<div class="col-md-12 ml-auto mr-auto">
				<div class="col-md-10">
				<h5>요청 게시판</h5>
				<div class="blockquote undefined">
                 <small>크리에이터와 1:1 작업을 할 수 있는 공간입니다.
				픽션에 없는 사진들을 요청해보세요.
				크리에이터는 작업신청에 도전해보세요.
				사용자들이 원하는 사진을 참고 할 수 있습니다.
				</small><small>크리에이터는 작업신청을 하기 전에 반드시! <a href="" data-toggle="modal" data-target="#termsofUse"class="text-danger">이용 약관</a>을 확인 해주세요!.				
                 </small>
                 </div>
                </div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 ml-auto mr-auto">

					<table class="table table-hover" id="datatable">
						<thead>
							<tr>
								<th class="text-center">#</th>
								<th class="text-center">제목</th>
								<th class="text-center">작성자</th>
								<th class="text-center">작성일</th>
								<th class="text-center">작업상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="n" varStatus="status">
								<tr>
								
									<td class="text-center">${n.brdNo}</td>
									<td class="text-center"><c:choose>
											<c:when test="${n.operStateNo ne 1}">
												<c:choose>
													<c:when
														test="${operlist[status.index].requesterNo eq sessionScope.user.userNo || operlist[status.index].operatorNo eq sessionScope.user.userNo}">
														<a
															href="<%=request.getContextPath()%>/board/boardInfo.ps?brdNo=${n.brdNo}">${n.brdTitle}</a>
													</c:when>
													<c:otherwise>
													<a data-toggle="popover" data-placement="right" data-trigger="hover" data-content="작업 관계자만 읽기가 가능합니다.">${n.brdTitle}</a>													
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<a
													href="<%=request.getContextPath()%>/board/boardInfo.ps?brdNo=${n.brdNo}">${n.brdTitle}</a>
											</c:otherwise>
										</c:choose></td>
									<td class="text-center">${n.userName}</td>
									<td class="text-center"><fmt:formatDate
												pattern="yyyy-MM-dd, HH:mm" value="${n.brdReg}" />
									</td>
									<td class="text-center">${n.operState}</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							
						</tfoot>
					</table>
					
								<div class="text-right" colspan="5" style="border-top-width: 0px">
									<a href="<%=request.getContextPath()%>/board/writeboard.ps"
									style="cursor: pointer;">
										<button class="btn btn-primary btn-round">
											<i class="material-icons">edit</i> 글 쓰기
										</button>
								</a>
								</div>
								
							
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 이용약관 -->
<div class="modal fade" id="termsofUse" tabindex="-1" role="dialog" aria-labelledby="completePicLabel"aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completePicLabel">이용 약관</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <i class="material-icons">clear</i>
                </button>
            </div>
            <div class="modal-body">
	            <div class="row">
		            <div class="col-md-12">
		           
          <!--이용약관 테이블 시작-->
			          <table style="width:100%">
			            <tr>
			              <td>
			                <div>
			                 <font color="#f67001" size=4>01</font> <font size=3>크리에이터 업로드 이용 약관</font>
			                </div>
			             </td>
			           </tr>
			           <tr>
			             <td>
			               <textarea style="width:100%; text-align:left; height:100;border:1;overflow:visible;text-overflow:ellipsis;"  readonly="readonly" rows=15>	
1. 크리에이터 회원이 업로드 가능한 콘텐츠는 원칙적으로 본인이 촬영・제작한 콘텐츠 및 저작권이 본인에게 귀속되어 있는 콘텐츠로 한정됩니다. 본인이 촬영・제작하지 않은 콘텐츠 및 저작권이 본인에게 귀속되어 있지 않은 콘텐츠를 저작자나 저작권자의 허락 없이 업로드하는 행위는, 저작권 침해에 해당하는 위법 행위입니다.
								
2. 크리에이터회원은 해당 크리에이터회원 본인이 본 서비스에 업로드한 관련 정보 등이 정확하다는 것을 보증합니다.
								
3. 크리에이터회원은 본 서비스에 업로드한 콘텐츠 및 피사체에 초상권, 퍼블리시티권, 상표권, 저작인접권을 포함한 저작권, 그 외에 제3자의 권리가 존재하는 경우에 존재하는 권리 일체에 대하여 해당 권리의 권리자 또는 그 정당한 대리인으로부터 허가를 취득하였으며, 제3자의 권리를 침해하는 것이 아니라는 것을 보증합니다. 또한 인물 사진을 업로드 할 경우, 크리에이터회원은 해당 인물 사진의 피사체 전원에 대한 초상권 사용동의서를 당사에 제출해야 하며, 당사는 크리에이터회원이 제출된 해당 초상권 사용동의서에 대하여 당사 지정의 초상권 사용동의서 또는 실질적으로 같은 내용의 유효한 초상권 사용 동의서여야 합니다.
								
4. 크리에이터회원은 본 서비스에 업로드 한 콘텐츠가 합법적으로 제작된 것임을 보증합니다.
※크리에이터 회원은 콘텐츠를 업로드 하는 시점부터 그 콘텐츠의 품질이나 사용 동의, 권리 침해 등에 관해서 어떠한 문제도 없으며 또한 태그나 타이틀 등에 대해서도 올바른 정보가 입력되었다고 보증된 것으로 합니다. 콘텐츠의 내용이나 입력된 정보의 과실에 의해 클레임이나 소송 등의 문제가 발생한 경우, 크리에이터 자신의 책임입니다.
								
5. 제 1 항 또는 제 3 항의 필요한 허가를 취득하지 못한 콘텐츠, 관련 정보 등이 잘못된 것 또는 부적절한 것 (타인의 성명 · 명칭을 사칭하는 것을 포함함.) 또는 다음 중 어느 하나라도 해당하는 콘텐츠는 부적절한 콘텐츠로 간주됩니다. 이는 당사의 자동 사진 검사를 통해서 일부 확인할 수 있습니다.
【부적절한 콘텐츠의 예】
-음란, 폭력, 기타 공서양속에 위반하는 내용을 포함하는 것
-상표, 브랜드 로고, 캐릭터, 광고 (포스터 등), 상품 (CD, DVD, 서적 등)이 주요 피사체로 표현되어 있는 것 또는 식별할 수 있는 것
-저작권 보호기간 내의 미술작품 (그림, 조각 등 포함함.)을 포함하는 것
-개인 식별이 가능한 인물이 있으며, 적절한 초상권 사용허가가 취득되지 않은 것
-촬영, 또는 RF 콘텐츠 (이용용도를 특정하지 않고, 다양한 용도로 사용할 수있는 콘텐츠를 의미함)로 판매함에 있어서 허가가 필요한 제3자가 관리하는 시설, 동물, 물품 등에 대해 해당 관리자 또는 권리 소유자의 적절한 허가를 취득하지 않은 것, 또한 그러한 허가를 취득하지 않고 촬영이 이루어진 것
-콘텐츠로서 부적절한 문자 게재나 가공이 된 것
-기타 당사가 본 서비스 내에서 판매하기에 적합하지 않다고 판단한 것

6. 콘텐츠 또는 관련 정보 등에 관하여 제3자로부터 권리침해의 신청, 이의, 불만, 그에 따른 손해배상 청구가 발생한 경우, 크리에이터회원은 그 책임과 부담으로 이를 처리하며 당사에 일체의 피해와 손해를 주지 않을 것을 보증합니다.

7. 당사가 크리에이터회원의 콘텐츠로 인하여 권리를 침해받은 제3자에게 권리침해의 신청, 이의, 불만, 민사상 손해 배상을 지급할 경우, 크리에이터회원은 당사에게 합리적인 변호사비용을 포함한 일체의 비용을 보상합니다.

8. 콘텐츠 또는 관련 정보 등에 대하여 권리침해를 받은 제3자로부터 권리침해의 신청, 이의, 불만, 손해 배상 청구가 당사에 대해 이루어진 경우, 당사는 해당 콘텐츠를 업로드한 크리에이터회원의 연락처 그 외에 당사가 해당 콘텐츠의 사용권을 구매한 자의 정보를 권리침해를 받은 제3자에게 공개 할 수 있습니다.
			                </textarea>
			              </td>
			            </tr>
			            <!-- <tr>
			              <td>
			                <input type="checkbox">이용약관에 동의합니다.
			              </td>
			            </tr>     -->       
			          </table>
		            </div>
	            </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success btn-link btn-lg" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>
