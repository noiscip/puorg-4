<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
<div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
   	<div class="profile-content">
      	<div class="container">
			<div class="row">
          		<div class="col-md-12 ml-auto mr-auto">
          			<form action="/board/writeboard.ps" method="post">
          			
					<textarea style="height: 1000px" rows="10" cols="60" name="brdContent" id="brdContent"></textarea>
					
					<script type="text/javascript">
						CKEDITOR.replace('brdContent');
					</script>
					
					<div class="form-group">
					    <label class="label-control">희망 완료 날짜</label>
					    <input type="text" class="form-control datetimepicker" name = "brdExpectEndDate"/>
					</div>
					<div class="form-group">
					 <label class="label-control">제목</label><input type="text" name="brdTitle">
					 <label class="label-control">true</label><input type="text" name="copyright">
					<input type="submit" value="글 작성">
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
