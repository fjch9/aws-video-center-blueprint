var countdown = function(startTime, countdownId, useApproximate, approximationEnd) {
    new CountDownTimer({
        startTime: startTime,
        element: document.getElementById(countdownId),
        complete: function(){ 
            setTimeout(function(){location.reload();}, 500); 
        },
        approximation: useApproximate,
        approximationEnd: approximationEnd
    });
}

var playStream = function(videoElementId, videoSource, loadingImageId, unsupportedMessageId) {
    var video = document.getElementById(videoElementId);

    if (Hls.isSupported()) {
        var hls = new Hls();
        hls.attachMedia(video);
        // MEDIA_ATTACHED event is fired by hls object once MediaSource is ready
        hls.on(Hls.Events.MEDIA_ATTACHED, function () {            
                hls.loadSource(videoSource);
                hls.on(Hls.Events.MANIFEST_PARSED, function (event, data) {
            });
        });
    } else if(video.canPlayType('application/vnd.apple.mpegurl')) {
        //some devices, like iphone, can support HLS natively even if the HLS JS library is not supported
        video.src = videoSource;
    } else {
        //no playback options available, show error message
        jQuery('#'+loadingImageId).addClass('hide');
        jQuery('#'+unsupportedMessageId).removeClass('hide');
    }

    video.oncanplay = function() {
        jQuery('#'+loadingImageId).addClass('hide');
        jQuery('#'+videoElementId).removeClass('hide');
        video.muted = video.muted;
        video.autoplay = true;
        video.play();
    };
}