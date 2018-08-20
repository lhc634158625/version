var Chat = {};

Chat.socket = null;

Chat.connect = (function(host) {
	if ('WebSocket' in window) {
		Chat.socket = new WebSocket(host);
	} else if ('MozWebSocket' in window) {
		Chat.socket = new MozWebSocket(host);
	} else {
		Console.log('Error: WebSocket is not supported by this browser.');
		return;
	}

	Chat.socket.onopen = function() {
		Console.log('Info: WebSocket connection opened.');
		/*
		 * document.getElementById('chat').onkeydown = function(event) { if
		 * (event.keyCode == 13) { Chat.sendMessage(); } };
		 */
	};

	Chat.socket.onclose = function() {

		Console.log('Info: WebSocket closed.');
	};

	Chat.socket.onmessage = function(message) {
		var obj = jQuery.parseJSON(message.data);
		/*
		 * if (obj.command == -82) { ChangePosition(obj.carId, obj.longitude,
		 * obj.latitude, obj.speed, obj.direct); } if(obj.content.length>0){
		 * ShowTip(obj.carId,obj.content); }
		 */
		try {
			OnReceiveMsg(obj);
		} catch (e) {

		}

		// Console.log(message.data);
	};
});

Chat.initialize = function() {
	if (window.location.protocol == 'http:') {
		Chat.connect('ws://' + window.location.host + '/TrafficMap/SysComm');
	} else {
		Chat.connect('wss://' + window.location.host + '/TrafficMap/SysComm');
	}
};

Chat.sendMessage = (function() {
	var message = document.getElementById('chat').value;
	if (message != '') {
		Chat.socket.send(message);
		document.getElementById('chat').value = '';
	}
});

var Console = {};

function SendMessage(carId, message) {
	var content = "2^" + carId + "^" + message
	Chat.socket.send(content);
	alert("已成功发送请求");
}
function SendMonitor(carId, monitorTime, times) {
	var content = "3^" + carId + "^" + monitorTime + "^" + times
	Chat.socket.send(content);
	alert("已成功发送请求");
}
function SendParam(carId, paramId, paramVal) {
	var content = "4^" + carId + "^" + paramId + "^" + paramVal
	Chat.socket.send(content);
	alert("已成功发送请求");
}
function SendPhoto(carId, photoSize, cameraNo) {
	var content = "5^" + carId + "^" + photoSize + "^" + cameraNo
	Chat.socket.send(content);
	alert("已成功发送请求");
}
function QueryParam(carId) {
	var content = "6^" + carId
	Chat.socket.send(content);
	alert("已成功发送请求");
}
Console.log = (function(message) {
	/*
	 * var console = document.getElementById('console'); var p =
	 * document.createElement('p'); p.style.wordWrap = 'break-word'; p.innerHTML =
	 * message; console.appendChild(p); while (console.childNodes.length > 25) {
	 * console.removeChild(console.firstChild); } console.scrollTop =
	 * console.scrollHeight;
	 */
});
