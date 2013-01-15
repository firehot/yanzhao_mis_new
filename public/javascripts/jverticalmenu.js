/*
 * jverticalmenu.js
 * author: kazuhiro.yamada
 */
var JVerticalMenu = function() {
	var self = this;
	//Specify full URL to down and right arrow images (23 is padding-right added to top level LIs with drop downs):
	this.arrowimages = {
		down: ['downarrowclass', '/images/jverticalmenu/down.gif', 23],
		right: ['rightarrowclass', '/images/jverticalmenu/right.gif']
	};
	this.transition = {
		topovertime: 100,
		overtime: 200,
		outtime: 300,
	}; //duration of slide in/ out animation, in milliseconds
	this.shadow = {
		enable: true,
		offsetx: 5,
		offsety: 5
	}; //enable shadow?
	this.showhidedelay = {
		showdelay: 100,
		hidedelay: 200
	}; //set delay in milliseconds before sub menus appear and disappear, respectimely
	this.detectwebkit = navigator.userAgent.toLowerCase().indexOf("applewebkit") != - 1; //detect WebKit browsers (Safari, Chrome etc)
	this.detectie6 = document.all && ! window.XMLHttpRequest;
	this.css3support = window.msPerformance || (!document.all && document.querySelector); //detect browsers that support CSS3 box shadows (ie9+ or FF3.5+, Safari3+, Chrome etc)
	this.ismobile = navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i) != null; //boolean check for popular mobile browsers
	this.init = function() {
		jQuery(document).ready(function($) { //ajax menu?
			self.buildMenu($);
		})
	}

	this.buildMenu = function($) {
		var $jvmenu = $("#jverticalmenu");
		var $mainmenu = $("#jverticalmenu > ul") //reference main menu UL
		var $headers = $mainmenu.find("ul").parent()
		$mainmenu.hover(
		function(e) {
			console.log("li.hover" + self.transition.topovertime);
			$("#jverticalmenu").animate({
				width: '141'
			},
			self.transition.topovertime, function() {
				$(".rightarrowclass").show();
			});
		},
		function(e) {
			$(".rightarrowclass").hide();
			$("#jverticalmenu").animate({
				width: '51'
			},
			self.transition.topovertime);
		})
		$headers.hover(
		function(e) {
			$(this).children('a:eq(0)').addClass('selected')
		},
		function(e) {
			$(this).children('a:eq(0)').removeClass('selected')
		})

		$headers.each(function(i) { //loop through each LI header
			var $curobj = $(this).css({
				zIndex: 100 - i
			}) //reference current LI header
			var $subul = $(this).find('ul:eq(0)').css({
				display: 'block'
			})
			$subul.data('timers', {})
			this._dimensions = {
				w: this.offsetWidth,
				h: this.offsetHeight,
				subulw: $subul.outerWidth(),
				subulh: $subul.outerHeight()
			}
			this.istopheader = $curobj.parents("ul").length == 1 ? true: false //is top level header?
			$subul.css({
				top: 0
			})
			$curobj.children("a:eq(0)").append( //add arrow images
			'  <img src="' + self.arrowimages.right[1] + '" class="' + self.arrowimages.right[0] + '" style="border:0; display:none;" />')
			if (self.shadow.enable && ! self.css3support) { //if shadows enabled and browser doesn't support CSS3 box shadows
				this._shadowoffset = {
					x: (this.istopheader ? $subul.offset().left + self.shadow.offsetx: this._dimensions.w),
					y: (this.istopheader ? $subul.offset().top + self.shadow.offsety: $curobj.position().top)
				} //store this shadow's offsets
				if (this.istopheader) $parentshadow = $(document.body)
				else {
					var $parentLi = $curobj.parents("li:eq(0)")
					$parentshadow = $parentLi.get(0).$shadow
				}
				this.$shadow = $('<div class="ddshadow' + (this.istopheader ? ' toplevelshadow': '') + '"></div>').prependTo($parentshadow).css({
					left: this._shadowoffset.x + 'px',
					top: this._shadowoffset.y + 'px'
				}) //insert shadow DIV and set it to parent node for the next shadow div
			}
			$curobj.hover(
			function(e) {
				var $targetul = $subul //reference UL to reveal
				var header = $curobj.get(0) //reference header LI as DOM object
				clearTimeout($targetul.data('timers').hidetimer)
				$targetul.data('timers').showtimer = setTimeout(function() {
					header._offsets = {
						left: $curobj.offset().left,
						top: $curobj.offset().top
					}
					var menuleft = $(header).width()
					if ($targetul.queue().length <= 1) { //if 1 or less queued animations
						$targetul.css({
							left: menuleft,
							//width: header._dimensions.subulw
                            width : "150px"
						}).animate({
							height: 'show',
							opacity: 'show'
						},
						self.transition.overtime)
						if (self.shadow.enable && ! self.css3support) {
							var shadowleft = header.istopheader ? $targetul.offset().left + self.shadow.offsetx: menuleft
							var shadowtop = header.istopheader ? $targetul.offset().top + self.shadow.offsety: header._shadowoffset.y
							if (!header.istopheader && self.detectwebkit) { //in WebKit browsers, restore shadow's opacity to full
								header.$shadow.css({
									opacity: 1
								})
							}
							header.$shadow.css({
								overflow: '',
								width: header._dimensions.subulw + 'px',
								left: shadowleft + 'px',
								top: shadowtop + 'px'
							}).animate({
								height: header._dimensions.subulh + 'px'
							},
							self.transition.overtime)
						}
					}
				},
				self.showhidedelay.showdelay)
			},
			function(e) {
				var $targetul = $subul;
				var header = $curobj.get(0);
				clearTimeout($targetul.data('timers').showtimer);
				$targetul.data('timers').hidetimer = setTimeout(function() {
					$targetul.animate({
						height: 'hide',
						opacity: 'hide'
					},
					self.transition.outtime)
					if (self.shadow.enable && ! self.css3support) {
						if (self.detectwebkit) { //in WebKit browsers, set first child shadow's opacity to 0, as "overflow:hidden" doesn't work in them
							header.$shadow.children('div:eq(0)').css({
								opacity: 0
							})
						}
						header.$shadow.css({
							overflow: 'hidden'
						}).animate({
							height: 0
						},
						self.transition.outtime)
					}
				},
				self.showhidedelay.hidedelay)
			}) //end hover
		}) //end $headers.each()
		if (self.shadow.enable && self.css3support) { //if shadows enabled and browser supports CSS3 shadows
			var $toplevelul = $('#jverticalmenu ul li ul');
			var css3shadow = parseInt(self.shadow.offsetx) + "px " + parseInt(self.shadow.offsety) + "px 5px #aaa"; //construct CSS3 box-shadow value
			var shadowprop = ["boxShadow", "MozBoxShadow", "WebkitBoxShadow", "MsBoxShadow"]; //possible vendor specific CSS3 shadow properties
			for (var i = 0; i < shadowprop.length; i++) {
				$toplevelul.css(shadowprop[i], css3shadow);
			}
		}
		$mainmenu.find("ul").css({
			display: 'none',
			visibility: 'visible'
		});
	}
}

