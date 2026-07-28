browser.action.onClicked.addListener((tab) => openInPolypane(tab.url));

browser.runtime.onMessage.addListener((message) => {
  if (message.action === "openInPolypane") {
    openInPolypane(message.url);
  }
});

const openInPolypane = (url) => {
  browser.tabs.update({ url: `polypane://${url}` });
};

const handleContextMenu = (info) => {
  if (info.menuItemId === "open-in-polypane") {
    openInPolypane(info.linkUrl);
  }
  if (info.menuItemId === "toggle-local-button") {
    browser.storage.sync.set({ buttonDisabled: !info.checked });
  }
  if (info.menuItemId.startsWith("button-position-")) {
    const position = info.menuItemId.replace("button-position-", "");
    browser.storage.sync.set({ buttonPosition: position });
  }
};

browser.contextMenus.onClicked.addListener(handleContextMenu);

browser.contextMenus.create({
  id: "open-in-polypane",
  title: "Open in Polypane",
  contexts: ["link"],
  type: "normal",
});

browser.contextMenus.create({
  id: "toggle-local-button",
  title: "Show button on local pages",
  type: "checkbox",
  checked: true,
  contexts: ["action"],
});

browser.contextMenus.create({
  id: "button-position",
  title: "Button position",
  type: "normal",
  contexts: ["action"],
});

const positions = [
  { id: "top-right", title: "Top right" },
  { id: "bottom-right", title: "Bottom right" },
  { id: "top-left", title: "Top left" },
  { id: "bottom-left", title: "Bottom left" },
];

for (const pos of positions) {
  browser.contextMenus.create({
    id: `button-position-${pos.id}`,
    parentId: "button-position",
    title: pos.title,
    type: "radio",
    checked: pos.id === "bottom-left",
    contexts: ["action"],
  });
}

// Sync state with storage on startup
browser.storage.sync.get(["buttonDisabled", "buttonPosition"]).then((result) => {
  updateButtonDisabled(!result.buttonDisabled);
  const position = result.buttonPosition || "bottom-left";
  for (const pos of positions) {
    browser.contextMenus.update(`button-position-${pos.id}`, {
      checked: pos.id === position,
    });
  }
});

// Sync context menu when options page changes buttonDisabled
browser.storage.onChanged.addListener((changes, area) => {
  if (area === "sync") {
    if (changes.buttonDisabled) {
      updateButtonDisabled(!changes.buttonDisabled.newValue);
    }
    if (changes.buttonPosition) {
      const position = changes.buttonPosition.newValue || "bottom-left";
      for (const pos of positions) {
        browser.contextMenus.update(`button-position-${pos.id}`, {
          checked: pos.id === position,
        });
      }
    }
  }
});

function updateButtonDisabled(checked) {
  browser.contextMenus.update("toggle-local-button", { checked });
}

browser.commands.onCommand.addListener(function (command, tab) {
  if (command === "open-in-polypane") {
    if (tab) {
      openInPolypane(tab.url);
    } else {
      browser.tabs.query({ active: true }, (tabs) => {
        openInPolypane(tabs[0].url);
      });
    }
  }
});
