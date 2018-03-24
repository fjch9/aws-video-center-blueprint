<#assign navItems = navTreeBuilder.getNavTree("/site/website", 3, contentModel.storeUrl) />
<div class="off-canvas position-left light-off-menu" id="offCanvas-responsive" data-off-canvas>
    <div class="off-menu-close">
        <h3>${contentModel.title}</h3>
        <span data-toggle="offCanvas-responsive"><i class="fa fa-times"></i></span>
    </div>
    <ul class="vertical menu off-menu" data-responsive-menu="drilldown">
        <li>
          <a href="${navItems.url}"><i class="fa ${navService.getNavIcon(navItems)}"></i>${navItems.label}</a>
        </li>
        <#list navItems.subItems as item>
        <li <#if item.subItems?has_content>class="has-submenu"</#if>>
            <a href="${item.url}"><i class="fa ${navService.getNavIcon(item)}"></i>${item.label}</a>
            <#if item.subItems?has_content>
            <ul class="submenu menu vertical" data-submenu data-animate="slide-in-down slide-out-up">
                <#list item.subItems as child>
                <li><a href="${child.url}"><i class="fa ${navService.getNavIcon(child)}"></i>${child.label}</a></li>
                </#list>
            </ul>
            </#if>
        </li>
        </#list>
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
    <div class="off-social">
        <h6>Get Socialize</h6>
        <@renderComponent component = contentModel.socialMediaLinks.item />
    </div>
    <div class="top-button">
        <ul class="menu">
            <#if !profile??>
            <li>
                <a href="/register">Register</a>
            </li>
            <li class="dropdown-login">
                <a href="/login">Login</a>
            </li>
            <#else>
            <li>
                <a href="/account">My Profile</a>
            </li>
            <li>
                <a href="/crafter-security-logout">Logout</a>
            </li>
            </#if>
        </ul>
    </div>
</div>
