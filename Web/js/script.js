$(function(){
	
	var countdownDiv = $('#countdown');
	var ReqCountDiv = $('#ReqCount');
		
	$('#countdown').countdown({
		callback	: function(message){
		
			message = '<h2>' + message + '</h2>';
			countdownDiv.html(message);
		}
	});
	
	$('#ReqCount').ReqCount({
		callback	: function(message){
		
			message = '<h2>' + message + '</h2>';
			ReqCountDiv.html(message);
		}
	});
	
});
