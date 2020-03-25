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

var countdown=function(startTime,countdownId,useApproximate,approximationEnd){new CountDownTimer({startTime:startTime,element:document.getElementById(countdownId),complete:function(){setTimeout(function(){location.reload()},500)},approximation:useApproximate,approximationEnd:approximationEnd})}
var playStream=function(videoElementId,videoSource,loadingImageId,unsupportedMessageId){var video=document.getElementById(videoElementId);if(Hls.isSupported()){var hls=new Hls();hls.attachMedia(video);hls.on(Hls.Events.MEDIA_ATTACHED,function(){hls.loadSource(videoSource);hls.on(Hls.Events.MANIFEST_PARSED,function(event,data){})})}else if(video.canPlayType('application/vnd.apple.mpegurl')){video.src=videoSource}else{jQuery('#'+loadingImageId).addClass('hide');jQuery('#'+unsupportedMessageId).removeClass('hide')}
video.oncanplay=function(){jQuery('#'+loadingImageId).addClass('hide');jQuery('#'+videoElementId).removeClass('hide');video.muted=video.muted;video.autoplay=!0;video.play()}}
