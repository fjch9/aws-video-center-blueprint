<section id="premium">
		<div class="row">
				<div class="heading clearfix">
						<div class="large-10 columns">
								<h4><i class="fa fa-play-circle-o"></i>${contentModel.title}</h4>
						</div>
						<div class="large-2 columns">
								<div class="navText show-for-large text-right">
										<a class="prev secondary-button"><i class="fa fa-angle-left"></i></a>
										<a class="next secondary-button"><i class="fa fa-angle-right"></i></a>
								</div>
						</div>
				</div>
		</div>
		<div id="owl-demo" class="owl-carousel carousel" data-car-length="4" data-items="4" data-loop="true" data-nav="false" data-autoplay="true" data-autoplay-timeout="3000" data-dots="false" data-auto-width="false" data-responsive-small="1" data-responsive-medium="2" data-responsive-xlarge="5">
				<#list videos as video>
				<#assign videoUrl = "${contentModel.videoLandingUrl}?id=${video.id}" />
				<div class="item">
						<figure class="premium-img">
								<img src="${video.thumbnail}" alt="carousel">
								<figcaption>
										<h5>${video.title_s}</h5>
										<p>${video.categories?join(", ")}</p>
								</figcaption>
						</figure>
						<a href="${videoUrl}" class="hover-posts">
							 <span><i class="fa fa-play"></i>Watch Video</span>
						</a>
				</div>
				</#list>
		</div>
</section><!-- End Premium Videos -->
