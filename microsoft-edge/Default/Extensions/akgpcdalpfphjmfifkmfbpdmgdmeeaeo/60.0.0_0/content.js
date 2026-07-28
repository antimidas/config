//@ts-check

var svgEntire = `<svg width="38" height="38" viewBox="0 0 38 38" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M6.33333 6.33333V4.75H4.75V6.33333H6.33333ZM17.8806 20.1194C18.1792 20.4078 18.5792 20.5674 18.9943 20.5638C19.4094 20.5602 19.8066 20.3937 20.1001 20.1001C20.3937 19.8066 20.5602 19.4094 20.5638 18.9943C20.5674 18.5792 20.4078 18.1792 20.1194 17.8806L17.8806 20.1194ZM7.91667 15.8333V6.33333H4.75V15.8333H7.91667ZM6.33333 7.91667H15.8333V4.75H6.33333V7.91667ZM5.21392 7.45275L17.8806 20.1194L20.1194 17.8806L7.45275 5.21392L5.21392 7.45275Z" fill="white"/>
<path d="M6.33333 31.6667V33.25H4.75V31.6667H6.33333ZM17.8806 17.8806C18.1792 17.5922 18.5792 17.4326 18.9943 17.4362C19.4094 17.4398 19.8066 17.6063 20.1001 17.8999C20.3937 18.1934 20.5602 18.5906 20.5638 19.0057C20.5674 19.4208 20.4078 19.8208 20.1194 20.1194L17.8806 17.8806ZM7.91667 22.1667V31.6667H4.75V22.1667H7.91667ZM6.33333 30.0833H15.8333V33.25H6.33333V30.0833ZM5.21392 30.5472L17.8806 17.8806L20.1194 20.1194L7.45275 32.7861L5.21392 30.5472Z" fill="white"/>
<path d="M31.6667 6.33333V4.75H33.25V6.33333H31.6667ZM20.1194 20.1194C19.8208 20.4078 19.4208 20.5674 19.0057 20.5638C18.5906 20.5602 18.1934 20.3937 17.8999 20.1001C17.6063 19.8066 17.4398 19.4094 17.4362 18.9943C17.4326 18.5792 17.5922 18.1792 17.8806 17.8806L20.1194 20.1194ZM30.0833 15.8333V6.33333H33.25V15.8333H30.0833ZM31.6667 7.91667H22.1667V4.75H31.6667V7.91667ZM32.7861 7.45275L20.1194 20.1194L17.8806 17.8806L30.5473 5.21392L32.7861 7.45275Z" fill="white"/>
<path d="M31.6667 31.6667V33.25H33.25V31.6667H31.6667ZM20.1194 17.8806C19.8208 17.5922 19.4208 17.4326 19.0057 17.4362C18.5906 17.4398 18.1934 17.6063 17.8999 17.8999C17.6063 18.1934 17.4398 18.5906 17.4362 19.0057C17.4326 19.4208 17.5922 19.8208 17.8806 20.1194L20.1194 17.8806ZM30.0833 22.1667V31.6667H33.25V22.1667H30.0833ZM31.6667 30.0833H22.1667V33.25H31.6667V30.0833ZM32.7861 30.5472L20.1194 17.8806L17.8806 20.1194L30.5473 32.7861L32.7861 30.5472Z" fill="white"/>
</svg>
`
var svgCrop = `<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M25.9167 35.4167V29.0833H10.0833C9.21251 29.0833 8.46729 28.7735 7.84768 28.1539C7.22807 27.5343 6.91773 26.7886 6.91668 25.9167V10.0833H0.583344V6.91667H6.91668V0.583334H10.0833V25.9167H35.4167V29.0833H29.0833V35.4167H25.9167ZM25.9167 22.75V10.0833H13.25V6.91667H25.9167C26.7875 6.91667 27.5333 7.227 28.1539 7.84767C28.7746 8.46833 29.0844 9.21356 29.0833 10.0833V22.75H25.9167Z" fill="white"/>
</svg>
`
var svgVisibleArea = `<svg width="45" height="45" viewBox="0 0 45 45" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M37.9688 7.03125H7.03125C6.28533 7.03125 5.56996 7.32757 5.04251 7.85501C4.51507 8.38246 4.21875 9.09783 4.21875 9.84375V35.1562C4.21875 35.9022 4.51507 36.6175 5.04251 37.145C5.56996 37.6724 6.28533 37.9688 7.03125 37.9688H37.9688C38.7147 37.9688 39.43 37.6724 39.9575 37.145C40.4849 36.6175 40.7812 35.9022 40.7812 35.1562V9.84375C40.7812 9.09783 40.4849 8.38246 39.9575 7.85501C39.43 7.32757 38.7147 7.03125 37.9688 7.03125ZM37.9688 9.84375V15.4688H7.03125V9.84375H37.9688ZM37.9688 35.1562H7.03125V18.2812H37.9688V35.1562Z" fill="white"/>
</svg>
`
var svgClose = `<svg width="24" height="24" viewBox="0 0 38 38" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M27.93 8.284C28.2524 8.55282 28.4548 8.93866 28.4928 9.35671C28.5308 9.77475 28.4013 10.1908 28.1326 10.5133L21.0607 19L28.1326 27.4867C28.2717 27.6456 28.3775 27.8307 28.4439 28.0311C28.5103 28.2315 28.536 28.4431 28.5194 28.6536C28.5028 28.8641 28.4443 29.0691 28.3473 29.2566C28.2503 29.4441 28.1168 29.6104 27.9546 29.7455C27.7924 29.8807 27.6048 29.9821 27.4029 30.0436C27.2009 30.1052 26.9887 30.1258 26.7787 30.1042C26.5687 30.0825 26.3651 30.0191 26.18 29.9177C25.9948 29.8162 25.8319 29.6787 25.7006 29.5133L19 21.4732L12.3001 29.5133C12.1681 29.6763 12.005 29.8115 11.8203 29.911C11.6356 30.0104 11.433 30.0722 11.2242 30.0926C11.0154 30.1131 10.8047 30.0919 10.6042 30.0302C10.4037 29.9685 10.2174 29.8676 10.0562 29.7334C9.89506 29.5991 9.76217 29.4341 9.66529 29.2481C9.56841 29.062 9.50947 28.8586 9.4919 28.6495C9.47432 28.4405 9.49845 28.23 9.5629 28.0304C9.62735 27.8308 9.73082 27.646 9.86731 27.4867L16.9393 19L9.86731 10.5133C9.73082 10.354 9.62735 10.1692 9.5629 9.96957C9.49845 9.76995 9.47432 9.5595 9.4919 9.35047C9.50947 9.14144 9.56841 8.93798 9.66529 8.75192C9.76217 8.56585 9.89506 8.4009 10.0562 8.26663C10.2174 8.13236 10.4037 8.03146 10.6042 7.96979C10.8047 7.90811 11.0154 7.8869 11.2242 7.90737C11.433 7.92784 11.6356 7.98959 11.8203 8.08904C12.005 8.18849 12.1681 8.32365 12.3001 8.48666L19 16.5268L25.7006 8.48666C25.9695 8.16427 26.3553 7.96181 26.7734 7.92381C27.1914 7.8858 27.6074 8.01536 27.93 8.284Z" fill="black"/>
</svg>
`
var svgEditContent=`<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 16 16"><path fill="currentColor" d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793L14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708zm.646 6.061L9.793 2.5L3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.5.5 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11z"/></svg>`
var svgFeedback=`<svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" viewBox="0 0 24 24"><path fill="currentColor" d="M12 14.423q.271 0 .443-.172q.173-.172.173-.443q0-.272-.173-.444q-.172-.172-.443-.172t-.443.172t-.173.444t.173.443t.443.172m0-2.961q.214 0 .357-.144t.143-.356V5.885q0-.214-.143-.357T12 5.385t-.357.143t-.143.357v5.077q0 .213.143.356t.357.144M6.077 17l-1.704 1.704q-.379.379-.876.174T3 18.133V4.616q0-.691.463-1.153T4.616 3h14.769q.69 0 1.153.463T21 4.616v10.769q0 .69-.462 1.153T19.385 17zm-.427-1h13.735q.23 0 .423-.192t.192-.423V4.615q0-.23-.192-.423T19.385 4H4.615q-.23 0-.423.192T4 4.615v13.03zM4 16V4z"/></svg>`

