/* 
 *  MIT License
 *  
 *  Copyright (C) 2018-2020 Crafter Software Corporation. All Rights Reserved.
 *  
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *  
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

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
