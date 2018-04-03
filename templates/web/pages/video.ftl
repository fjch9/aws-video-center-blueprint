<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/web/lib/macros.ftl" as macros />
<#import "/templates/web/lib/video-macros.ftl" as videoMacros />

<!doctype html>
<html class="no-js" lang="en">

<#include "/templates/web/components/head.ftl" />
<body>

<@videoMacros.header />

<!-- full width Video -->
<section class="fullwidth-single-video">
		<div class="row">
				<div class="large-12 columns">
						<div class="flex-video widescreen">
							<video width="560" height="315" autoplay controls>
								<source src="${videoUrl}" type="video/mp4">
								Your browser does not support the video tag.
							</video>
						</div>
				</div>
		</div>
</section>

<@videoMacros.startVideoSection />

<span><i class="fa fa-clock-o"></i>${video.date_dt?date?string("MM/dd/yy")}</span>
<span><i class="fa fa-eye"></i>${viewCount}</span>
<span><i class="fa fa-thumbs-o-up"></i>${likeCount}</span>
<span><i class="fa fa-thumbs-o-down"></i>${dislikeCount}</span>

<@videoMacros.endVideoSection />

<@videoMacros.footer />
</body>
</html>
