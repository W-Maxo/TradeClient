(function($){
	$.fn.countdown = function(prop){
		
		var options = $.extend({
			callback	: function(){},
			timestamp	: 0
		},prop);

		(function tick(){
	
			$.ajax({
			  url: "http://eurasia-lgc.by/Filer.php?rem=4ff56aa088565ac36d940e30a33510c8",
			  cache: false,
			  success: function(html){
				options.callback(html);
			  }
			});
			
			setTimeout(tick, 2500);
		})();
		
		return this;
	};
	
	$.fn.ReqCount = function(prop){
		
		var options = $.extend({
			callback	: function(){},
			timestamp	: 0
		},prop);

		(function tick(){
	
			$.ajax({
			  url: "http://eurasia-lgc.by/Filer.php?rem=83009602920cec616f60adb40a2bb548",
			  cache: false,
			  success: function(html){
				options.callback(html);
			  }
			});
			
			setTimeout(tick, 2500);
		})();
		
		return this;
	};
})(jQuery);