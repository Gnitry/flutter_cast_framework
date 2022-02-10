import 'package:flutter_cast_framework/cast.dart';

/// in seconds
const double QUEUE_PRELOAD_TIME = 20;

const mainVideo = const VideoInfo(
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/mp4/BigBuckBunny.mp4",
  "mp4",
  596 * 1000,
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/images/480x270/BigBuckBunny.jpg",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/images/780x1200/BigBuckBunny-780x1200.jpg",
);

const List<VideoInfo> otherVideos = [
  const VideoInfo(
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/mp4/ElephantsDream.mp4",
    "mp4",
    653 * 1000,
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/images/480x270/ElephantsDream.jpg",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/images/780x1200/ElephantsDream-780x1200.jpg",
  ),
  const VideoInfo(
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/mp4/Sintel.mp4",
    "mp4",
    888 * 1000,
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/images/480x270/Sintel.jpg",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/images/780x1200/Sintel-780x1200.jpg",
  ),
  const VideoInfo(
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/mp4/TearsOfSteel.mp4",
    "mp4",
    734 * 1000,
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/images/480x270/TearsOfSteel.jpg",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/images/780x1200/TearsOfSteel-780x1200.jpg",
  ),
];

class VideoInfo {
  const VideoInfo(
    this.url,
    this.type,
    this.duration,
    this.thumb,
    this.poster,
  );

  final String url;
  final String type;
  final int duration;
  final String thumb;
  final String poster;
}

MediaLoadRequestData getMediaLoadRequestData(VideoInfo video) {
  final mediaInfo = _getMediaInfo(video);

  final request = MediaLoadRequestData()
    ..shouldAutoplay = true
    ..currentTime = 0
    ..mediaInfo = mediaInfo;

  return request;
}

MediaQueueItem getMediaQueueItem(VideoInfo video) {
  final mediaInfo = _getMediaInfo(video);

  final request = MediaQueueItem()
    ..media = mediaInfo
    ..autoplay = false
    ..preloadTime = QUEUE_PRELOAD_TIME;

  return request;
}

MediaInfo _getMediaInfo(VideoInfo video) {
  final img = WebImage()..url = video.thumb;
  final bigImg = WebImage()..url = video.poster;
  final mediaMetadata = MediaMetadata()
    ..mediaType = MediaType.movie
    ..webImages = [
      img,
      bigImg,
    ];

  // final mediaTrack = MediaTrack()
  //   ..contentId = ""
  //   ..id = 0
  //   ..language = ""
  //   ..name = ""
  //   ..trackType = TrackType.unknown
  //   ..trackSubtype = TrackSubtype.unknown;
  // final mediaTracks = <MediaTrack>[mediaTrack];

  final mediaInfo = MediaInfo()
    ..contentId = video.url
    ..streamType = StreamType.buffered
    ..contentType = video.type
    ..mediaMetadata = mediaMetadata
    ..mediaTracks = <MediaTrack>[]
    ..streamDuration = video.duration;

  return mediaInfo;
}
