<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/web/lib/macros.ftl" as macros />
<#import "/templates/web/lib/video-player-macros.ftl" as videoMacros />

<!doctype html>
<html class="no-js" lang="en">

<#include "/templates/web/components/head.ftl" />
<body>

<@videoMacros.header />

<#if streamStatus = "live">				
	<section class="fullwidth-single-video">
		<div class="img-loading show"></div>
		<video id="example-video" class="video-js large-centered hide" preload="true" controls="true" autoplay>
			<source src="${videoSource}" type="${videoType}"/>
		</video>
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
					<div id="countdown2"></div>
				</section>
			</div>
		</div>
	</div>
</#if>

<@videoMacros.startVideoSection />

<span><i class="fa fa-clock-o icon-start-time"></i> Start time: <span data-format-date="${video.startDate_dt?datetime?iso_utc}"></span></span> <br>
<span><i class="fa fa-clock-o icon-end-time"></i> End time: <span data-format-date="${video.endDate_dt?datetime?iso_utc}"></span></span> <br>	
<span><i class="fa fa-eye"></i>${viewCount}</span>
<span><i class="fa fa-thumbs-o-up"></i>${likeCount}</span>
<span><i class="fa fa-thumbs-o-down"></i>${dislikeCount}</span>

<@videoMacros.endVideoSection />

<script>	
	jQuery(document).ready(function() {
		<#if streamStatus == "waiting">
			var startDate = new Date('${video.startDate_dt?datetime?iso_utc}');
	
		    jQuery('#countdown2').timeTo({
            timeTo: new Date(startDate),
            displayDays: 2,
            theme: "black",
            displayCaptions: true,
            fontSize: 32,
            captionSize: 14
        	},function(){ 
        		setTimeout(function(){
        			location.reload();
        		},1000); 
        	});
		<#elseif streamStatus == "live">
			if (Hls.isSupported()) {
				var video = document.getElementById('example-video');
				var hls = new Hls();
 	    		// bind them together
 	    		hls.attachMedia(video);
				// MEDIA_ATTACHED event is fired by hls object once MediaSource is ready
				hls.on(Hls.Events.MEDIA_ATTACHED, function () {
					
					hls.loadSource("${videoSource}");
					hls.on(Hls.Events.MANIFEST_PARSED, function (event, data) {
						
					});
				});

				video.oncanplay = function() {
					jQuery('.img-loading').addClass('hide');
				    jQuery('#example-video').removeClass('hide');
				    video.muted = video.muted;
				    video.autoplay = true;
				    video.play();
				};
			}
		</#if>

		renderDates();
	});
</script>  

<@videoMacros.footer />

</body>
</html>
