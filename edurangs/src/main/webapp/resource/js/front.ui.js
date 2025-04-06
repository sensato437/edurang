var documentHeight;
var windowHeight = $(window).height();

(function($w, $d) {
	var FrontSetPage = {
		size:{
			now:null,
			pad:1100,
			phone:640
		},
		initialize:function() {
			if(/MSIE 7.*Trident/.test(navigator.userAgent)) { $d.documentElement.className += ' ie-compatible'; }
		},
		update:function() {
			$.extend(FrontSetPage.size, {
				now:$('#wrap').width()
			});

			$('body')
				.attr('data-size', FrontSetPage.size.now)
				.removeClass(function(index, str) {
					var classList = str.split(' ');
					for(var i=0; i<classList.length; i++) {
						if(classList[i].match(/page\-[a-zA-Z]+/)) {
							return classList[i];
						}
					}
				})
				.addClass(function() {
					return (FrontSetPage.size.now > FrontSetPage.size.pad) ? 'page-pc' : (FrontSetPage.size.now > FrontSetPage.size.phone) ? 'page-pad' : 'page-phone'
				});
		}
	};

	$($w).on({
		'load':function() {
			FrontSetPage.update();
		},
		'resize.front-page':function() {
			var $this = $(this);
			FrontSetPage.update();
			$this.off('resize.front-page');
			setTimeout(function() {
				$this.on('resize.front-page', FrontSetPage.update);
			}, 200);

			$this.triggerHandler('resize.front-page');
		}
	});
})(window, document);