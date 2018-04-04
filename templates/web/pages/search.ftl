<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/web/lib/macros.ftl" as macros />

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
                            <!-- newest video -->
                            <div class="main-heading removeMargin">
                                <div class="row secBg padding-14 removeBorderBottom">
                                    <div class="medium-8 small-12 columns">
                                        <div class="head-title">
                                            <i class="fa fa-search"></i>
                                            <h4>Search Results for "${userQuery}"</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="results" class="row secBg">
                            </div>
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
    <div class="large-12 columns">
        <div class="row column head-text clearfix">
            <p class="pull-left">Search Results :<span> {{:total}} matching ${userQuery} found</span></p>
            <div class="grid-system pull-right show-for-large">
                <a class="secondary-button grid-default {{if layout == 'grid-default'}}current{{/if}}" href="#" data-class="grid-default"><i class="fa fa-th"></i></a>
                <a class="secondary-button grid-medium {{if layout == 'grid-medium'}}current{{/if}}" href="#" data-class="grid-medium"><i class="fa fa-th-large"></i></a>
                <a class="secondary-button list {{if layout == 'list'}}current{{/if}}" href="#" data-class="list"><i class="fa fa-th-list"></i></a>
            </div>
        </div>
        <div class="tabs-content" data-tabs-content="newVideos">
            <div class="tabs-panel is-active" id="new-all">
                <div class="row list-group">
                    {{for items ~size=items.length}}
                    <div class="item large-4 medium-6 {{if #index + 1 == ~size}}end{{/if}} columns {{:~root.layout}}">
                    
                    {{if type == 'stream'}}
                    
                    <div class="post thumb-border">
                            <div class="post-thumb">
                                <img src="{{:thumbnail}}" alt="new video">
                                <div class="tag-live {{if liveNow == false}}hide{{/if}}">
                                    <figcaption>
                                        <p class="live-text">Live</p>
                                    </figcaption>
                                </div>
                                <a href="{{:~getStreamUrl(id)}}}" class="hover-posts">
                                    <span><i class="fa fa-play-circle icon-circle"></i></span>
                                </a>
                            </div>
                            <div class="post-des">
                                <h6><a href="{{:~getStreamUrl(id)}}}">{{:title_s}}</a></h6>
                                <div class="post-stats clearfix">
                                    <p class="clearfix content-popular-icons">
                                        <i class="fa fa-clock-o icon-start-time"></i>
                                        <span>Start time: {{:~getDate(startDate_dt)}}</span>
                                        <br>
                                        <i class="fa fa-clock-o icon-end-time"></i>
                                        <span>End time: {{:~getDate(endDate_dt)}}</span>
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
                                <div class="post-button">
                                    <a href="{{:~videoUrl(id)}}" class="secondary-button"><i class="fa fa-play-circle"></i>watch</a>
                                </div>
                            </div>
                        </div>
                    
                    {{else type == 'video'}}
                        <div class="post thumb-border">
                            <div class="post-thumb">
                                <img src="{{:thumbnail}}" alt="new video">
                                <a href="{{:~videoUrl(id)}}" class="hover-posts">
                                    <span><i class="fa fa-play-circle icon-circle"></i></span>
                                </a>
                            </div>
                            <div class="post-des">
                                <h6><a href="{{:~videoUrl(id)}}">{{:title_s}}</a></h6>
                                <div class="post-stats clearfix">
                                    <p class="clearfix content-popular-icons">
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
                                <div class="post-button">
                                    <a href="{{:~videoUrl(id)}}" class="secondary-button"><i class="fa fa-play-circle"></i>watch</a>
                                </div>
                            </div>
                        </div>

                    
                    {{/if}}
                    </div>
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
    var layout = "list";

    function loadResults(params) {
        jQuery.get('/api/1/search.json', params, function(res){
            res.layout = layout;

            jQuery('#results').html(jQuery.templates('#resultsTemplate').render(res));

            jQuery('.tabs-content .item').matchHeight();
        });
    }

    jQuery.views.helpers({
        videoUrl: function(id) {
            return '${contentModel.videoLandingURL}?id=' + id;
        },
        getDate: function (date) {
             var formatedStartDate = moment(date);
             var currentTimeZone = new Date(formatedStartDate).toString().match(/\(([A-Za-z\s].*)\)/)[1];
            return formatedStartDate.format('lll')+" "+currentTimeZone
        },
        getStreamUrl: function(id){
            return "/live?id="+id
        }
    });

    jQuery(document).ready(function(){
        loadResults({
            q: '${q}',
            start: ${start},
            rows: ${rows}
        });

        jQuery(document).on('click', '#btn-load-more', function(){
            times++;
            layout = jQuery(".grid-system > .current").data('class');

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