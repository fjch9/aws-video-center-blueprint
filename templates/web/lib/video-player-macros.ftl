<#macro header>
    <#assign inverted = false>
    <div class="off-canvas-wrapper">
        <div class="off-canvas-wrapper-inner" data-off-canvas-wrapper>
            <@renderComponent component = contentModel.mobileNavigation.item />
            <div class="off-canvas-content" data-off-canvas-content>
                <@renderComponent component = contentModel.header.item additionalModel = { 'currentPage' : model.storeUrl, 'backLink' : model.backLink } />

                <@macros.breadcrumb addMargin = false />
</#macro>

<#macro startVideoSection>
    <div class="row">
        <!-- left side content area -->
        <div class="large-8 columns">
            <!-- single post stats -->
            <section class="SinglePostStats">
                <!-- newest video -->
                <div class="row secBg">
                    <div class="large-12 columns">
                        <div class="media-object stack-for-small">
                            <div class="media-object-section object-second">
                                <div class="author-des clearfix" style="border-bottom: 0">
                                    <div class="post-title">
                                        <h3>${video.title_s}</h3>
                                        <p>
</#macro>

<#macro endVideoSection>
                                        </p>
                                    </div>
                                </div>
                                <#if profile??>
                                <div class="social-share">
                                    <div class="post-like-btn clearfix">
                                        <a href="#" id="fav-button" class="button tiny <#if isFavorite>alert</#if>"><i class="fa fa-heart"></i></a>
                                        <a href="#" id="like-button" class="button tiny <#if isLiked>alert</#if>"><i class="fa fa-thumbs-o-up"></i></a>
                                        <a href="#" id="dislike-button" class="button tiny <#if isDisliked>alert</#if>"><i class="fa fa-thumbs-o-down"></i></a>
                                    </div>
                                </div>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>
            </section><!-- End single post stats -->

            <!-- single post description -->
            <section class="singlePostDescription">
                <div class="row secBg">
                    <div class="large-12 columns">
                        <div class="heading">
                            <h5>Description</h5>
                        </div>
                        <div class="description showmore_one">
                            ${video.description_html}

                            <#if video.categories?? && video.categories.item?? && (video.categories.item?size >= 0)>
                            <div class="categories">
                                <button><i class="fa fa-folder"></i>Categories</button>
                                <#list video.categories.item as category>
                                <a href="/category?id=${category.key}" class="inner-btn">${category.value_smv}</a>
                                </#list>
                            </div>
                            </#if>
                            <#if video.tags?? && video.tags.item?? && (video.tags.item?size >= 0)>
                            <div class="tags">
                                <button><i class="fa fa-tags"></i>Tags</button>
                                <#list video.tags.item as tag>
                                <a href="/tag?id=${tag.value_smv}" class="inner-btn">${tag.value_smv}</a>
                                </#list>
                            </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </section><!-- End single post description -->
            
            <!-- related Posts -->
            <section class="content content-with-sidebar related">
                <div class="row secBg">
                    <div class="large-12 columns">
                        <div class="main-heading borderBottom">
                            <div class="row padding-14">
                                <div class="medium-12 small-12 columns">
                                    <div class="head-title">
                                        <i class="fa fa-film"></i>
                                        <h4>Related Videos</h4>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row list-group">
                            <#list relatedVideos as relatedVideo>
                            <#assign relatedVideoUrl = "${request.requestURI}?id=${relatedVideo.id}" />
                            <div class="item large-4 columns <#if relatedVideo?is_last>end</#if> group-item-grid-default" data-mh="related-videos">
                                <div class="post thumb-border">
                                    <div class="post-thumb">
                                        <img src="${relatedVideo.thumbnail}">
                                        <a href="${relatedVideoUrl}" class="hover-posts">
                                            <span><i class="fa fa-play-circle"></i></span>
                                        </a>
                                    </div>
                                    <div class="post-des">
                                        <h6><a href="#">${relatedVideo.title_s}</a></h6>
                                        <div class="post-stats clearfix">
                                            <p class="pull-left">
                                                <i class="fa fa-eye"></i>
                                                <span>${relatedVideo.viewCount}</span>
                                            </p>
                                            <p class="pull-left">
                                                <i class="fa fa-thumbs-o-up"></i>
                                                <span>${relatedVideo.likeCount}</span>
                                            </p>
                                            <p class="pull-left">
                                                <i class="fa fa-thumbs-o-down"></i>
                                                <span>${relatedVideo.dislikeCount}</span>
                                            </p>
                                        </div>
                                        <div class="post-summary">
                                            <p>${relatedVideo.summary_s}</p>
                                        </div>
                                        <div class="post-button">
                                            <a href="${relatedVideoUrl}" class="secondary-button"><i class="fa fa-play-circle"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </#list>
                        </div>
                    </div>
                </div>
            </section><!--end related posts-->

        </div><!-- end left side content area -->
        <@renderComponent component = contentModel.rightRail.item />
    </div>
</#macro>

<#macro footer>
            <@renderComponent component = contentModel.footer.item />
        </div><!--end off canvas content-->
    </div><!--end off canvas wrapper inner-->
</div><!--end off canvas wrapper-->
<!-- script files -->
<#include "/templates/web/components/scripts.ftl" />
<script>
    jQuery(document).ready(function() {
        var actionsMap = {
            "fav-button": "favorite",
            "like-button": "like",
            "dislike-button": "dislike"
        }
        
        jQuery(".social-share .post-like-btn a").on("click", function(e){

            e.preventDefault(); 
        
            var element = e.target.id ? e.target : e.target.parentElement,
                id = jQuery(element).attr("id"),
                url = "/api/1/profile/toggle/" + actionsMap[id] + ".json";
        
            jQuery.get(url, { id: "${requestParameters["id"]}" }, function(res) {
                if("fav-button" === id){
                    jQuery(element).toggleClass("alert");   
                }else{
                    jQuery('.social-share .post-like-btn a:not("#fav-button, #' + id + '")').removeClass('alert primary');
                    jQuery(element).toggleClass("alert");   
                }
            });
        })
        
        <#include "/templates/web/components/analytics.ftl"/>
    });
</script>
<@studio.toolSupport />
</#macro>