if (shadowRoot) {
  try {
    document.body.removeChild(shadowHost)
  } catch (err) { }
}
var shadowHost = document.createElement('div');
shadowHost.style.cssText = `all:unset!important;`
var shadowRoot = shadowHost.attachShadow({ mode: 'open' });
document.body.prepend(shadowHost);
var marginTop = shadowHost.getBoundingClientRect().y

var buttonStyle = `display:inline-flex;align-items:center;margin-left:10px;`
var topHTML = `
<div style="
    position:fixed;
    width:100%;  
    font-family:Arial;
    // font-size:18px;
    // margin-top:${-marginTop + 8}px;
    text-align:center;
    z-index:2147483646;
">
    <div style="
        background:#555;
        color:white;
        margin-left:auto;
        padding:10px 30px;
        display:inline-flex;
        align-items:center;
        position:relative;
        cursor:pointer;
        border-radius:20px;
    ">
    <div id="ws_close" style="position:absolute;right:-27px;top:0px;color:black;cursor:pointer;z-index:2147483647">
    ${svgClose}
    </div>
    <div id="ws_feedback_div" style="display:none">
     We'd love to get your feedback!
     <a style="color:white" href="https://t.me/+EHvGUMkVYaU0ZDU8">Telegram</a>
     <a style="color:white" href="https://discord.gg/aKQ6ErMq">Discord</a>
     <a style="color:white" href="https://chat.whatsapp.com/LBUyMHiaUtqAb7n26wadxE">WhatsApp</a>
    </div>
    <div id="ws_all_buttons" style="display:flex">
      <div id="ws_entire" style="${buttonStyle}">
          ${svgEntire}
          &nbsp;
          ${chrome.i18n.getMessage('allpage')}
      </div>
      <div id="start_visible" style="${buttonStyle}">
          ${svgVisibleArea}
          &nbsp;
          ${chrome.i18n.getMessage('visiblescreenshot')}
      </div>
      <div id="start_desktop" style="${buttonStyle}">
          ${svgVisibleArea}
          &nbsp;
          Desktop Capture
      </div>
      <div id="edit_content" style="${buttonStyle}">
          ${svgEditContent}
          &nbsp;
          Edit Content
      </div>
      <div id="ws_feedback" style="${buttonStyle}">
          ${svgFeedback}
          &nbsp;
          Feedback
      </div>
    </div>
  </div>
</div>
`

