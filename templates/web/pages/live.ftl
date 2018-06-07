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
		<div id='loading' class="img-loading show"></div>
		<video id="video-player" class="video-js large-centered hide video-player" preload="true" controls="true" autoplay>
			<source src="${videoSource}" type="${videoType}"/>
		</video>
		<section id="unsupported" class="hide">
			<h2 class="message">Your browser does not support this media type</h2>
		</section>
	</section>
<#elseif streamStatus = "finished">
	<div class="row">
		<div class="large-12 columns text-center">
			<div class="row">
				<section>
					<h2>This live stream has finished</h2>
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
					<h1 id="countdownClock" class='countdown'></h1>
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

<script type='text/javascript' src='/static-assets/js/video-player-min.js'></script>
<script type='text/javascript'>	
	jQuery(document).ready(function() {
		<#if streamStatus == "waiting">
			countdown('${startTime?long?c}',
				'countdownClock',
				${video.approximateCountdown},
				'${video.approximationEnd}');
		<#elseif streamStatus == "live">
			playStream('video-player', "${videoSource}", 'loading', 'unsupported');
		</#if>

		renderDates();
	});
</script>  

<@videoMacros.footer />

</body>
</html>
