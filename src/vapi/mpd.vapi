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

  [CCode (cname = "enum mpd_entity_type")]
  public enum EntityType {
    UNKNOWN,
    DIRECTORY,
    SONG,
    PLAYLIST
  }

  [CCode (cname = "enum mpd_fingerprint_type")]
  public enum FingerprintType {
    UNKNOWN,
    CHROMAPRINT
  }

  [CCode (cname = "enum mpd_idle")]
  public enum Idle {
    DATABASE = 0x1,
    STORED_PLAYLIST = 0x2,
    QUEUE = 0x4,
    PLAYLIST = QUEUE,
    PLAYER = 0x8,
    MIXER = 0x10,
    OUTPUT = 0x20,
    OPTIONS = 0x40,
    UPDATE = 0x80,
    STICKER = 0x100,
    SUBSCRIPTION = 0x200,
    MESSAGE = 0x400,
    PARTITION = 0x800,
    NEIGHBOR = 0x1000,
    MOUNT = 0x2000,
  }

  [CCode (cname = "enum mpd_parser_result")]
  public enum ParserResult {
    MALFORMED,
    SUCCESS,
    ERROR,
    PAIR
  }

  [CCode (cname = "enum mpd_server_error")]
  public enum ServerError {
    UNK = -1,
    NOT_LIST = 1,
    ARG = 2,
    PASSWORD = 3,
    PERMISSION = 4,
    UNKNOWN_CMD = 5,
    NO_EXIST = 50,
    PLAYLIST_MAX = 51,
    SYSTEM = 52,
    PLAYLIST_LOAD = 53,
    UPDATE_ALREADY = 54,
    PLAYER_SYNC = 55,
    EXIST = 56
  }

  [CCode (cname = "enum mpd_replay_gain_mode")]
  public enum ReplayGainMode {
    OFF = 0,
    TRACK,
    ALBUM,
    AUTO,
    UNKNOWN
  }

  [CCode (cname = "enum mpd_operator")]
  public enum Operator {
    DEFAULT
  }

  [CCode (cname = "enum mpd_state")]
  public enum State {
    UNKNOWN = 0,
    STOP = 1,
    PLAY = 2,
    PAUSE = 3
  }

  [CCode (cname = "enum mpd_single_state")]
  public enum SingleState {
    OFF = 0,
    ON,
    ONESHOT,
    UNKNOWN
  }

  [CCode (cname = "enum mpd_tag_type", cprefix = "MPD_TAG_")]
  public enum TagType {
    UNKNOWN = -1,
    ARTIST,
    ALBUM,
    ALBUM_ARTIST,
    TITLE,
    TRACK,
    NAME,
    GENRE,
    DATE,
    COMPOSER,
    PERFORMER,
    COMMENT,
    DISC,
    MUSICBRAINZ_ARTISTID,
    MUSICBRAINZ_ALBUMID,
    MUSICBRAINZ_ALBUMARTISTID,
    MUSICBRAINZ_TRACKID,
    MUSICBRAINZ_RELEASETRACKID,
    ORIGINAL_DATE,
    ARTIST_SORT,
    ALBUM_ARTIST_SORT,
    ALBUM_SORT,
    LABEL,
    MUSICBRAINZ_WORKID,
    GROUPING,
    WORK,
    CONDUCTOR,
    COUNT
  }
}