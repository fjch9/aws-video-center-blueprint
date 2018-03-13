package org.craftercms.site.videocenter.utils

import java.text.SimpleDateFormat
import java.util.TimeZone

class DateUtils {

	private static def SHORT_DISPLAY_DATE_FORMAT = "MM/dd/yy"
  private static def ISO_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ssZ"

	private DateUtils() {

	}

	static def toShortDisplayDate(date) {
		def outputDateFormat = new SimpleDateFormat(SHORT_DISPLAY_DATE_FORMAT)

		def outputDate = outputDateFormat.format(date)

		return outputDate
	}

  static def toIsoString(date) {
    date.format(ISO_DATE_FORMAT, TimeZone.getTimeZone("UTC"))
  }

}
