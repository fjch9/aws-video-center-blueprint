<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/web/lib/macros.ftl" as macros />
<#import "/templates/web/lib/video-list-macros.ftl" as resultsMacros />

<!doctype html>
<html class="no-js" lang="en">
<#include "/templates/web/components/head.ftl" />
<#assign resultsId = "results">
<body>
    <#assign inverted = false>
<div class="off-canvas-wrapper">
    <div class="off-canvas-wrapper-inner" data-off-canvas-wrapper>
        <@renderComponent component = contentModel.mobileNavigation.item />
        <div class="off-canvas-content" data-off-canvas-content>
            <@renderComponent component = contentModel.header.item additionalModel = { 'currentPage' : model.storeUrl, 'backLink' : model.backLink } />
            <@macros.breadcrumb/>
            <section class="category-content mainSection">
                <div class="row">
                    <!-- left side content area -->
                    <div class="large-8 columns">
                        <section class="content content-with-sidebar">
                            <div data-limit-video="${contentModel.videoPageSize}"></div>
                            <div id="${resultsId}"></div>
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
<script src="/static-assets/js/jsrender.js"></script>
<script id="resultsTemplate" type="text/x-jsrender">
    <@resultsMacros.heading id="${resultsId}" title="${title}" subtext="{{:total}} videos" />
    <div class="tabs-content" data-tabs-content="videos">
        <div class="tabs-panel is-active" id="new-all">
            <div class="row list-group">
                {{for items ~size=items.length}}
                    {{if type == 'stream'}}
                        {{:~renderEventItem({
                                "id": id,
                                "thumbnail": thumbnail,
                                "title_s": title_s,
                                "startDate_dt": startDate_dt,
                                "endDate_dt": endDate_dt,
                                "viewCount": viewCount,
                                "likeCount": likeCount,
                                "dislikeCount": dislikeCount,
                                "summary_s": summary_s,
                                "liveNow": liveNow
                            },
                            "${contentModel.streamLandingUrl}?id=",
                            "${resultsId}")}}
                    {{else type == 'video'}}
                        <@resultsMacros.video id="{{:id}}" thumbnail="{{:thumbnail}}" title="{{:title_s}}" summary="{{:summary_s}}" date="{{:~getDate(date_dt)}}" viewCount="{{:viewCount}}" likeCount="{{:likeCount}}" dislikeCount="{{:dislikeCount}}" parentId="${resultsId}" baseUrl="${contentModel.videoLandingUrl}?id=" />
                    {{/if}}
                {{/for}}
            </div>
        </div>
    </div>
    {{if page > 1 || hasMore}}
    <div class="pagination">
        {{if page > 1}}<a id="prev-page-button" href="#" class="prev page-numbers">« Previous</a>{{/if}}
        {{if page > 1}}<a id="curr-minus-one-page-button" href="#" class="page-numbers">{{:page - 1}}</a>{{/if}}
        <span class="page-numbers current">{{:page}}</span>
        {{if hasMore}}<a id="curr-plus-one-page-button" href="#" class="page-numbers">{{:page + 1}}</a>{{/if}}
        {{if hasMore}}<a id="next-page-button"href="#" class="next page-numbers">Next »</a>{{/if}}
    </div>
    {{/if}}
</script>
<script>
    var start = 0, rows = ${rows}, page = 1;
    function loadResults(params) {
        jQuery.get('/api/1/search.json', params, function(res){
            res.page = page
            jQuery('#results').html(jQuery.templates('#resultsTemplate').render(res));
            jQuery('.tabs-content .item [data-mh]').matchHeight();
            formatVideoSections();
        });
    }

    function loadPage() {
        loadResults({
            q: '${q}',
            start: (page - 1) * ${rows},
            rows: ${rows}
        });
    }

    jQuery.views.helpers({
		getDate: getDate,
        renderEventItem: renderEventItem
    });

    jQuery(document).ready(function(){
        loadResults({
            q: '${q}',
            start: start,
            rows: ${rows}
        });
        jQuery(document).on('click', '#prev-page-button', function(){
            page--;
            loadPage()
        });
        jQuery(document).on('click', '#curr-minus-one-page-button', function(){
            page--;
            loadPage()
        });
        jQuery(document).on('click', '#curr-plus-one-page-button', function(){
            page++;
            loadPage()
        });
        jQuery(document).on('click', '#next-page-button', function(){
            page++;
            loadPage()
        });
    });
</script>
<@studio.toolSupport />
</body>
</html>