(function () {
  const STORAGE_KEY = "domainRules";
  const domainList = document.getElementById("domain-list");
  const addForm = document.getElementById("add-form");
  const addBtn = document.getElementById("add-btn");
  const addConfirm = document.getElementById("add-confirm");
  const addCancel = document.getElementById("add-cancel");
  const newDomainInput = document.getElementById("new-domain-input");
  const newOverlayType = document.getElementById("new-overlay-type");
  const newDelay = document.getElementById("new-delay");
  const newDelayWrapper = newDelay?.closest(".delay-wrapper");
  const toastEl = document.getElementById("toast");

  let rules = [];
  let buttonDisabled = false;
  let buttonPosition = "bottom-left";
  let toastTimer = null;

  function showToast(message, type) {
    toastEl.textContent = message;
    toastEl.className = `toast ${type} show`;
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => toastEl.classList.remove("show"), 2500);
  }

  async function loadAll() {
    const result = await browser.storage.sync.get([STORAGE_KEY, "buttonDisabled", "buttonPosition"]);
    rules = result[STORAGE_KEY] || [];
    buttonDisabled = result.buttonDisabled || false;
    buttonPosition = result.buttonPosition || "bottom-left";
  }

  async function saveRules() {
    await browser.storage.sync.set({ [STORAGE_KEY]: rules });
  }

  function toggleDelayWrapper(select, wrapper) {
    wrapper.classList.toggle("hidden", select.value !== "auto-open");
  }

  function render() {
    domainList.innerHTML = "";
    renderButtonPosition();

    renderLocalPagesEntry();

    for (const rule of rules) {
      const entry = document.createElement("div");
      entry.className = "domain-entry";

      const nameCell = document.createElement("div");
      nameCell.className = "domain-name";

      const nameInput = document.createElement("input");
      nameInput.type = "text";
      nameInput.value = rule.domain;
      nameInput.title = "Click to edit domain";
      nameInput.addEventListener("change", async () => {
        const newDomain = nameInput.value.trim().toLowerCase();
        if (!newDomain) {
          nameInput.value = rule.domain;
          showToast("Domain cannot be empty", "error");
          return;
        }
        if (newDomain !== rule.domain && rules.some((r) => r.domain === newDomain)) {
          nameInput.value = rule.domain;
          showToast("Domain already exists", "error");
          return;
        }
        rule.domain = newDomain;
        await saveRules();
        showToast("Saved", "success");
      });
      nameInput.addEventListener("keydown", (e) => {
        if (e.key === "Escape") nameInput.value = rule.domain;
      });

      nameCell.appendChild(nameInput);

      const typeSelect = document.createElement("select");
      ["button", "dialog", "auto-open"].forEach((t) => {
        const opt = document.createElement("option");
        opt.value = t;
        opt.textContent = overlayLabel(t);
        if (t === rule.overlay) opt.selected = true;
        typeSelect.appendChild(opt);
      });
      typeSelect.addEventListener("change", async () => {
        rule.overlay = typeSelect.value;
        await saveRules();
        render();
      });

      const delayWrapper = document.createElement("span");
      delayWrapper.className = "delay-wrapper";
      const delayInput = document.createElement("input");
      delayInput.type = "number";
      delayInput.className = "delay-input";
      delayInput.value = rule.delay ?? 0;
      delayInput.min = 0;
      delayInput.max = 30;
      delayInput.addEventListener("change", async () => {
        rule.delay = parseInt(delayInput.value, 10) || 0;
        await saveRules();
        showToast("Saved", "success");
      });
      delayWrapper.appendChild(delayInput);
      delayWrapper.appendChild(document.createTextNode("sec"));

      toggleDelayWrapper(typeSelect, delayWrapper);

      const toggleLabel = document.createElement("label");
      toggleLabel.className = "toggle";
      const toggleInput = document.createElement("input");
      toggleInput.type = "checkbox";
      toggleInput.title = "Enable/disable this domain rule";
      toggleInput.checked = rule.enabled !== false;
      toggleInput.addEventListener("change", async () => {
        rule.enabled = toggleInput.checked;
        await saveRules();
      });
      const slider = document.createElement("span");
      slider.className = "slider";
      toggleLabel.appendChild(toggleInput);
      toggleLabel.appendChild(slider);

      const deleteBtn = document.createElement("button");
      deleteBtn.className = "btn-danger";
      deleteBtn.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-trash"><path stroke="none" d="M0 0h24v24H0z" fill="none" /><path d="M4 7l16 0" /><path d="M10 11l0 6" /><path d="M14 11l0 6" /><path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12" /><path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3" /></svg>`;
      deleteBtn.title = "Delete domain rule";
      deleteBtn.addEventListener("click", async () => {
        rules = rules.filter((r) => r !== rule);
        await saveRules();
        render();
        showToast("Domain removed", "success");
      });

      entry.appendChild(toggleLabel);
      entry.appendChild(nameCell);
      entry.appendChild(delayWrapper);
      entry.appendChild(typeSelect);
      entry.appendChild(deleteBtn);
      domainList.appendChild(entry);
    }

    if (rules.length === 0) {
      const emptyMsg = document.createElement("div");
      emptyMsg.className = "empty-state";
      emptyMsg.innerHTML = `<p>No additional domain rules.</p>`;
      domainList.appendChild(emptyMsg);
    }
  }

  function renderLocalPagesEntry() {
    const entry = document.createElement("div");
    entry.className = "domain-entry";

    const nameCell = document.createElement("div");
    nameCell.className = "domain-name";

    const nameSpan = document.createElement("span");
    nameSpan.textContent = "Local pages";
    nameSpan.style.fontSize = "14px";
    nameSpan.style.fontWeight = "600";

    const hint = document.createElement("span");
    hint.style.cssText = "font-size:12px;color:var(--text-muted);font-weight:400;";
    hint.textContent = "localhost, 127.0.0.1, *.local";

    nameCell.appendChild(nameSpan);
    nameCell.appendChild(hint);

    const typeSpan = document.createElement("span");
    typeSpan.style.cssText = "font-size:12px;color:var(--text-muted);";
    typeSpan.textContent = "Button";

    const spacer = document.createElement("span");

    const toggleLabel = document.createElement("label");
    toggleLabel.className = "toggle";
    const toggleInput = document.createElement("input");
    toggleInput.type = "checkbox";
    toggleInput.checked = !buttonDisabled;
    toggleInput.addEventListener("change", async () => {
      buttonDisabled = !toggleInput.checked;
      await browser.storage.sync.set({ buttonDisabled });
    });
    const slider = document.createElement("span");
    slider.className = "slider";
    toggleLabel.appendChild(toggleInput);
    toggleLabel.appendChild(slider);

    entry.appendChild(toggleLabel);
    entry.appendChild(nameCell);
    entry.appendChild(typeSpan);
    domainList.appendChild(entry);
  }

  function renderButtonPosition() {
    const radios = document.querySelectorAll('input[name="buttonPosition"]');
    radios.forEach((radio) => {
      radio.checked = radio.value === buttonPosition;
      radio.addEventListener("change", async () => {
        if (radio.checked) {
          buttonPosition = radio.value;
          await browser.storage.sync.set({ buttonPosition });
        }
      });
    });
  }

  browser.storage.onChanged.addListener((changes, area) => {
    if (area === "sync") {
      if (changes.buttonDisabled) {
        buttonDisabled = changes.buttonDisabled.newValue || false;
        const toggle = document.querySelector('#domain-list .domain-entry:first-child .toggle input');
        if (toggle) toggle.checked = !buttonDisabled;
      }
      if (changes.buttonPosition) {
        buttonPosition = changes.buttonPosition.newValue || "bottom-left";
        const radios = document.querySelectorAll('input[name="buttonPosition"]');
        radios.forEach((r) => { r.checked = r.value === buttonPosition; });
      }
    }
  });

  function overlayLabel(type) {
    switch (type) {
      case "button": return "Button";
      case "dialog": return "Overlay";
      case "auto-open": return "Auto-open";
      default: return type;
    }
  }

  function showAddForm() {
    addForm.style.display = "flex";
    newDomainInput.value = "";
    newOverlayType.value = "button";
    newDelay.value = "0";
    toggleDelayWrapper(newOverlayType, newDelayWrapper);
    newDomainInput.focus();
    addBtn.style.display = "none";
  }

  function hideAddForm() {
    addForm.style.display = "none";
    addBtn.style.display = "flex";
  }

  newOverlayType.addEventListener("change", () => {
    toggleDelayWrapper(newOverlayType, newDelayWrapper);
  });

  addBtn.addEventListener("click", showAddForm);

  addCancel.addEventListener("click", hideAddForm);

  addConfirm.addEventListener("click", async () => {
    const domain = newDomainInput.value.trim().toLowerCase();
    if (!domain) {
      showToast("Please enter a domain", "error");
      return;
    }

    if (rules.some((r) => r.domain === domain)) {
      showToast("Domain already exists", "error");
      return;
    }

    rules.push({
      domain,
      overlay: newOverlayType.value,
      delay: parseInt(newDelay.value, 10) || 0,
      enabled: true,
    });

    await saveRules();
    render();
    hideAddForm();
    showToast("Domain added", "success");
  });

  newDomainInput.addEventListener("keydown", (e) => {
    if (e.key === "Enter") addConfirm.click();
    if (e.key === "Escape") hideAddForm();
  });

  const isThisMac = () => /Mac|iPod|iPhone|iPad/.test(navigator.platform);

  const confShortcuts = () => {
    const shortcutElements = document.querySelectorAll('kbd');
    shortcutElements.forEach((kbd) => {
      const alt = kbd.querySelector('.alt');
      const cmd = kbd.querySelector('.cmd');
      const shift = kbd.querySelector('.shift');

      if (alt) alt.textContent = isThisMac() ? '⌥' : 'Alt';
      if (cmd) cmd.textContent = isThisMac() ? '⌘' : 'Ctrl';
      if (shift) shift.textContent = isThisMac() ? '⇧' : 'Shift';
    });
  }


  async function init() {
    await loadAll();
    render();
    hideAddForm();
    confShortcuts();
  }

  init();
})();
