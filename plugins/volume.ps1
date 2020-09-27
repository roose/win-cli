# Usage: win volume [ 0-100 | up | down | mute | unmute | ismute ]
# Summary: Set or change or mute volume
# Help:
#   win volume 70       # set the volume to 70 %
#   win volume up       # increase the volume by 6
#   win volume down     # decrease the volume by 6
#   win volume          # get the volume level
#   win volume mute     # set mute
#   win volume unmute   # unset mute
#   win volume ismute   # check the volume status"
param($cmd)

Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
[Guid("5CDF2C82-841E-4546-9722-0CF74078229A"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IAudioEndpointVolume {
  // f(), g(), ... are unused COM method slots. Define these if you care
  int f(); int g(); int h(); int i();
  int SetMasterVolumeLevelScalar(float fLevel, System.Guid pguidEventContext);
  int j();
  int GetMasterVolumeLevelScalar(out float pfLevel);
  int k(); int l(); int m(); int n();
  int SetMute([MarshalAs(UnmanagedType.Bool)] bool bMute, System.Guid pguidEventContext);
  int GetMute(out bool pbMute);
}
[Guid("D666063F-1587-4E43-81F1-B948E807363F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDevice {
  int Activate(ref System.Guid id, int clsCtx, int activationParams, out IAudioEndpointVolume aev);
}
[Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDeviceEnumerator {
  int f(); // Unused
  int GetDefaultAudioEndpoint(int dataFlow, int role, out IMMDevice endpoint);
}
[ComImport, Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")] class MMDeviceEnumeratorComObject { }
public class Audio {
  static IAudioEndpointVolume Vol() {
    var enumerator = new MMDeviceEnumeratorComObject() as IMMDeviceEnumerator;
    IMMDevice dev = null;
    Marshal.ThrowExceptionForHR(enumerator.GetDefaultAudioEndpoint(/*eRender*/ 0, /*eMultimedia*/ 1, out dev));
    IAudioEndpointVolume epv = null;
    var epvid = typeof(IAudioEndpointVolume).GUID;
    Marshal.ThrowExceptionForHR(dev.Activate(ref epvid, /*CLSCTX_ALL*/ 23, 0, out epv));
    return epv;
  }
  public static float Volume {
    get {float v = -1; Marshal.ThrowExceptionForHR(Vol().GetMasterVolumeLevelScalar(out v)); return v;}
    set {Marshal.ThrowExceptionForHR(Vol().SetMasterVolumeLevelScalar(value, System.Guid.Empty));}
  }
  public static bool Mute {
    get { bool mute; Marshal.ThrowExceptionForHR(Vol().GetMute(out mute)); return mute; }
    set { Marshal.ThrowExceptionForHR(Vol().SetMute(value, System.Guid.Empty)); }
  }
}
'@

function help {
  echo "
  usage: win volume [ level(0-100) | up | down | mute | unmute | ismute ]
  Examples:
    win volume 70     # set the volume to 70 %
    win volume +5     # increase the volume by 5 (up to 100)
    win volume -10    # decrease the volume by 10 (down to 0)
    win volume up     # increase the volume by 6.25
    win volume down   # decrease the volume by 6.25
    win volume        # get the volume level
    win volume mute   # set mute
    win volume unmute # unset mute
    win volume ismute # check the volume status"
}

function get_vol {
  [math]::Round([Audio]::Volume * 100)
}

function the_vol {
  $value = get_vol
  echo "Vol: $value"
}

function set_vol([Parameter(mandatory=$true)][Int32] $Volume) {
  [Audio]::Volume = ($Volume / 100)
  the_vol
}

function up_vol {
  $volume = get_vol
  set_vol($volume + 6)
  # the_vol
}

function down_vol {
  $volume = get_vol
  set_vol($volume - 6)
  # the_vol
}

function vol_mute {
  [Audio]::Mute = $true
  echo "Vol, is mute: true"
}

function vol_unmute {
  [Audio]::Mute = $false
  echo "Vol, is mute: false"
}


function is_mute {
  $muted = ([Audio]::Mute -eq $true).tostring().tolower()
  return "Vol, is mute: $muted"
}

switch ($cmd)
{
  {0..100 -contains $_}{set_vol($_)}
  {"up" -contains $_}{up_vol}
  {"down" -contains $_}{down_vol}
  {"mute" -contains $_}{vol_mute}
  {"unmute" -contains $_}{vol_unmute}
  {"ismute" -contains $_}{is_mute}
  {"help" -contains $_}{help}
  Default {the_vol}
}
