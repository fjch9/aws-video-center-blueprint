<#import "/templates/web/lib/macros.ftl" as macros />
<#import "/templates/system/common/cstudio-support.ftl" as studio />

<!doctype html>
<html class="no-js" lang="en">

<#include "/templates/web/components/head.ftl" />

<body>
	<#assign inverted = false>
	<#include "/templates/web/components/persistent-nav.ftl">

<div class="off-canvas-wrapper">
	
	<div class="off-canvas-wrapper-inner" data-off-canvas-wrapper>
		<@renderComponent component = contentModel.mobileNavigation.item />
		<div class="off-canvas-content" data-off-canvas-content>
			<@renderComponent component = contentModel.header.item additionalModel = { 'currentPage' : model.storeUrl, 'backLink' : model.backLink } />

            <@macros.breadcrumb addMargin = false />

			<!-- full width Video ?start=${startTimestamp?c}-->
			<#if streamStatus = "live">
				<#assign completeUrl = "${endpoints[0].url}?=start${startTimestamp?c}">
				<#assign videoSource = "${completeUrl}"/>
				<#assign videoType = "${endpoints[0].encoding}"/>
				
				<section class="fullwidth-single-video">
						<!-- The site theme is breaking videojs styles -->
						<!-- <div class="row"> -->
								<!-- <div class="large-12 columns"> -->
									<!-- <div class="flex-video widescreen"> -->
											<video id="example-video" class="video-js large-centered" controls>
												<source src="${videoSource}" type="${videoType}"/>
											</video>
									<!-- </div> -->
								<!-- </div> -->
						<!-- </div> -->
				</section>
			<#elseif streamStatus = "finished">
				<div class="row">
					<div class="large-12 columns text-center">
						<div class="row">
							<section>
								<h2>This live stream has finished</h1>
							</section>
						</div>
					</div>
				</div>
			<#else>
				<div class="row">
					<div class="large-12 columns text-center">
						<div class="row">
							<section>
								<h2>This live stream will start in</h2>
								<div id="countdown"></div>
							</section>
						</div>
					</div>
				</div>
			</#if>
			<div class="row">
				<!-- left side content area -->
				<div class="large-8 columns">
					<!-- single post stats -->
					<section class="SinglePostStats">
						<!-- newest video -->
						<div class="row secBg">
							<div class="large-12 columns">
								<div class="media-object stack-for-small">
									<div class="media-object-section object-second">
										<div class="author-des clearfix" style="border-bottom: 0">
											<div class="post-title">
												
												<h3>${video.title_s}</h3>
												
												<p>
													<#-- <span><i class="fa fa-clock-o"></i>${video.date_dt?date?string("MM/dd/yy")}</span> -->
													<span><i class="fa fa-clock-o"></i> Start time: <span data-format-date="${video.startDate_dt?datetime?iso_utc}"></span></span> <br>
													<span><i class="fa fa-clock-o"></i> End time: <span data-format-date="${video.endDate_dt?datetime?iso_utc}"></span></span> <br>	
													<span><i class="fa fa-eye"></i>${viewCount}</span>
													<span><i class="fa fa-thumbs-o-up"></i>${likeCount}</span>
													<span><i class="fa fa-thumbs-o-down"></i>${dislikeCount}</span>
												</p>
											</div>
										</div>
										<#if profile??>
										<div class="social-share">
											<div class="post-like-btn clearfix">
												<a href="#" id="fav-button" class="button tiny <#if isFavorite>selected</#if>"><i class="fa fa-heart"></i></a>
												<a href="#" id="like-button" class="button tiny <#if isLiked>selected</#if>"><i class="fa fa-thumbs-o-up"></i></a>
												<a href="#" id="dislike-button" class="button tiny <#if isDisliked>selected</#if>"><i class="fa fa-thumbs-o-down"></i></a>
											</div>
										</div>
										</#if>
									</div>
								</div>
							</div>
						</div>
					</section><!-- End single post stats -->

					<!-- single post description -->
					<section class="singlePostDescription">
						<div class="row secBg">
							<div class="large-12 columns">
								<div class="heading">
									<h5>Description</h5>
								</div>
								<div class="description showmore_one">
									${video.description_html}

									<#if video.categories?? && video.categories.item?? && (video.categories.item?size >= 0)>
									<div class="categories">
										<button><i class="fa fa-folder"></i>Categories</button>
										<#list video.categories.item as category>
										<a href="/category?id=${category.key}" class="inner-btn">${category.value_smv}</a>
										</#list>
									</div>
									</#if>
									<#if video.tags?? && video.tags.item?? && (video.tags.item?size >= 0)>
									<div class="tags">
										<button><i class="fa fa-tags"></i>Tags</button>
										<#list video.tags.item as tag>
										<a href="/tag?id=${tag.value_smv}" class="inner-btn">${tag.value_smv}</a>
										</#list>
									</div>
									</#if>
								</div>
							</div>
						</div>
					</section><!-- End single post description -->
					<!-- related Posts -->
					<section class="content content-with-sidebar related">
						<div class="row secBg">
							<div class="large-12 columns">
								<div class="main-heading borderBottom">
									<div class="row padding-14">
										<div class="medium-12 small-12 columns">
											<div class="head-title">
												<i class="fa fa-film"></i>
												<h4>Related Videos</h4>
											</div>
										</div>
									</div>
								</div>

								<div class="row list-group">
									<#list relatedVideos as relatedVideo>
									<#assign relatedVideoUrl = "${request.requestURI}?id=${relatedVideo.id}" />
									<div class="item large-4 columns <#if relatedVideo?is_last>end</#if> group-item-grid-default" data-mh="related-videos">
										<div class="post thumb-border">
											<div class="post-thumb">
												<img src="${relatedVideo.thumbnail}">
												<a href="${relatedVideoUrl}" class="hover-posts">
													<span><i class="fa fa-play-circle"></i></span>
												</a>
											</div>
											<div class="post-des">
												<h6><a href="#">${relatedVideo.title_s}</a></h6>
												<div class="post-stats clearfix">
													<#-- <p class="pull-left">
														<i class="fa fa-clock-o"></i>
														<span>${relatedVideo.date_dt?date("MM/dd/yyyy")?date}</span>
													</p> -->
													<p class="pull-left">
														<i class="fa fa-eye"></i>
														<span>${relatedVideo.viewCount}</span>
													</p>
													<p class="pull-left">
														<i class="fa fa-thumbs-o-up"></i>
														<span>${relatedVideo.likeCount}</span>
													</p>
													<p class="pull-left">
														<i class="fa fa-thumbs-o-down"></i>
														<span>${relatedVideo.dislikeCount}</span>
													</p>
												</div>
												<div class="post-summary">
													<p>${relatedVideo.summary_s}</p>
												</div>
												<div class="post-button">
													<a href="${relatedVideoUrl}" class="secondary-button"><i class="fa fa-play-circle"></i></a>
												</div>
											</div>
										</div>
									</div>
									</#list>
								</div>
							</div>
						</div>
					</section><!--end related posts-->

				</div><!-- end left side content area -->
				<@renderComponent component = contentModel.rightRail.item />
			</div>

			<@renderComponent component = contentModel.footer.item />
		</div><!--end off canvas content-->
	</div><!--end off canvas wrapper inner-->
