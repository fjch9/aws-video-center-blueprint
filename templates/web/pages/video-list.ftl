<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/web/lib/macros.ftl" as macros />
<#import "/templates/web/lib/video-list-macros.ftl" as resultsMacros />

<!doctype html>
<html class="no-js" lang="en">
<#include "/templates/web/components/head.ftl" />
<body>
    <#assign inverted = false>
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
                            <div data-limit-video="${contentModel.videoPageSize}"></div>
                            <div id="results" class="row secBg"></div>
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
<#assign resultsId = "video-list">
<script id="resultsTemplate" type="text/x-jsrender">
    <@resultsMacros.heading id="${resultsId}" title="${title}" subtext="{{:total}} videos" />
    <div id="${resultsId}" class="tabs-content" data-tabs-content="videos">
        <div class="tabs-panel is-active" id="new-all">
            <div class="row list-group">
                {{for items ~size=items.length}}
                <div class="item large-4 medium-6 columns {{if #index + 1 == ~size}}end{{/if}} columns grid-medium">
                  {{if type == 'stream'}}
                    <div class="post thumb-border">
                        <div class="post-thumb">
                            <img src="{{:thumbnail}}">
                            <div class="tag-live {{if liveNow == false}}hide{{/if}}">
                                <figcaption>
                                    <p class="live-text">Live</p>
                                </figcaption>
                            </div>
                            <a href="{{:~getStreamUrl(id)}}" class="hover-posts">
                                <span><i class="fa fa-play-circle icon-circle"></i></span>
                            </a>
                        </div>
                        <div class="post-des">
                            <h6><a href="{{:~getStreamUrl(id)}}">{{:title_s}}</a></h6>
                            <div class="post-stats clearfix">
                                <p class="video-list-start-end">
                                    <i class="fa fa-clock-o icon-start-time"></i>
                                    <span>Start time: {{:~getDate(startDate_dt)}}</span>
                                    <br>
                                    <i class="fa fa-clock-o icon-end-time"></i>
                                    <span>End time: {{:~getDate(endDate_dt)}}</span>
                                </p>
                                <div class="clearfix content-popular-icons">
                                    <p class="pull-left">
                                    <i class="fa fa-eye"></i>
                                    <span>{{:viewCount}}</span>
                                    </p>
                                    <p class="pull-left">
                                        <i class="fa fa-thumbs-o-up"></i>
                                        <span>{{:likeCount}}</span>
                                    </p>
                                    <p class="pull-left">
                                        <i class="fa fa-thumbs-o-down"></i>
                                        <span>{{:dislikeCount}}</span>
                                    </p>
                                </div>
                                
                            </div>
                            <div class="post-summary">
                                <p>{{:summary_s}}</p>
                            </div>
                        </div>
                    </div>
                    
                    {{else type == 'video'}}
                        <div class="post thumb-border">
                        <div class="post-thumb">
                            <img src="{{:thumbnail}}">
                            <a href="{{:~videoUrl(id)}}" class="hover-posts">
                                <span><i class="fa fa-play-circle icon-circle"></i></span>
                            </a>
                        </div>
                        <div class="post-des">
                            <h6><a href="{{:~videoUrl(id)}}">{{:title_s}}</a></h6>
                            <div class="post-stats clearfix content-popular-icons">
                                <p class="">
                                    <i class="fa fa-clock-o"></i>
                                    <span>{{:~getDate(date_dt)}}</span>
                                </p>
                                <p class="pull-left">
                                    <i class="fa fa-eye"></i>
                                    <span>{{:viewCount}}</span>
                                </p>
                                <p class="pull-left">
                                    <i class="fa fa-thumbs-o-up"></i>
                                    <span>{{:likeCount}}</span>
                                </p>
                                <p class="pull-left">
                                    <i class="fa fa-thumbs-o-down"></i>
                                    <span>{{:dislikeCount}}</span>
                                </p>
                            </div>
                            <div class="post-summary">
                                <p>{{:summary_s}}</p>
                            </div>
                        </div>
                    </div>
  
                {{/if}}
                </div>
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
            jQuery('.tabs-content .item').matchHeight();
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
        videoUrl: function(id) {
            return '${contentModel.videoLandingUrl}?id=' + id;
        },
		getDate: function (date) {
            return getDate(date);
		},
		getStreamUrl: function(id){
			return "/live?id="+id
		}
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