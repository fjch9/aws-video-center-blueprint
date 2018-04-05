<div class="large-4 columns">
	<aside class="sidebar">
		<div class="row">
			<!-- search Widget -->
			<div class="large-12 medium-7 medium-centered columns">
				<div class="widgetBox">
					<div class="widgetTitle">
						<h5>Search</h5>
					</div>
					<form id="searchform" action="/search" method="get" role="search">
						<div class="input-group">
							<input name="q" class="input-group-field" type="text" placeholder="Enter your keyword">
							<div class="input-group-button">
								<input type="submit" class="button" value="Submit">
							</div>
						</div>
					</form>
				</div>
			</div><!-- End search Widget -->

			<!-- categories -->
			<div class="large-12 medium-7 medium-centered columns">
				<div class="widgetBox clearfix">
					<div class="widgetTitle">
						<h5>Categories</h5>
					</div>
					<div class="widgetContent clearfix">
						<ul>
							<@renderComponent component = contentModel.categories.item />
						</ul>
					</div>
				</div>
			</div>

			<!-- Recent post videos -->
			<div class="large-12 medium-7 medium-centered columns">
				<@renderComponent component = contentModel.recentVideosWidget.item />
			</div><!-- End Recent post videos -->

			<!-- tags -->
			<div class="large-12 medium-7 medium-centered columns">
				<div class="widgetBox">
					<div class="widgetTitle">
						<h5>Tags</h5>
					</div>
					<div class="tagcloud">
						<@renderComponent component = contentModel.tags.item />
					</div>
				</div>
			</div><!-- End tags -->
		</div>
	</aside>
</div><!-- end sidebar -->
