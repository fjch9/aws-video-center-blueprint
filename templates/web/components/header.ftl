<#import "/templates/web/lib/macros.ftl" as macros />

<header>
	<section id="top" class="topBar topBarBlack show-for-large">
		<div class="row">
			<@macros.topButtons contactUsUrl=contentModel.contactUsURL />
		</div>
	</section>

	<!--Navbar-->
	<section id="navBar">
		<nav class="sticky-container title-container" data-sticky-container>
			<div class="sticky topnav" data-sticky data-top-anchor="navBar" data-btm-anchor="footer-bottom:bottom" data-margin-top="0" data-margin-bottom="0" style="width: 100%; background: #fff;" data-sticky-on="large">
				<div class="row">
					<div class="large-12 columns">
						<div class="title-bar" data-responsive-toggle="beNav" data-hide-for="large">
							<button class="menu-icon" type="button" data-toggle="offCanvas-responsive"></button>
							<div class="title-bar-title"><a href="/"><img src="${contentModel.logo}" alt="${contentModel.logoAltText}"><a href="/"></div>
						</div>

						<div class="top-bar show-for-large" id="beNav">
							<div class="top-bar-left">
								<ul class="menu">
									<li class="menu-text">
										<a href="/"><img class="main-logo "src="${contentModel.logo}" alt="${contentModel.logoAltText}"></a>
									</li>
								</ul>
							</div>
							<div class="top-bar-right search-btn">
								<ul class="menu">
									<li class="search">
										<i class="fa fa-search"></i>
									</li>
								</ul>
							</div>
							<div class="top-bar-right">
								<ul class="menu vertical medium-horizontal" data-responsive-menu="drilldown medium-dropdown">
									<@macros.menuItems navItems = navTreeBuilder.getNavTree("/site/website", 2, currentPage!'') />
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div id="search-bar" class="clearfix search-bar-light">
					<form method="get" action="/search">
						<div class="search-input float-left">
							<input id='popup-search-input' type="search" name="q" placeholder="${model.searchPlaceholder}">
						</div>
						<div class="search-btn float-right text-right">
							<button class="button" type="submit">search now</button>
						</div>
					</form>
				</div>
			</div>
		</nav>
	</section>
</header>
