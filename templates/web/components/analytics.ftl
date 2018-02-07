<#-- TODO: Disable in preview
<#if contentModel.trackingId?? && contentModel.trackingId != "" >
var video = jQuery("video");
var title = "${video.title_s}";
var category = 'video_tracking';
var duration = 0;
var paused = false;
var started = false;
var lastProgress = 0;

function recordProgress(percentage) {
    gtag('event', 'video_progress_' + percentage, {
        'event_category': category,
        'event_label': title,
        'non_interaction': true
    });
}

gtag('event', 'video_accessed', {
    'event_category': category,
    'event_label': title,
    'non_interaction': true
});

video.on('loadedmetadata', function() {
    duration = Math.round(video[0].duration);
});

video.on('playing', function() {
    if(!paused && !started) {
        gtag('event', 'video_viewed', {
            'event_category': category,
            'event_label': title,
            'non_interaction': true
        });
        started = true;
    }
});

video.on('pause', function() {
    paused = true;
});

video.on('ended', function() {
    recordProgress(100);
});

video.on('timeupdate', function() {
    var currentTime = Math.round(video[0].currentTime);
    var percentage = Math.round(currentTime / duration * 100);
    if(percentage != lastProgress && percentage == 25 || percentage == 50 || percentage == 75) {
        recordProgress(percentage);
        lastProgress = percentage;
    }
});
</#if> -->