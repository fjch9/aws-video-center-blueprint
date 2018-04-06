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
                            <div id="${resultsId}"></div>
                        </section>
                    </div><!-- end left side content area -->
                    <!-- sidebar -->
                    <@renderComponent component = contentModel.rightRail.item />
                </div>
            </section><!-- End Category Content-->
            <@renderComponent component = contentModel.footer.item />
        </div>
    </div><!--end off canvas wrapper inner-->
</div><!--end off canvas wrapper-->

<!-- script files -->
<#include "/templates/web/components/scripts.ftl" />

<script src="/static-assets/js/jsrender.js"></script>
<script id="resultsTemplate" type="text/x-jsrender">
    <@resultsMacros.heading id="${resultsId}" title="Search Results for \"${userQuery}\"" subtext="{{:total}} matching found" layout='list' icon='fa-search' />
    <div class="large-12">
        <div class="tabs-content" data-tabs-content="newVideos">
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
                            "${resultsId}",
                            'list')}}
                        {{else type == 'video'}}
                            <@resultsMacros.video id="{{:id}}" thumbnail="{{:thumbnail}}" title="{{:title_s}}" summary="{{:summary_s}}" date="{{:~getDate(date_dt)}}" viewCount="{{:viewCount}}" likeCount="{{:likeCount}}" dislikeCount="{{:dislikeCount}}" parentId="${resultsId}" baseUrl="${contentModel.videoLandingUrl}?id=" gridStyle='list' />                       
                        {{/if}}
                    {{/for}}
                </div>
            </div>
        </div>
        {{if hasMore}}
        <div class="text-center loadMore">
            <button id="btn-load-more" class="button" type="button">load more</button>
        </div>
        {{/if}}
    </div>
</script>

<script>
    var rows = ${rows}, times = 1;

    function loadResults(params) {
        jQuery.get('/api/1/search.json', params, function(res){
            jQuery('#results').html(jQuery.templates('#resultsTemplate').render(res));
            jQuery('.tabs-content .item [data-mh]').matchHeight();
        });
    }

    jQuery.views.helpers({
        getDate: getDate,
        renderEventItem: renderEventItem
    });

    jQuery(document).ready(function(){
        loadResults({
            q: '${q}',
            start: ${start},
            rows: ${rows}
        });

        jQuery(document).on('click', '#btn-load-more', function(){
            times++;

            loadResults({
                q: '${q}',
                start: 0,
                rows: rows * times
            });
        });
    });
</script>
<@studio.toolSupport />
</body>
</html>