<footer>
	<div class="row">
		<div class="large-6 columns">
			<div class="widgetBox">
				<div class="widgetTitle">
					<h5>${contentModel.aboutTitle}</h5>
				</div>
				<div class="textwidget">
				${contentModel.aboutText}
				</div>
			</div>
		</div>
		<!--div class="large-3 medium-6 columns">
			<@renderComponent component = contentModel.recentVideosWidget.item />
		</div>
		<div class="large-3 medium-6 columns">
			<div class="widgetBox">
				<div class="widgetTitle">
					<h5>Tags</h5>
				</div>
				<div class="tagcloud">
					<@renderComponent component = contentModel.tags.item />
				</div>
			</div>
		</div-->
		<div class="large-6 columns">
			<div class="widgetBox">
				<div class="widgetTitle"></div>
				<div class="widgetContent">
					<div class="social-links">
						<@renderComponent component = contentModel.socialMediaLinks.item />
					</div>
				</div>
			</div>
		</div>
		<div class="large-4 columns">
		</div>
	</div>
	<a href="#" id="back-to-top" title="Back to top"><i class="fa fa-angle-double-up"></i></a>
</footer>
<div id="footer-bottom">
	<div class="btm-footer-text text-center">
		<p>${contentModel.copyrightText}</p>
	</div>
</div>
