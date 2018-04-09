jQuery.noConflict();jQuery(document).foundation();jQuery(document).ready(function(jQuery){"use strict";jQuery("#layerslider").layerSlider({responsive:!1,responsiveUnder:1280,layersContainer:1280,skin:'noskin',hoverPrevNext:!1,skinsPath:'../layerslider/skins/'});jQuery(".loginReg").on("click",function(e){e.preventDefault();jQuery(this).next().slideToggle();jQuery(this).toggleClass("active")});jQuery(".search").on("click",function(){if(jQuery(this).children().hasClass("fa-search")){jQuery(this).children().removeClass("fa-search");jQuery(this).children().addClass("fa-times")}else{jQuery(this).children().removeClass("fa-times");jQuery(this).children().addClass("fa-search")}
jQuery(this).toggleClass("search-active");jQuery("#search-bar").slideToggle();if(jQuery(this).hasClass("search-active")){jQuery('#popup-search-input').focus()}});jQuery(document).on("click",".grid-system > a",function(event){event.preventDefault();jQuery('#'+jQuery(this).parent().data('id')).find('div.item').removeClass(jQuery(this).parent().find('a.current').data('class')).addClass(jQuery(this).data('class')).find('[data-mh]').matchHeight();jQuery(this).parent().children('a').removeClass("current");jQuery(this).addClass("current");formatVideoSections()});var backtotop='#back-to-top';if(jQuery(backtotop).length){var scrollTrigger=100,backToTop=function(){var scrollTop=jQuery(window).scrollTop();if(scrollTop>scrollTrigger){jQuery(backtotop).addClass('show')}else{jQuery(backtotop).removeClass('show')}};backToTop();jQuery(window).on('scroll',function(){backToTop()});jQuery('#back-to-top').on('click',function(e){e.preventDefault();jQuery('html,body').animate({scrollTop:0},700)})}
jQuery('#newsBar').inewsticker({speed:2500,effect:'fade',dir:'ltr',font_size:13,color:'#fff',font_family:'arial',delay_after:1000});jQuery('.showmore_one').showMore({speedDown:300,speedUp:300,height:'165px',showText:'Show more',hideText:'Show less'});jQuery(".reply").each(function(){if(jQuery(this).parent().next().length>0){jQuery(this).html('Hide replies <i class="fa fa-angle-up"></i>')}});jQuery(".reply").on('click',function(){if(jQuery(this).parent().next().length>0){jQuery(this).parent().nextAll().slideToggle();if(jQuery(this).hasClass('hide-reply')){jQuery(this).removeClass('hide-reply');jQuery(this).html('show replies <i class="fa fa-angle-down"></i>')}else{jQuery(this).addClass('hide-reply');jQuery(this).html('Hide replies <i class="fa fa-angle-up"></i>')}}});jQuery("div.social-login").mouseenter(function(){jQuery("i.arrow-left").addClass("active")}).mouseleave(function(){jQuery("i.arrow-left").removeClass("active")});jQuery("div.register-form").mouseenter(function(){jQuery("i.arrow-right").addClass("active")}).mouseleave(function(){jQuery("i.arrow-right").removeClass("active")});var thumb=jQuery('.thumb-slider .thumbs').find('.ver-thumbnail');jQuery(thumb).on('click',function(){var id=jQuery(this).attr('id');jQuery('.image').eq(0).show();jQuery('.image').hide();jQuery('.'+id).fadeIn()});var $par=jQuery('.thumb-slider .thumbs .thumbnails').scrollTop(0);jQuery('.thumb-slider .thumbs a').click(function(e){e.preventDefault();var n=jQuery(this).hasClass("down")?"+=200":"-=200";$par.animate({scrollTop:n})});jQuery('[data-tab]').on('click',function(e){jQuery(this).addClass('active').siblings('[data-tab]').removeClass('active');jQuery(this).siblings('[data-content='+jQuery(this).data('tab')+']').addClass('active').siblings('[data-content]').removeClass('active');e.preventDefault()})});function getDate(videoDate){var formatedStartDate=moment(videoDate);var currentTimeZone=new Date(formatedStartDate).toString().match(/\(([A-Za-z\s].*)\)/)[1];return formatedStartDate.format('lll')+" "+currentTimeZone}
var renderEventItemLiveText=function(isLive){return `<div class="tag-live ${isLive ? '' : 'hide'}">
            <figcaption>
                <p class="live-text">Live</p>
            </figcaption>
        </div>`}
