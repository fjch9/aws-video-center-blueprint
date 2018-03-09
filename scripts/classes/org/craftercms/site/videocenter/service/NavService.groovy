package org.craftercms.site.videocenter.utils

class NavService {
  
  def urlTransformationService
  def siteItemService
  
  def getNavIcon(item) {
    def storeUrl = urlTransformationService.transform("renderUrlToStoreUrl", item.url)
    def siteItem = siteItemService.getSiteItem(storeUrl)
    if(siteItem) {
      def navIcon = siteItem.navIcon?.text
      if(navIcon) {
        return navIcon
      }
    }
    return "fa-file-o"
  }
  
}
