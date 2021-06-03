<html>
  <head>
    <title>Home</title>
	<script src="https://cdn.bootcss.com/sockjs-client/1.1.4/sockjs.min.js"></script>
	<script src="https://cdn.bootcss.com/stomp.js/2.3.3/stomp.min.js"></script>
  </head>
  <body>
    <button id="stop">Stop</button>
  
    <script th:inline="javascript">
      var sock = new SockJS('http://localhost:8080/SkyEmperor/marcopolo');
      var stomp = Stomp.over(sock);

      stomp.connect('guest', 'guest', function(frame) {
    	alert("connected");
        stomp.subscribe("/topic/kongzi", handlePolo);
/*         sayMarco(); */
      });
      
      function handleOneTime(message) {
        console.log('Received: ', message);
      }

      function handlePolo(message) {
    	  alert("receive msg");
/*           setTimeout(function(){sayMarco()}, 2000); */
      }
      
      function handleErrors(message) {
        alert(JSON.parse(message.body).message);
      }

      function sayMarco() {
        stomp.send("/app/marco", {}, 
            JSON.stringify({ 'message': 'Marco!' }));
      }
      </script>
    
    <div id="output"></div>
  </body>
</html>

<!-- <!DOCTYPE html>
<html>
  <head>
    <title>Home</title>
    <script src="https://cdn.bootcss.com/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>
  </head>
  <body>
    <button id="stop">Stop</button>
  
    <script>
      var sock = new WebSocket('ws://localhost:8080/SkyEmperor/websocketdemo');

      sock.onopen = function() {
    	  console.log('Opening');
    	  //sayMarco();
      }
      
      sock.onmessage = function(e) {
    	  console.log('Received message: ', e.data);
    	  $('#output').append('Received "' + e.data + '"<br/>');
    	  setTimeout(function(){sayMarco()}, 2000);
      }
      
      sock.onclose = function() {
    	  console.log('Closing');
      }
      
      function sayMarco() {
    	  console.log('Sending Marco!');
    	  $('#output').append('Sending "Marco!"<br/>');
    	  sock.send("Marco!");
      }

      //$('#stop').click(function() {sock.close()});
      </script>
    
    <div id="output"></div>
  </body>
</html> -->