var renderEventItemDates=function(startDate,endDate){return `<span>
            <i class="fa fa-clock-o icon-start-time"></i> Start time: <span class='start-time'>${getDate(startDate)}</span>
        </span>
        <br/>
        <span>
            <i class="fa fa-clock-o icon-end-time"></i> End time: <span class='end-time'>${getDate(endDate)}</span>
        </span> `}
var renderEventItem=function(video,videoBaseUrl,parentId,itemGridClass='grid-medium'){var url=videoBaseUrl+video.id,liveText=renderEventItemLiveText(video.liveNow),eventDates=renderEventItemDates(video.startDate_dt,video.endDate_dt);return `<div id="video-${video.id}" data-video-id="${video.id}" data-video-type='stream' class="item large-4 medium-6 columns ${itemGridClass}">
			<div class="post thumb-border" data-mh="${parentId}">
				<div class="post-thumb">
                    ${liveText}
					<img src="${video.thumbnail}">
					<a href="${url}" id="hover-circle" class="hover-posts">
						<span><i class="fa fa-play-circle icon-circle"></i></span>
					</a>
				</div>
			<div class="post-des">
				<h6 class="video-title"><a href="${url}">${video.title_s}</a></h6>
				<div class="post-stats clearfix">
				    <p>${eventDates}</p>
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
    				<p class='video-summary'>${video.summary_s}</p>
    			</div>
            </div>
		</div>
	</div>`}
var updateVideo=function(videoElement,videoData){videoElement.find('.video-title > a').text(videoData.title_s);videoElement.find('.video-summary').text(videoData.summary_s);videoElement.find('.like-count').text(videoData.likeCount);videoElement.find('.dislike-count').text(videoData.dislikeCount);videoElement.find('.view-count').text(videoData.viewCount);if(videoData.type==='stream'){videoElement.find('.start-time').text(getDate(videoData.startDate_dt));videoElement.find('.end-time').text(getDate(videoData.endDate_dt));var liveText=videoElement.find('.tag-live');if(videoData.liveNow){liveText.removeClass('hide')}else{liveText.addClass('hide')}}}
var removeCompletedStreams=function(videos){videoIds=jQuery.map(videos,function(e){return e.id});jQuery('div[data-video-id][data-video-type="stream"]').each(function(i,element){videoId=jQuery(this).data('video-id');if(videoIds.indexOf(videoId)<0){document.getElementById(element.id).remove()}})
formatVideoSections()}
var loadVideos=function(refreshUrl,retrieveLimit,parentId,videoBaseUrl){let url_video=refreshUrl+"?limit="+retrieveLimit;video_selector='#'+parentId+'-videos';jQuery.ajax({url:url_video,dataType:"json",success:function(data){var videoSection=jQuery('#'+parentId+'-section');if(data.length===0){videoSection.addClass('hide')}else{videoSection.removeClass('hide');var currentGridClass=videoSection.find('.grid-system a.current').data('class');jQuery.each(data,function(index,element){var videoElement=jQuery("#video-"+element.id);if(videoElement.length){updateVideo(videoElement,element)}else{jQuery(video_selector).append(renderEventItem(element,videoBaseUrl,parentId,currentGridClass))}})}
removeCompletedStreams(data)}})};var autoRefreshStreams=function(){window.setInterval(function(){jQuery.ajax({url:'/api/1/streams.json',dataType:"json",success:function(data){jQuery.each(data,function(index,element){var videoElement=jQuery("#video-"+element.id);if(videoElement){updateVideo(videoElement,element)}});removeCompletedStreams(data)}})},5000)}
function renderDates(){jQuery('[data-format-date]').each(function(index,el){var $el=jQuery(el);var date=$el.attr('data-format-date');$el.text(getDate(date))})}
function formatVideoSections(){['most-viewed-videos-section','newest-videos-section','streams-section','results'].forEach(function(id){className='medium-offset-3';items=jQuery('#'+id).find('div.item');items.removeClass(className);if(items.length%2==1){var item=items.last();if(item.hasClass('grid-medium')&&!item.hasClass(className)){item.addClass(className)}}})}
jQuery(document).ready(function(){setTimeout(function(){sidebarBackground=jQuery('.sidebarBg');sidebarBackground.css('width','100%')},250)})
