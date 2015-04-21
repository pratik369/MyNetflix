<%@page import="java.io.*, java.util.*, video.*, com.amazonaws.services.s3.*,com.amazonaws.services.s3.model.*,com.amazonaws.auth.* "%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" async="" src="./itube_files/ga.js"></script>
<script type="text/javascript" async="" src="./itube_files/ga.js"></script>
<script id="js-203444223" src="./itube_files/www-searchbox-vfl0q4fjj.js" data-loaded="true"></script>   
<script type="text/javascript" src="jwplayer/jwplayer.js"></script>
<script type="text/javascript" src="/jwplayer/jwplayer.js" ></script>
<script type="text/javascript">jwplayer.key="HJcUlk9K9ebkqO2wO9HHSVgmaUaGY+dz43maVg==";</script>
<script type="text/javascript" src="/jwplayer/jwplayer.js" ></script>
<script type="text/javascript">jwplayer.key="HJcUlk9K9ebkqO2wO9HHSVgmaUaGY+dz43maVg==";</script>
<script type="text/javascript" src="jwplayer/jwplayer.js"></script>
<script type="text/javascript" src="/jwplayer/jwplayer.js" ></script>
<script type="text/javascript">jwplayer.key="HJcUlk9K9ebkqO2wO9HHSVgmaUaGY+dz43maVg==";</script>
<script type='text/javascript' src='https://dfp2a7pqd4vvb.cloudfront.net/jwplayer.js'></script>	
<script type="text/javascript" src="jwplayer/jwplayer.js"></script>
 <script>
var yt = yt || {};yt.timing = yt.timing || {};yt.timing.data_ = yt.timing.data_ || {};yt.timing.tick = function(label, opt_time) {var timer = yt.timing.data_['timer'] || {};if(opt_time) {timer[label] = opt_time;}else {timer[label] = new Date().getTime();}yt.timing.data_['timer'] = timer;};yt.timing.info = function(label, value) {var info_args = yt.timing.data_['info_args'] || {};info_args[label] = value;yt.timing.data_['info_args'] = info_args;};yt.timing.info('e', "906372,914053,916624,922401,920704,912806,925703,925706,928001,922403,922405,929901,913605,913546,913556,908493,920201,911116,901451,902556");if (document.webkitVisibilityState == 'prerender') {document.addEventListener('webkitvisibilitychange', function() {yt.timing.tick('start');}, false);}yt.timing.tick('start');yt.timing.info('li','0');try {yt.timing.data_['srt'] = window.gtbExternal && window.gtbExternal.pageT() ||window.external && window.external.pageT;} catch(e) {}if (window.chrome && window.chrome.csi) {yt.timing.data_['srt'] = Math.floor(window.chrome.csi().pageT);}if (window.msPerformance && window.msPerformance.timing) {yt.timing.data_['srt'] = window.msPerformance.timing.responseStart - window.msPerformance.timing.navigationStart;}    </script>
<title>AWSYoutube Assignment 2</title>


<form action="UploadServlet" method="post" enctype="multipart/form-data">

Upload New Videos:
<br>
<input type="file" name="file" size="50" >
<input type="submit" value="Upload File" />
</form>

<div id="watch7-video-container">

      <div >
   

              <br><br><br>
            Click the PLAY button to open video in new tab...
   
        
      </div>
    </div>

    <div id="watch7-main-container">
      <div id="watch7-main" class="clearfix">
        <div id="watch7-content">
            <div class="yt-uix-button-panel">
      <div id="watch7-headline" class="clearfix  yt-uix-expander yt-uix-expander-collapsed">
    <h1 id="watch-headline-title">
      
<script type="text/javascript">

jwplayer('mediaplayer').setup({
	
	file: "mp4:video1",
	width: 620,
    height: 430,
    allowfullscreen: true,
    title: "Welcome Video",
    image: "/utube_files/video_pic.png",
    modes: [
	        {type: "flash", src: "https://dmn4h8l5jctja.cloudfront.net/jwplayer.swf"},
	        {type: "html5", config: {image: "/utube_files/video_pic.png",provider: "video"}}
	       ],
    provider: "rtmp",
	streamer: "rtmp://s2izyfibhbqr1b.cloudfront.net/cfx/st",
	
	listbar : {
    	position: 'bottom',
    	size:85
    },
	autostart: false
	
});
function addVideo(videoUrl, videoThumb, videoTitle) 
{
    var playlist = jwplayer().getPlaylist();
    var newItem = {
        file: videoUrl,
        image: videoThumb,
        title: videoTitle
    };
    playlist.push(newItem);
    jwplayer().load(playlist);
    jwplayer().play();
}
</script>
</h1>
      List of the Videos in your S3 Bucket <br><hr><br>
      <table margin-right=50px>    
<% 
String p ="https://s3.amazonaws.com/";
LinkedList<String> l = new S3Instance(true).getAllVideoNames();
String bucket_name = S3Instance.bucket_name;
for(int i1 =0 ;i1<l.size();i1++)
{
	String url =p + bucket_name+"/"+ l.get(i1).replace(" ","+");
%>
		<td border-spacing="10px" id="watch-more-related-loading">	
	     	<%=l.get(i1) %>
	     	<% System.out.println(url); %>
				<button type="button" value="text" onclick="window.open('<%=url %>')"> &#160;&#160; Play</button>
	    </td>      
	</tr> 
          <%
}
%>

</table>
</body></html>