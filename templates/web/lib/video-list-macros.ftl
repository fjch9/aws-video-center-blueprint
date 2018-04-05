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