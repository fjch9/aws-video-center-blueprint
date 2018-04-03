<div class="widgetBox">
	<div class="widgetTitle">
		<h5>${contentModel.title_s}</h5>
	</div>
	<div class="widgetContent">
		<#list videos as video>
		<#assign videoUrl = "${contentModel.videoLandingUrl}?id=${video.id}" />
		<div class="media-object stack-for-small">
			<div class="media-object-section">
				<div class="recent-img">
					<img src= "${video.thumbnail}">
					<a href="${videoUrl}" class="hover-posts">
						<span><i class="fa fa-play-circle"></i></span>
					</a>
				</div>
			</div>
			<div class="media-object-section">
				<div class="media-content">
					<h6><a href="${videoUrl}">${video.title_s}</a></h6>
				</div>
			</div>
		</div>
		</#list>
	</div>
</div>
