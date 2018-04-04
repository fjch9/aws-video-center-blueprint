<header>
	<!-- Top -->
	<section id="top" class="topBar topBarBlack show-for-large">
		<div class="row">
			<div class="medium-6 columns">
				<div class="socialLinks">
					<@renderComponent component = contentModel.socialMediaLinks.item />
				</div>
			</div>
			<div class="medium-6 columns">
				<div class="top-button">
					<ul class="menu float-right">
						<#if !profile??>
						<li>
							<a href="/register">Register</a>
						</li>
						<li>
							<a href="/login">Login</a>
						</li>
						<#else>
						<li>
							<a href="/account">My Profile</a>
						</li>
						<li>
							<a href="/crafter-security-logout">Logout</a>
						</li>
						</#if>
					</ul>
				</div>
			</div>
		</div>
	</section><!-- End Top -->
	<!--Navber-->
	<section id="navBar">
		<nav class="sticky-container" data-sticky-container>
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
              <#assign navItems = navTreeBuilder.getNavTree("/site/website", 2, currentPage!'') />
							<div class="top-bar-right">
								<ul class="menu vertical medium-horizontal" data-responsive-menu="drilldown medium-dropdown">
									<li <#if request.requestURI == "/">class="active"</#if>>
										<a href="${navItems.url}"><i class="fa ${navService.getNavIcon(navItems)}"></i>${navItems.label}</a>
									</li>
                  <#list navItems.subItems as item>
                    <li class="<#if item.subItems?has_content>has-submenu</#if> <#if item.active>active</#if>">
                      <a href="${item.url}"><i class="fa ${navService.getNavIcon(item)}"></i>${item.label}</a>
                      <#if item.subItems?has_content>
                      <ul class="submenu menu vertical" data-submenu data-animate="slide-in-down slide-out-up">
                        <#list item.subItems as child>
                        <li><a href="${child.url}"><i class="fa ${navService.getNavIcon(child)}"></i>${child.label}</a></li>
                        </#list>
                      </ul>
                      </#if>
                    </li>
                  </#list>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div id="search-bar" class="clearfix search-bar-light">
					<form method="get" action="/search">
						<div class="search-input float-left">
							<input type="search" name="q" placeholder="${model.searchPlaceholder}">
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
