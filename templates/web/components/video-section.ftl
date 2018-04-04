<#assign videoSectionId = contentModel["file-name"]?keep_before(".xml") />
<#assign refreshes = contentModel.refreshUrl?? && contentModel.refreshUrl != "">
<#assign videoBaseUrl = "${contentModel.videoLandingUrl}?id=" />

<section class="content content-with-sidebar">
	<!-- newest video -->
	<div class="main-heading borderBottom">
		<div class="row padding-14 ">
			<div class="medium-8 small-8 columns">
				<div class="head-title">
					<i class="fa fa-film"></i>
					<h4>${contentModel.title_s}</h4>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<#if refreshes>
			<div class="large-12 columns">
				<h3 id="${videoSectionId}-message-no-video" class="text-center hide">${contentModel.emptyMessage}</h3>
			</div>
		</#if>

		<div class="large-12 columns">
			<div class="row column head-text clearfix">
				<div id="${videoSectionId}-grid-system" class="grid-system pull-right show-for-large">
					<a class="secondary-button grid-default" href="#" data-class="grid-default"><i class="fa fa-th"></i></a>
					<a class="secondary-button current grid-medium" href="#" data-class="grid-medium"><i class="fa fa-th-large"></i></a>
					<a class="secondary-button list" href="#" data-class="list"><i class="fa fa-th-list"></i></a>
				</div>
			</div>
			<div id="${videoSectionId}" class="tabs-content" data-tabs-content="${videoSectionId}">
				<div class="tabs-panel is-active" id="new-all">
					<div class="row list-group" id="${videoSectionId}-videos">
						<#if !refreshes>
							<#list videos as video>
								<#assign videoUrl = "${videoBaseUrl}${video.id}" />
								<div class="item large-4 medium-6 columns <#if video?is_last>end</#if> grid-medium" data-mh="${videoSectionId}">
									<div class="post thumb-border">
										<div class="post-thumb">
											<img src="${video.thumbnail}">
											<a href="${videoUrl}" class="hover-posts">
												<span><i id="icon-circle" class="fa fa-play-circle"></i></span>
											</a>
										</div>
										<div class="post-des">
											<h6><a href="${videoUrl}">${video.title_s}</a></h6>
											<div class="post-stats clearfix">
												<p class="pull-left">
													<i class="fa fa-clock-o"></i>
													<span>${video.date_dt?date("MM/dd/yyyy")?string.short}</span>
												</p>
												<p class="pull-left">
													<i class="fa fa-eye"></i>
													<span>${video.viewCount}</span>
												</p>
												<p class="pull-left">
													<i class="fa fa-thumbs-o-up"></i>
													<span>${video.likeCount}</span>
												</p>
												<p class="pull-left">
													<i class="fa fa-thumbs-o-down"></i>
													<span>${video.dislikeCount}</span>
												</p>
											</div>
											<div class="post-summary">
												<p>${video.summary_s}</p>
											</div>
										</div>
									</div>
								</div>
							</#list>
						</#if>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<#if refreshes>
<script type="text/javascript">
	jQuery(document).ready(function() { 
    	loadVideos("${contentModel.refreshUrl}", ${contentModel.maxVideosToDisplay}, "${videoSectionId}", "${videoBaseUrl}");

	    window.setInterval(function() {
	    		loadVideos("${contentModel.refreshUrl}", ${contentModel.maxVideosToDisplay}, "${videoSectionId}", "${videoBaseUrl}")
	    	}, 5000);
	});
</script>
</#if>