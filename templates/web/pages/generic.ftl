<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/web/lib/macros.ftl" as macros />

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

        <@macros.breadcrumb/>

        <section class="category-content">
            <div class="row">
                <!-- left side content area -->
                <div class="large-8 columns">
                    <section class="content content-with-sidebar">
                        <!-- newest video -->
                        <div class="main-heading removeMargin">
                            <div class="row secBg padding-14 removeBorderBottom">
                                <div class="medium-8 small-8 columns">
                                    <div class="head-title">
                                        <#if contentModel.icon?has_content><i class="fa ${contentModel.icon}"></i></#if>
                                        <h4>${contentModel.title_s}</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row secBg">
                            <div class="large-12 columns">
                                <article class="page-content">
                                    ${contentModel.body_html}
                                </article>
                            </div>
                        </div>
                    </section>
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
  <@studio.toolSupport />
</body>
</html>
