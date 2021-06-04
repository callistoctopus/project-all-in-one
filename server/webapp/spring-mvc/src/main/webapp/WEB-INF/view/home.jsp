<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=request.getContextPath() %>/">  
	<title>AQI</title>
	<style media="screen" type="text/css">
		img { display: none; }
		body { overflow: hidden; }
		#canvas { position: absolute; top: 0px; left: 0px; }
	</style>
	<script src="js/rainyday.js" type="text/javascript"></script>
	<script type="text/javascript">
			function demo() {
			var engine = new RainyDay('canvas','demo1', window.innerWidth, window.innerHeight);
			engine.gravity = engine.GRAVITY_NON_LINEAR;
			engine.trail = engine.TRAIL_DROPS;

			engine.rain([
				engine.preset(0, 2, 500)
			]);

			engine.rain([
				engine.preset(3, 3, 0.88),
				engine.preset(5, 5, 0.9),
				engine.preset(6, 2, 1),
			], 100);
			}
	</script>
</head>

<body onLoad="demo();" >
		<img id="demo1" src="img/home.jpg" />
		<div id="cholder">
			<canvas id="canvas"></canvas>
		</div>
	</body>
</html>