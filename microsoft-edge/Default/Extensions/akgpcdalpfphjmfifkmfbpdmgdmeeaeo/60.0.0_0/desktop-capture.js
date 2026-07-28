document.querySelector('button').addEventListener('click',()=>{
  chrome.permissions.request({ permissions: ["desktopCapture"] }, function() {
    chrome.runtime.sendMessage({action:'startDesktop'})
  })
})
