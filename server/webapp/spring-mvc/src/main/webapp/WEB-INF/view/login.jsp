<%@ page language="java" contentType="text/html; charset=gb2312"    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%=request.getContextPath() %>/">
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet"  type="text/css" charset="utf-8" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.1.0/css/font-awesome.min.css">
		<link rel='stylesheet'  type="text/css" charset="utf-8" href='css/jquery-ui.css'>
		<link rel='stylesheet'  type="text/css" charset="utf-8" href='css/bootstrap.min.css'>
		<link rel="stylesheet"  type="text/css" charset="utf-8" href="css/style.css" media="screen"/>
		<script src="js/modernizr.js"></script>	
	</head>

	<body class="login-page">
		<div class="login-form">
		    <div class="login-content">
		        <form method="post" role="form" id="form_login">
		            <div class="form-group">
		                <div class="input-group">
		                    <div class="input-group-addon"> <i class="fa fa-user"></i> </div>
		                    <input type="text" class="form-control" name="username" id="username" placeholder="Username" autocomplete="off" />
		                </div>
		            </div>
		            <div class="form-group">
		                <div class="input-group">
		                    <div class="input-group-addon"> <i class="fa fa-key"></i> </div>
		                    <input type="password" class="form-control" name="password" id="password" placeholder="Password" autocomplete="off" />
		                </div>
		            </div>
		            <div class="form-group">
		                <button type="submit" class="btn btn-primary btn-block btn-login"> <i class="fa fa-sign-in"></i> Login In </button>
		            </div>
		        </form>
		    </div>
		</div>
	</body>
</html>