shadowRoot.innerHTML = topHTML;


shadowRoot.querySelector('#ws_close').addEventListener('click', () => {
  closeWS()
})
shadowRoot.querySelector('#start_desktop').addEventListener('click', () => {
  closeWS()
  startDesktop()
})
shadowRoot.querySelector('#edit_content').addEventListener('click', () => {
  window.document.body.contentEditable="true"
  closeWS()
})
shadowRoot.querySelector('#ws_feedback').addEventListener('click', () => {
  // window.document.body.contentEditable="true"
  //@ts-ignore
  shadowRoot.querySelector('#ws_all_buttons').style.display='none'
  shadowRoot.querySelector('#ws_feedback_div').style.display=''
})
function closeWS() {
  document.body.removeChild(shadowHost)
}

shadowRoot.querySelector('#ws_entire').addEventListener('click', async () => {
  closeWS()
  await delay(100)
  var windowWidth = window.innerWidth
  var windowHeight = window.innerHeight
  var documentWidth = document.body.scrollWidth
  var documentHeight = document.body.scrollHeight
  if (getComputedStyle(document.body).overflowY == 'hidden') {
    documentHeight = Math.min(documentHeight, windowHeight)
  }
  if (getComputedStyle(document.body).overflowX == 'hidden') {
    documentWidth = Math.min(documentWidth, windowWidth)
  }

  //@ts-ignore
  saveScrollPos()
  //@ts-ignore
  enableScrollbar(false)
  //@ts-ignore
  fixedElementCheck()
  //@ts-ignore
  hideSomeStrangeElements()
  //@ts-ignore
  hideFixedElement("bottom")
  //@ts-ignore


  var documentLeftRightMargins =
    parseInt(getComputedStyle(document.body).marginLeft) +
    parseInt(getComputedStyle(document.body).marginRight)

  var documentTopBottomMargins =
    parseInt(getComputedStyle(document.body).marginTop) +
    parseInt(getComputedStyle(document.body).marginBottom)


  var currentX = 0
  var currentY = 0

  var oneLastTime = false
  var lastX
  var lastY
  var screens = []
  for (let i = 0; i < 200; i++) {
    $(window).scrollTop(currentY)
    $(window).scrollLeft(currentX)
    currentX = window.scrollX
    currentY = window.scrollY
    if (lastX === currentX && lastY === currentY) oneLastTime = true
    lastX = currentX
    lastY = currentY
    if (currentY > 0) {
      //@ts-ignore
      await hideFixedElement("top")
    }
    if (oneLastTime) {
      //@ts-ignore
      await showFixedElement("bottom")
    }

    await delay(400)
    var dataURL = await captureVisibleTab()
    screens.push({
      top: currentY,
      left: currentX,
      data: dataURL,
    })
    if (oneLastTime) break

    if (currentX + windowWidth < documentWidth) {
      // Scroll Horizonatally
      // console.log("scroll horizontally")
      currentX += windowWidth // Change only x
    } else {
      // Scroll vertically
      // console.log("scroll vertically")
      currentX = 0 // Stay on top left
      if (currentY + windowHeight >= documentHeight) {
        // No more scrolling
        oneLastTime = true
        continue
      } else {
        currentY += windowHeight
      }
    }
  }
  // Create last image
  var canvas = document.createElement("canvas")
  canvas.width = documentWidth + documentLeftRightMargins
  canvas.height = documentHeight
  var ctx = canvas.getContext("2d")
  for (var i = 0; i < screens.length; i++) {
    let thisScreen = screens[i]
    let img = document.createElement("img")
    await new Promise((resolve) => {
      img.onload = () => {
        ctx.drawImage(
          img,
          thisScreen.left,
          thisScreen.top,
          windowWidth,
          windowHeight,
        )
        resolve()
      }
      img.src = thisScreen.data
    })
  }

  dataURL = canvas.toDataURL()

  //@ts-ignore
  restoreScrollPos()
  //@ts-ignore
  enableScrollbar(true)
  //@ts-ignore
  showFixedElement("top")
  //@ts-ignore
  showFixedElement("bottom")
  chrome.runtime.sendMessage({ action: "open_with_data", data: dataURL })
})

shadowRoot.querySelector('#start_visible').addEventListener('click', async () => {
  closeWS()
  await delay(100)
  var res = await chrome.runtime.sendMessage({ action: 'captureVisibleTab' })
  var canvas = document.createElement("canvas")
  canvas.width = window.innerWidth
  canvas.height = window.innerHeight
  var ctx = canvas.getContext("2d", { willReadFrequently: true })
  let img = document.createElement("img")
  await new Promise((resolve) => {
    img.onload = () => {
      ctx.drawImage(
        img,
        0,
        0,
        canvas.width,
        canvas.height,
      )
      var data = canvas.toDataURL('image/png')
      chrome.runtime.sendMessage({ action: "open_with_data", data: data })
    }
    img.src = res
  })
  chrome.runtime.sendMessage({ action: "open_with_data", data: res })
})

async function captureVisibleTab() {
  var res = await chrome.runtime.sendMessage({ action: 'captureVisibleTab' })
  return res
}


async function startDesktop() {
  var res = await chrome.runtime.sendMessage({ action: 'startDesktop' })
}

function delay(ms) { return new Promise(resolve => setTimeout(resolve, ms)) }