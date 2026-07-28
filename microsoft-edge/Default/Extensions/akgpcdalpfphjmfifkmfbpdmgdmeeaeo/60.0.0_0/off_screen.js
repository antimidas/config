chrome.desktopCapture.chooseDesktopMedia(["window", "screen","tab"], function(n) {
  //@ts-ignore
  n && navigator.webkitGetUserMedia(
    {
      audio: false,
      video: {
        mandatory: {
          chromeMediaSource: "desktop",
          chromeMediaSourceId: n,
          maxWidth: 3e3,
          maxHeight: 3e3
        }
      }
    },
    async function(stream2) {

    let video = document.createElement("video");
    video.srcObject = stream2;
    video.onloadedmetadata = () => {
      video.play();
      //@ts-ignore
      let cs = document.createElement("canvas");
      cs.width = video.videoWidth;
      cs.height = video.videoHeight;
      cs.getContext("2d").drawImage(video, 0, 0, cs.width, cs.height);
      var png=cs.toDataURL("image/png");
      chrome.storage.local.set({ 'screenshot': png })
      chrome.offscreen.closeDocument()
      chrome.tabs.create({
          url: chrome.runtime.getURL('editor.html')
        })
    }
  }, function() {
    chrome.offscreen.closeDocument()
  });
})