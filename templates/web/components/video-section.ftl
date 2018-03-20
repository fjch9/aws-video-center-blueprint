<#assign videoSectionId = contentModel["file-name"]?keep_before(".xml") />
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
		<div class="large-12 columns">
			<div class="row column head-text clearfix">
				<div class="grid-system pull-right show-for-large">
					<a class="secondary-button grid-default" href="#"><i class="fa fa-th"></i></a>
					<a class="secondary-button current grid-medium" href="#"><i class="fa fa-th-large"></i></a>
					<a class="secondary-button list" href="#"><i class="fa fa-th-list"></i></a>
				</div>
			</div>
			<div class="tabs-content" data-tabs-content="${videoSectionId}">
				<div class="tabs-panel is-active" id="new-all">
					<div class="row list-group video-list">
						
					</div>
				</div>
			</div>
			<div class="text-center row-btn">
				<a class="button radius" href="${contentModel.allVideosUrl}">View All</a>
			</div>
		</div>
	</div>
</section>
