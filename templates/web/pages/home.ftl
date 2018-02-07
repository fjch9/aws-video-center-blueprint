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
				<@renderComponent component = contentModel.videoCarousel.item />
				<section class="mainContentv3">
					<div class="row">
						<!-- left side content area -->
						<div class="large-8 columns parentbg">
							<div class="sidebarBg"></div>

							<#list contentModel.videoSections.item as videoSection>
								<@renderComponent component = videoSection />
							</#list>

						</div><!-- end left side content area -->
						<@renderComponent component = contentModel.rightRail.item />
					</div>
				</section>

				<@renderComponent component = contentModel.footer.item />
			</div><!--end off canvas content-->
		</div><!--end off canvas wrapper inner-->
	</div><!--end off canvas wrapper-->
	<!-- script files -->
	<#include "/templates/web/components/scripts.ftl" />
</body>
</html>
