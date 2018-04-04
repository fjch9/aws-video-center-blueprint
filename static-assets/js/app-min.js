jQuery.noConflict();jQuery(document).foundation();jQuery(document).ready(function(jQuery){"use strict";jQuery("#layerslider").layerSlider({responsive:!1,responsiveUnder:1280,layersContainer:1280,skin:'noskin',hoverPrevNext:!1,skinsPath:'../layerslider/skins/'});jQuery(".loginReg").on("click",function(e){e.preventDefault();jQuery(this).next().slideToggle();jQuery(this).toggleClass("active")});jQuery(".search").on("click",function(){if(jQuery(this).children().hasClass("fa-search")){jQuery(this).children().removeClass("fa-search");jQuery(this).children().addClass("fa-times")}else{jQuery(this).children().removeClass("fa-times");jQuery(this).children().addClass("fa-search")}
jQuery(this).toggleClass("search-active");jQuery("#search-bar").slideToggle()});jQuery(document).on("click",".grid-system > a",function(event){event.preventDefault();var selector=jQuery(this).parent().parent().next().find('div.item');jQuery(selector).removeClass(jQuery(this).parent().find('a.current').data('class')).addClass(jQuery(this).data('class')).matchHeight();jQuery(this).parent().children('a').removeClass("current");jQuery(this).addClass("current");formatVideoSections()});var backtotop='#back-to-top';if(jQuery(backtotop).length){var scrollTrigger=100,backToTop=function(){var scrollTop=jQuery(window).scrollTop();if(scrollTop>scrollTrigger){jQuery(backtotop).addClass('show')}else{jQuery(backtotop).removeClass('show')}};backToTop();jQuery(window).on('scroll',function(){backToTop()});jQuery('#back-to-top').on('click',function(e){e.preventDefault();jQuery('html,body').animate({scrollTop:0},700)})}
jQuery('#newsBar').inewsticker({speed:2500,effect:'fade',dir:'ltr',font_size:13,color:'#fff',font_family:'arial',delay_after:1000});jQuery('.showmore_one').showMore({speedDown:300,speedUp:300,height:'165px',showText:'Show more',hideText:'Show less'});jQuery(".reply").each(function(){if(jQuery(this).parent().next().length>0){jQuery(this).html('Hide replies <i class="fa fa-angle-up"></i>')}});jQuery(".reply").on('click',function(){if(jQuery(this).parent().next().length>0){jQuery(this).parent().nextAll().slideToggle();if(jQuery(this).hasClass('hide-reply')){jQuery(this).removeClass('hide-reply');jQuery(this).html('show replies <i class="fa fa-angle-down"></i>')}else{jQuery(this).addClass('hide-reply');jQuery(this).html('Hide replies <i class="fa fa-angle-up"></i>')}}});jQuery("div.social-login").mouseenter(function(){jQuery("i.arrow-left").addClass("active")}).mouseleave(function(){jQuery("i.arrow-left").removeClass("active")});jQuery("div.register-form").mouseenter(function(){jQuery("i.arrow-right").addClass("active")}).mouseleave(function(){jQuery("i.arrow-right").removeClass("active")});var thumb=jQuery('.thumb-slider .thumbs').find('.ver-thumbnail');jQuery(thumb).on('click',function(){var id=jQuery(this).attr('id');jQuery('.image').eq(0).show();jQuery('.image').hide();jQuery('.'+id).fadeIn()});var $par=jQuery('.thumb-slider .thumbs .thumbnails').scrollTop(0);jQuery('.thumb-slider .thumbs a').click(function(e){e.preventDefault();var n=jQuery(this).hasClass("down")?"+=200":"-=200";$par.animate({scrollTop:n})});jQuery('[data-tab]').on('click',function(e){jQuery(this).addClass('active').siblings('[data-tab]').removeClass('active');jQuery(this).siblings('[data-content='+jQuery(this).data('tab')+']').addClass('active').siblings('[data-content]').removeClass('active');e.preventDefault()})});function getDate(videoDate){var formatedStartDate=moment(videoDate);var currentTimeZone=new Date(formatedStartDate).toString().match(/\(([A-Za-z\s].*)\)/)[1];return formatedStartDate.format('lll')+" "+currentTimeZone}
var renderVideoItem=function(parent,video,videoBaseUrl){var url=videoBaseUrl+video.id;var className=parent.parent().parent().parent().find('.grid-system > .current').data('class')
return `  
	<div id="video-${video.id}" data-video-id="${video.id}" class="item large-4 medium-6 columns ${className}">
			<div class="post thumb-border">
				<div class="post-thumb">
					<img src="${video.thumbnail}">
					<div class="tag-live hide">
						<figcaption>
							<p class="live-text">Live</p>
						</figcaption>
					</div>
					<a href="${url}" id="hover-circle" class="hover-posts">
						<span><i id="icon-circle" class="fa fa-play-circle"></i></span>
					</a>
				</div>
			<div class="post-des">
				<h6 class="video-title"><a href="${url}">${video.title_s}</a></h6>
				<div class="post-stats clearfix">
				<p>
					<span>
                    	<i class="fa fa-clock-o icon-start-time"></i> Start time: <span class="start-time">${getDate(video.startDate_dt)}</span>
                    </span>
                    <br>
					<span>
                    	<i class="fa fa-clock-o icon-end-time"></i> End time: <span class="end-time">${getDate(video.endDate_dt)}</span>
                     </span> 
				</p>
				<div class="clearfix content-popular-icons">
					<p class="pull-left">
						<i class="fa fa-eye"></i>
						<span class="view-count">${video.viewCount}</span>
					</p>
					<p class="pull-left">
						<i class="fa fa-thumbs-o-up"></i>
						<span class="like-count">${video.likeCount}</span>
					</p>
					<p class="pull-left">
						<i class="fa fa-thumbs-o-down"></i>
						<span class="dislike-count">${video.dislikeCount}</span>
					</p>
				</div>
			
				
			</div>
			<div class="post-summary">
				<p>${video.summary_s}</p>
			</div>
		</div>
		</div>
	</div>`}
