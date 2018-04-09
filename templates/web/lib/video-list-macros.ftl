<#macro heading id title subtext='' layout='grid-medium' icon='fa-film'>
    <div class="main-heading">
        <div class="row padding-14">
            <div class="medium-8 columns small-12 header-container-wrapper">
                <div class="head-container borderBottom">
                    <div class="head-title">
                        <i class="fa ${icon}"></i>
                        <h4>${title}</h4>
                    </div>
                    <div class="column head-text clearfix">
                        <p class="pull-left"><span><#if subtext?has_content>:&nbsp;&nbsp;</#if>${subtext}</span></p>
                        <div class="grid-system pull-right show-for-large" data-id="${id}">
                            <a class="secondary-button grid-default <#if layout == 'grid-default'>current</#if>" href="#" data-class="grid-default"><i class="fa fa-th"></i></a>
                            <a class="secondary-button grid-medium <#if layout == 'grid-medium'>current</#if>" href="#" data-class="grid-medium"><i class="fa fa-th-large"></i></a>
                            <a class="secondary-button list <#if layout == 'list'>current</#if>" href="#" data-class="list"><i class="fa fa-th-list"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</#macro>

<#macro videoThumbnail id thumbnail title baseUrl>
    <img src="${thumbnail}" alt="${title}">
    <a href="${baseUrl}${id}" class="hover-posts">
        <span><i class="fa fa-play-circle icon-circle"></i></span>
    </a>
</#macro>

<#macro videoTitle id title baseUrl>
    <h6 class='video-title'><a href="${baseUrl}${id}">${title}</a></h6>
</#macro>

<#macro videoDate date>
    <i class="fa fa-clock-o"></i>
    <span>${date}</span>
</#macro>

<#macro videoViews viewCount>
    <i class="fa fa-eye"></i>
    <span class="view-count">${viewCount}</span>
</#macro>

<#macro videoSummary summary>
    <p class='video-summary'>${summary}</p>
</#macro>

<#macro video id thumbnail title summary date viewCount likeCount dislikeCount parentId baseUrl gridStyle='grid-medium'>
    <div class="item large-4 medium-6 columns ${gridStyle}">
        <div class="post thumb-border" data-mh="${parentId}">
            <div class="post-thumb">
                <@videoThumbnail id=id thumbnail=thumbnail title=title baseUrl=baseUrl />
            </div>
            <div class="post-des">
                <@videoTitle id=id title=title baseUrl=baseUrl />
                <div class="post-stats clearfix">
                    <p class="pull-left">
                        <@videoDate date=date />
                    </p>
                    <p class="pull-left">
                        <@videoViews viewCount=viewCount />
                    </p>
                    <p class="pull-left">
                        <i class="fa fa-thumbs-o-up"></i>
                        <span class="like-count">${likeCount}</span>
                    </p>
                    <p class="pull-left">
                        <i class="fa fa-thumbs-o-down"></i>
                        <span class="dislike-count">${dislikeCount}</span>
                    </p>
                </div>
                <div class="post-summary">
                    <@videoSummary summary=summary />
                </div>
            </div>
        </div>
    </div>
</#macro>