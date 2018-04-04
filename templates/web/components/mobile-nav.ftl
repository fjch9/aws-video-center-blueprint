<#import "/templates/web/lib/macros.ftl" as macros />

<div class="off-canvas position-left light-off-menu" id="offCanvas-responsive" data-off-canvas>
    <div class="off-menu-close">
        <h3>${contentModel.title}</h3>
        <span data-toggle="offCanvas-responsive"><i class="fa fa-times"></i></span>
    </div>
    <ul class="vertical menu off-menu" data-responsive-menu="drilldown">
        <@macros.menuItems navItems = navTreeBuilder.getNavTree("/site/website", 3, contentModel.storeUrl) sidebar = true />
    </ul>

    <div class="responsive-search">
        <form method="get" action="/search">
            <div class="input-group">
                <input class="input-group-field" type="text" name="q" placeholder="${model.searchPlaceholder}">
                <div class="input-group-button">
                    <button type="submit"><i class="fa fa-search"></i></button>
                </div>
            </div>
        </form>
    </div>

    <@macros.topButtons sidebar = true />
</div>
