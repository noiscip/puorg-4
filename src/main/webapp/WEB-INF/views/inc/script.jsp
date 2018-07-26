<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<link href="<%=request.getContextPath()%>/images/eye.png" rel="icon" type="image/png">
	<meta charset="utf-8">
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
	<title>PICSION</title>
   
    <!-- Fonts and icons     -->
   <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700%7CRoboto+Slab:400,700%7CMaterial+Icons" />
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
   <!-- CSS Files -->
   <link href="<%=request.getContextPath()%>/assets/css/material-kit.min.css?v=3" rel="stylesheet" />
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.css">
   <link href="<%=request.getContextPath()%>/assets/css/base40.min.css?v=2" rel="stylesheet" />
   <link href="<%=request.getContextPath()%>/assets/demo/vertical-nav.css?v=4" rel="stylesheet" />  
   <link href="<%=request.getContextPath()%>/assets/css/fluid-gallery.css" rel="stylesheet" />
   <link href="<%=request.getContextPath()%>/assets/css/tabs-underlined.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assets/css/payment.css" rel="stylesheet">
   <link href="<%=request.getContextPath()%>/jqeury-ui/jquery-ui.css" rel="stylesheet" />
   <link href="<%=request.getContextPath()%>/jqeury-ui/jquery-ui.theme.css" rel="stylesheet" />
   <link href="<%=request.getContextPath()%>/DataTables/DataTables-1.10.18/css/dataTables.bootstrap.css?k=49" rel="stylesheet" />
   
   <!-- Js -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/iro.min.js"></script>
    <!-- Core JS Files   -->
    <script src="<%=request.getContextPath()%>/assets/js/core/jquery.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/assets/js/core/popper.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/assets/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- Plugin for Date Time Picker and Full Calendar Plugin  -->
    <script src="<%=request.getContextPath()%>/assets/js/plugins/moment.min.js"></script>
    <!-- Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
    <script src="<%=request.getContextPath()%>/assets/js/plugins/bootstrap-datetimepicker.js" type="text/javascript"></script>
    <!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
    <script src="<%=request.getContextPath()%>/assets/js/material-kit.js?v=2.0.1" type="text/javascript"></script>
    <!-- Plugin for Select, full documentation here: https://silviomoreto.github.io/bootstrap-select -->
   <script src="<%=request.getContextPath()%>/assets/js/plugins/bootstrap-selectpicker.js"></script>
   <!-- Plugin for Tags, full documentation here: https://xoxco.com/projects/code/tagsinput/  -->
   <script src="<%=request.getContextPath()%>/assets/js/plugins/bootstrap-tagsinput.js"></script>
      <!-- Plugin for Small Gallery in Product Page -->
   <script src="<%=request.getContextPath()%>/assets/js/plugins/jquery.flexisel.js"></script>
   <script src="<%=request.getContextPath()%>/assets/js/plugins/jasny-bootstrap.min.js"></script>
   <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
   <script src="<%=request.getContextPath()%>/assets/js/plugins/nouislider.min.js" type="text/javascript"></script>
   
 

    <!-- ckEditor -->
    <script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js" type="text/javascript" ></script>
     <!-- 네이버 로그인 -->
    <script src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" type="text/javascript" charset="utf-8"></script>
    <!-- dataTable -->
     
     <script src="<%=request.getContextPath()%>/DataTables/datatables.js" type="text/javascript" charset="utf8"></script>
     
     <!-- 차트 -->
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/wordcloud.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
      <!-- 아림이 수정중 -->
   <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css"> -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jcanvas/21.0.1/jcanvas.js"></script>
    
    <!-- iamport 결제 -->
    <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    
