<#macro breadcrumb addMargin = true>
<!--breadcrumbs-->
<#if !breadcrumbs??>
	<#assign breadcrumbs = navBreadcrumbBuilder.getBreadcrumb(contentModel.storeUrl, "")/>
</#if>
<section id="breadcrumb" <#if addMargin>class="breadMargin"</#if>>
		<div class="row">
				<div class="large-12 columns">
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