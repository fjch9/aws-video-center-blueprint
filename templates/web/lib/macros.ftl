<#macro breadcrumb>
<!--breadcrumbs-->
<#if !breadcrumbs??>
	<#if contentModel??>
		<#assign breadcrumbs = navBreadcrumbBuilder.getBreadcrumb(contentModel.storeUrl, "") />
	<#else>
		<#assign breadcrumbs = [{"url":"/","label":"home"}, {"url":"#","label":"page not found"}] />
	</#if>
</#if>
<section id="breadcrumb">
		<div class="row">
				<div class="large-12 breadcrumbContainer">
						<nav aria-label="You are here:" role="navigation">
								<ul class="breadcrumbs">
										<#list breadcrumbs as item>
										<li>
											<#if item.url == "/"><i class="fa fa-home"></i></#if>
											<a href="${item.url}">${item.label}</a>
										</li>
										</#list>
								</ul>
						</nav>
				</div>
		</div>
</section><!--end breadcrumbs-->
</#macro>

<#macro topButtons sidebar = false>
<#if !sidebar><div class="medium-6 columns"></#if>
	<div class="<#if sidebar>off-social<#else>socialLinks</#if>">
		<#if sidebar><h6>Get Social</h6></#if>
		<@renderComponent component = contentModel.socialMediaLinks.item />
	</div>
<#if !sidebar></div>
<div class="medium-6 columns"></#if>
	<div class="top-button">
		<ul class="menu <#if !sidebar>float-right</#if>">
            <li>
                <a href="${contentModel.contactUsURL}">Contact Us</a>
            </li>
			<#if !profile??>
    			<li>
    				<a href="/register">Register</a>
    			</li>
    			<li <#if sidebar>class="dropdown-login"</#if>>
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
<#if !sidebar></div></#if>
</#macro>

<#macro menuItems navItems sidebar = false>
    <li <#if !sidebar && request.requestURI == "/">class="active"</#if>>
      <a href="${navItems.url}"><i class="fa ${navService.getNavIcon(navItems)}"></i>${navItems.label}</a>
    </li>
    <#list navItems.subItems as item>
        <li class="<#if item.subItems?has_content>has-submenu</#if> <#if !sidebar && item.active>active</#if>">
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
</#macro>