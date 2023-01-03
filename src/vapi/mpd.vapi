[CCode (cprefix = "mpd_", cheader_filename = "mpd/mpd.h")]
namespace Mpd {
  [CCode (cname = "enum mpd_error")]
  public enum Error {
    SUCCESS = 0,
    OOM,
    ARGUMENT,
    STATE,
    TIMEOUT,
    SYSTEM,
    RESOLVER,
    MALFORMED,
    CLOSED,
    SERVER
  }

  [CCode (cname = "enum mpd_async_event")]
  public enum AsyncEvent {
    READ = 1 ,
    WRITE = 2,
    HUP = 4,
    ERROR = 8
  }
}