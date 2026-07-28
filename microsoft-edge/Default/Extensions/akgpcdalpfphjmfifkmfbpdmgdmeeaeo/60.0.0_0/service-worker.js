//@ts-check

chrome.runtime.onInstalled.addListener(({ reason }) => {
  try {
    chrome.runtime.setUninstallURL('https://webpagescreenshot.info/')
  } catch (err) {
    console.log('did not set 1')
  }
  if (reason == "install") {
    chrome.storage.local.set({ "version": parseInt(chrome.runtime.getManifest().version.split('.')[0]) })
    chrome.tabs.create({ url: 'https://webpagescreenshot.info/' })
  }
})


chrome.runtime.onStartup.addListener(() => {
  try {
    chrome.runtime.setUninstallURL('https://webpagescreenshot.info/')
  } catch (err) {
    console.log('did not set 2')
  }
})

chrome.action.onClicked.addListener(async (tab) => {
  try {
    var data = await chrome.scripting.executeScript({
      target: { tabId: tab.id },
      files: [
        'jquery.js',
        'content.js',
        'intab.js',
      ],
    });
  } catch (err) {
    // not workign on that page
    chrome.tabs.create({ url: 'notworking.html' })
  }
  // var res=await chrome.runtime.sendMessage({action:'captureVisibleTab'})
})
/**
 * @param {chrome.tabs.Tab} tab
 */
async function startVisible(tab) {
  var res = await chrome.tabs.captureVisibleTab({ format: "png" })
  await chrome.storage.local.set({ 'screenshot': res })
  chrome.tabs.create({
    url: chrome.runtime.getURL('editor.html')
  })
}

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.action === "start_visible") {
    startVisible(sender.tab)
  }
  if (request.action == 'startDesktop') {
    chrome.permissions.contains({ permissions: ["desktopCapture"] }, async res => {
      if (!res) {
        chrome.tabs.create({
          url: chrome.runtime.getURL('desktop-capture.html')
        })
      } else {
        chrome.tabs.create({
          url: chrome.runtime.getURL('off_screen.html')
        })
        // if(await chrome.offscreen.hasDocument) {
        //   await chrome.offscreen.closeDocument()
        // }
        // chrome.offscreen.createDocument({
        //   url: 'off_screen.html',
        //   //@ts-ignore
        //   reasons: ['DISPLAY_MEDIA'],
        //   justification: 'User want to capture screen',
        // });
      }
    })
  }
  if (request.action == 'captureVisibleTab') {
    chrome.tabs.captureVisibleTab({ format: "png" }, (res) => {
      sendResponse(res)
    })
  }
  if (request.action == 'open_with_data') {
    chrome.storage.local.set({ 'screenshot': request.data })
    chrome.tabs.create({
      url: chrome.runtime.getURL('editor.html')
    })
  }
  return true
});
