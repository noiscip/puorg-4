<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	 $(function(){
		$('.datetimepicker').datetimepicker({
		    icons: {
		        time: "fa fa-clock-o",
		        date: "fa fa-calendar",
		        up: "fa fa-chevron-up",
		        down: "fa fa-chevron-down",
		        previous: 'fa fa-chevron-left',
		        next: 'fa fa-chevron-right',
		        today: 'fa fa-screenshot',
		        clear: 'fa fa-trash',
		        close: 'fa fa-remove'
		    }
		});
	 });
</script>

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">

			<form action="<%=request.getContextPath()%>/board/writeboard.ps"
				method="post">
				<div class="row">
					
					<div class="col-md-6 ml-auto mr-auto">
						<div class="form-group">
	                      <label class="label-control">제목</label>
	                      <div class="input-group">
	                        <input type="text" class="form-control" name="brdTitle" autocomplete="off">
	                      </div>
	                    </div>
	                </div>
	                <div class="col-md-6 ml-auto mr-auto">
						<div class="form-group">
	                      <label class="label-control">희망 완료 날짜</label> <input type="text"
								class="	form-control datetimepicker" name="brdExpectEndDate"/>
	                    </div>
	                </div>
	                <div class="col-md-6 ml-auto mr-auto">
						<div class="form-group">
	                      <label for="exampleFormControlSelect1">저작권 양도 여부</label>
						    <select class="form-control" id="exampleFormControlSelect1" name="copyright">
						      <option>T</option>
						      <option>F</option>
						    </select>

	                    </div>
	                </div>
					<div class="col-md-6 ml-auto mr-auto">
						<div class="form-group">
	                      <label class="label-control">희망 구매 가격</label>
	                      <div class="input-group">
	                        <input type="text" class="form-control" name="brdExpectPrice" autocomplete="off">
	                      </div>
	                    </div>
	                </div>
					
					
					
					<div class="col-md-12 ml-auto mr-auto">
						<textarea style="height: 1000px" rows="10" cols="60"
							name="brdContent" id="brdContent"></textarea>

						<script type="text/javascript">
						CKEDITOR.replace('brdContent');
						</script>
					</div>
					<div class="col-md-12 ml-auto mr-auto" style="text-align:right;">
					<button type="submit" class="btn btn-primary btn-round">
							<i class="material-icons">edit</i> 글 쓰기
					</button>
					</div>
					
				</div>
				
					
				
			</form>

		</div>
	</div>
</div>
