package org.craftercms.site.videocenter.utils

import java.text.SimpleDateFormat
import java.util.TimeZone

class DateUtils {

	private static def SHORT_DISPLAY_DATE_FORMAT = "MM/dd/yy"

	private DateUtils() {

	}

	static def toShortDisplayDate(date) {
		def outputDateFormat = new SimpleDateFormat(SHORT_DISPLAY_DATE_FORMAT)

		def outputDate = outputDateFormat.format(date)

		return outputDate
	}

}
