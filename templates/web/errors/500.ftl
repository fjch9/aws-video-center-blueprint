<#import "/templates/web/lib/macros.ftl" as macros />

<#assign contentModel = siteItemService.getSiteItem("/site/website/index.xml") />
<!doctype html>
<html class="no-js" lang="en">

<#include "/templates/web/components/head.ftl" />
<body>
  <div class="off-canvas-wrapper">
    <div class="off-canvas-wrapper-inner" data-off-canvas-wrapper>
      <!--header-->
      <@renderComponent component = contentModel.mobileNavigation.item />
      <div class="off-canvas-content" data-off-canvas-content>
        <@renderComponent component = contentModel.header.item />
        <@macros.breadcrumb />
        <section class="error-page">
          <div class="row">
            <div class="large-8 large-centered columns">
              <div class="error-page-content text-center">
                <h1>Unexpected Error</h1>
                <p>Please try again or contact an administrator</p>
                <a href="/" class="button">Go Back Home Page</a>
              </div>
            </div>
          </div>
        </section>
        <!-- footer -->
        <@renderComponent component = contentModel.footer.item />
      </div><!--end off canvas content-->
    </div><!--end off canvas wrapper inner-->
  </div><!--end off canvas wrapper-->
  <!-- script files -->
  <#include "/templates/web/components/scripts.ftl" />
</body>
</html>