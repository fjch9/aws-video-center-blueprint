package org.craftercms.site.videocenter.service

class TagsService {
  
  def searchService
  
  def searchAllTags() {
    def query = searchService.createQuery()
    query.query = 'content-type:"/component/video"'
    query.fieldsToReturn = [ "tags.item.value_smv" ] as String[]
    query.setParam("facet", "on")
    query.setParam("facet.field", "tags.item.value_smv")
    query.setParam("facet.mincount", "1")
    
    def results = searchService.search(query)
    
    return results.facet_counts.facet_fields["tags.item.value_smv"]
  }
  
}