</div><!--end off canvas wrapper-->
<!-- script files -->
<#include "/templates/web/components/scripts.ftl" />
<script>
	// function getDate(videoDate){
	// 	var formatedStartDate = moment(videoDate);
	// 	var currentTimeZone = new Date(formatedStartDate).toString().match(/\(([A-Za-z\s].*)\)/)[1];
	// 	return formatedStartDate.format('lll')+" "+currentTimeZone
	// }

	// function getTimeZone(){
	// 	return Intl.DateTimeFormat().resolvedOptions().timeZone;
	// }

	function daysBetween(setDate, today){
		//Get 1 day in milliseconds
  		var one_day=1000*60*60*24;

  		var date1_ms = today.getTime();
  		var date2_ms = setDate.getTime();
  		console.log('estoy en la funcion db: '+date1_ms +' - ' + date2_ms);
  		var difference_ms = date2_ms - date1_ms;
  		console.log('Diferencia entre los dos: '+difference_ms);
		//take out milliseconds
	  //take out milliseconds
    //take out milliseconds
	  	difference_ms = difference_ms/1000;
	  	var seconds = Math.floor(difference_ms % 60);
	  	difference_ms = difference_ms/60; 
	  	var minutes = Math.floor(difference_ms % 60);
	  	difference_ms = difference_ms/60; 
	  	var hours = Math.floor(difference_ms % 24);  
	  	var days = Math.floor(difference_ms/24);

	  	console.log(days + ' days, ' + hours + ' hours, ' + minutes + ' minutes, and ' + seconds + ' seconds');
	}

	jQuery(document).ready(function() {
		/*jQuery("#fav-button").click(function(e){
			e.preventDefault();

			jQuery.get("/api/1/profile/toggle/favorite.json", { id: "${requestParameters["id"]}" }, function(res) {
				jQuery(e.target).toggleClass("primary");
			});
		});
		jQuery("#like-button").click(function(e){
			e.preventDefault();

			jQuery.get("/api/1/profile/toggle/like.json", { id: "${requestParameters["id"]}" }, function(res) {
				jQuery(e.target).toggleClass("primary");
			});
		});
		jQuery("#dislike-button").click(function(e){
			e.preventDefault();

			jQuery.get("/api/1/profile/toggle/dislike.json", { id: "${requestParameters["id"]}" }, function(res) {
				jQuery(e.target).toggleClass("primary");
			});
		});*/
        var actionsMap = {
			"fav-button": "favorite",
			"like-button": "like",
			"dislike-button": "dislike"
		}
        
        jQuery(".social-share .post-like-btn a").on("click", function(e){

			e.preventDefault();	
        
            var element = e.target.id ? e.target : e.target.parentElement,
            	id = jQuery(element).attr("id"),
                url = "/api/1/profile/toggle/" + actionsMap[id] + ".json";
        
            jQuery.get(url, { id: "${requestParameters["id"]}" }, function(res) {
                if("fav-button" === id){
                    jQuery(element).toggleClass("selected");	
                }else{
					jQuery('.social-share .post-like-btn a:not("#fav-button, #' + id + '")').removeClass('selected primary');
                    jQuery(element).toggleClass("selected");	
                }
            });
        })
        
        <#include "/templates/web/components/analytics.ftl"/>
		
		<#if streamStatus == "waiting">

			// var startDate = new Date('${video.startDate_dt?datetime?string}')
			// // var startDate = new Date('${video.startDate_dt?datetime?string}')
			// var diffDate = new Date();
			
			
			// diffDate.setSeconds(diffDate.getSeconds() + 40);
			
			// var clock = jQuery('#countdown').FlipClock(startDate, {
			// 	countdown: true,
			// 	callbacks: {
   //              stop: function() {
   //                  // Do whatever you want to do here,
   //                  // that may include hiding the clock 
   //                  // or displaying the image you mentioned
   //                  location.reload();
               
   //              	}
   //          	}
			// });
			
			var startDate = new Date('${video.startDate_dt?datetime?string}').getTime();
		    var today = new Date().getTime();
		    var difference_ms = startDate - today;
		    console.log(difference_ms);
		    difference_ms = difference_ms/1000;
		  	var seconds = Math.floor(difference_ms % 60);
		  	difference_ms = difference_ms/60; 
		  	var minutes = Math.floor(difference_ms % 60);
		  	difference_ms = difference_ms/60; 
		  	var hours = Math.floor(difference_ms % 24);  
		  	var days = Math.floor(difference_ms/24);

		  	console.log(days + ' days, ' + hours + ' hours, ' + minutes + ' minutes, and ' + seconds + ' seconds');
		    //daysBetween(startDate, today);
		    //console.log('ya acabe');

		     var clock = jQuery('#countdown').FlipClock(difference_ms,{
		        autoStart: false,
		        clockFace: 'DailyCounter',
		        countdown: true
		    });
		    
		   // clock.setTime(timeLeft);
		    clock.start();   
		       


		<#elseif streamStatus == "live">
			 if (Hls.isSupported()) {
 	    		var video = document.getElementById('example-video');
 	    		var hls = new Hls();
 	    		// bind them together
				hls.attachMedia(video);
				// MEDIA_ATTACHED event is fired by hls object once MediaSource is ready
				hls.on(Hls.Events.MEDIA_ATTACHED, function () {
		        console.log("video and hls.js are now bound together !");
		        hls.loadSource("${videoSource}");
		        hls.on(Hls.Events.MANIFEST_PARSED, function (event, data) {
		          console.log("manifest loaded, found " + data.levels.length + " quality level");
		        });
		      });
			    video.play();
    		}
		</#if>

	});
</script>  
<@studio.toolSupport />
</body>
</html>