var loadVideos=function(refreshUrl,retrieveLimit,idPrefix,videoBaseUrl){let url_video=refreshUrl+"?limit="+retrieveLimit;video_selector='#'+idPrefix+'-videos';jQuery.ajax({url:url_video,dataType:"json",success:function(data){if(data.length===0){jQuery('#'+idPrefix+'-message-no-video').removeClass('hide');jQuery('#'+idPrefix+'-grid-system').addClass('hide')}else{jQuery.each(data,function(index,element){var domElement=document.getElementById("video-"+element.id);var liveText=jQuery('#video-'+element.id+' > div > div > .tag-live')
if(domElement){domElement.querySelector('.video-title').querySelector('a').innerHTML=element.title_s;domElement.querySelector('.post-summary').querySelector('p').innerHTML=element.summary_s;domElement.querySelector('.like-count').innerHTML=element.likeCount;domElement.querySelector('.dislike-count').innerHTML=element.dislikeCount;domElement.querySelector('.view-count').innerHTML=element.viewCount;if(element.type==='stream'){domElement.querySelector('.start-time').innerHTML=getDate(element.startDate_dt);domElement.querySelector('.end-time').innerHTML=getDate(element.endDate_dt)}
liveText.addClass('hide')}else{jQuery(video_selector).append(renderVideoItem(jQuery(video_selector),element,videoBaseUrl))}
if(element.liveNow){liveText.removeClass('hide')}});dataIds=jQuery.map(data,function(e){return e.id});jQuery('div[data-video-id]').each(function(i,element){videoId=jQuery(this).data('video-id');if(dataIds.indexOf(videoId)<0){document.getElementById(element.id).remove()}})
formatVideoSections()}}})};function renderDates(){jQuery('[data-format-date]').each(function(index,el){var $el=jQuery(el);var date=$el.attr('data-format-date');$el.text(getDate(date))})}
function formatVideoSections(){['most-viewed-videos-section','newest-videos-section','streams-section','results'].forEach(function(id){className='medium-offset-3';items=jQuery('#'+id).find('div.item');items.removeClass(className);if(items.length%2==1){var item=items.last();if(item.hasClass('grid-medium')&&!item.hasClass(className)){item.addClass(className)}}})}
