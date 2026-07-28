/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ([
/* 0 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const VideoController_1 = __importDefault(__webpack_require__(1));
const ActionController_1 = __webpack_require__(6);
const UiController_1 = __importDefault(__webpack_require__(10));
const TimeUiController_1 = __importDefault(__webpack_require__(15));
const MyListController = __importStar(__webpack_require__(17));
const Options_1 = __webpack_require__(3);
const ImdbController_1 = __importDefault(__webpack_require__(18));
const skipIntroButtonClass = '.watch-video--skip-content-button[data-uia="player-skip-intro"]';
const skipRecapButtonClass = '.watch-video--skip-content-button[data-uia="player-skip-recap"]';
function main() {
    const videoController = new VideoController_1.default();
    videoController.start();
    MyListController.randomVideo();
    observe(videoController);
    document.addEventListener("keydown", (event) => {
        const actionNames = ActionController_1.ActionFactory.actionNames.filter((actionName) => Options_1.options[actionName] === event.key);
        if (actionNames.length === 0) {
            return;
        }
        const action = ActionController_1.ActionFactory.getAction(actionNames[0]);
        if (action) {
            action.execute(videoController);
        }
    }, false);
    ImdbController_1.default.addImdbButton();
}
function observe(videoController) {
    const uiController = new UiController_1.default();
    const timeUiController = new TimeUiController_1.default();
    const imdbController = new ImdbController_1.default();
    let oldHref = location.href;
    const observer = new MutationObserver(() => {
        uiController.createUi(videoController);
        setTimeout(() => {
            timeUiController.initTime(videoController.getHtmlVideo);
        }, 1000);
        videoController.start();
        if (oldHref !== location.href) {
            oldHref = location.href;
            MyListController.randomVideo();
            imdbController.init();
        }
        if (Options_1.options.autoSkipIntro) {
            const skipButton = document.querySelector(skipIntroButtonClass);
            if (skipButton) {
                skipButton.click();
            }
        }
        if (Options_1.options.autoSkipRecap) {
            const skipButton = document.querySelector(skipRecapButtonClass);
            if (skipButton) {
                skipButton.click();
            }
        }
        if (Options_1.options.updateTabTitle) {
            uiController.updateTitle();
        }
        if (Options_1.options.hideMobileGames) {
            uiController.hideMobileGames();
        }
        if (Options_1.options.hideOtherGames) {
            uiController.hideOtherGames();
        }
    });
    observer.observe(document.body, { childList: true, subtree: true });
}
main();


/***/ }),
/* 1 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const ScrollController_1 = __importDefault(__webpack_require__(2));
class VideoController {
    constructor() {
        this._updatingVideo = false;
        this._currentZoom = 100;
        this._minHeight = 100;
        this._width = 100;
    }
    start() {
        if (!this._updatingVideo && this.findVideo()) {
            this._updatingVideo = true;
            this.updateVideo();
        }
    }
    findVideo() {
        if (location.toString().indexOf("/watch") > 0) {
            const currentVideo = document.querySelector("video");
            if (currentVideo !== null &&
                (!this._htmlVideo || this._htmlVideo.src !== currentVideo.src)) {
                this._htmlVideo = currentVideo;
                return true;
            }
        }
        return false;
    }
    updateVideo() {
        this._updatingVideo = false;
        (0, ScrollController_1.default)(this._htmlVideo);
        this._minHeight =
            (this._htmlVideo.offsetHeight /
                this._htmlVideo.parentElement.offsetHeight) *
                100;
        if (this._minHeight > this._currentZoom) {
            this.setZoom(this._minHeight);
        }
        else {
            this.restoreZoomOfPreviousVideo();
        }
        this._htmlVideo.removeAttribute("disablePictureInPicture");
    }
    restoreZoomOfPreviousVideo() {
        if (this._currentZoom !== 100) {
            this.setZoom(this._currentZoom, this._width);
        }
    }
    addZoom(percentage) {
        let height = parseInt(this._htmlVideo.style.minHeight);
        if (isNaN(height)) {
            height = this._minHeight;
        }
        this._width += percentage;
        if (this._width < 100) {
            this._width = 100;
        }
        this.setZoom(percentage + height, this._width);
    }
    setZoom(percentage, width = 100) {
        if (percentage < this._minHeight) {
            percentage = this._minHeight;
        }
        this._htmlVideo.style.minWidth = width + "%";
        this._htmlVideo.style.minHeight = percentage + "%";
        this._width = width;
        this._currentZoom = percentage;
    }
    get getHtmlVideo() {
        return this._htmlVideo;
    }
    get currentZoom() {
        return this._currentZoom;
    }
}
exports["default"] = VideoController;


/***/ }),
/* 2 */
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const Options_1 = __webpack_require__(3);
function createScrollEvent(func) {
    document
        .querySelector("div.watch-video > div")
        .addEventListener("wheel", func, false);
}
function scrollUpDownEvent(upFunc, downFunc) {
    createScrollEvent((event) => {
        if (event.deltaY > 0)
            downFunc();
        else
            upFunc();
    });
}
function initListener(videoElement) {
    function fireKeyboardEvent(keyCode) {
        const event = new KeyboardEvent("keydown", {
            bubbles: true,
            cancelable: true,
            keyCode: keyCode,
        });
        videoElement.dispatchEvent(event);
    }
    const upFunc = () => fireKeyboardEvent(38);
    const downFunc = () => fireKeyboardEvent(40);
    scrollUpDownEvent(upFunc, downFunc);
}
function addVolumeScrollListener(videoElement) {
    if (!Options_1.options.volumeMouseWheel)
        return;
    initListener(videoElement);
}
exports["default"] = addVolumeScrollListener;


/***/ }),
/* 3 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.options = exports.defaultKeys = void 0;
const UserOptionsModel_1 = __importDefault(__webpack_require__(4));
const defaultKeys = {
    zoomIn: "+",
    zoomOut: "-",
    resetZoom: ",",
    fullZoom: ".",
    disableMouse: "d",
    enableMouse: "e",
    toggleStatistics: "q",
    customZoom: "c",
    toggleSubtitles: "v",
    volumeMouseWheel: true,
    hideZoomInButton: false,
    hideZoomOutButton: false,
    hideResetZoomButton: false,
    hideFullZoomButton: false,
    showCustomZoomButton: false,
    customZoomAmount: 0,
    hidePictureInPictureButton: false,
    autoSkip: false,
    autoSkipRecap: false,
    elapsedTime: true,
    updateTabTitle: true,
    hideMobileGames: false,
    hideOtherGames: false,
};
exports.defaultKeys = defaultKeys;
const options = UserOptionsModel_1.default.optionKeys;
exports.options = options;


/***/ }),
/* 4 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const ChromeController_1 = __importDefault(__webpack_require__(5));
const Options_1 = __webpack_require__(3);
class UserOptionsModel {
    constructor(zoomIn, zoomOut, resetZoom, fullZoom, disableMouse, enableMouse, toggleStatistics, customZoomKey, toggleSubtitles, toggleHelp) {
        if (!this._chromeController)
            this._chromeController = new ChromeController_1.default();
        this._chromeController.getSync(Options_1.defaultKeys, (items) => {
            this._volumeMouseWheel = items.volumeMouseWheel;
            this._hideZoomInButton = items.hideZoomInButton;
            this._hideZoomOutButton = items.hideZoomOutButton;
            this._hideResetZoomButton = items.hideResetZoomButton;
            this._hideFullZoomButton = items.hideFullZoomButton;
            this._showCustomZoomButton = items.showCustomZoomButton;
            this._customZoomAmount = items.customZoomAmount || 0;
            this._pictureInPictureButton = items.hidePictureInPictureButton;
            this._autoSkipIntro = items.autoSkip;
            this._autoSkipRecap = items.autoSkipRecap;
            this._timeElapsed = items.elapsedTime;
            this._updateTabTitle = items.updateTabTitle;
            this._hideMobileGames = items.hideMobileGames;
            this._hideOtherGames = items.hideOtherGames;
        });
        this._zoomIn = zoomIn;
        this._zoomOut = zoomOut;
        this._resetZoom = resetZoom;
        this._fullZoom = fullZoom;
        this._disableMouse = disableMouse;
        this._enableMouse = enableMouse;
        this._toggleStatistics = toggleStatistics;
        this._customZoomKey = customZoomKey;
        this._toggleSubtitles = toggleSubtitles;
        this._toggleHelp = toggleHelp;
    }
    get zoomIn() {
        return this._zoomIn;
    }
    get zoomOut() {
        return this._zoomOut;
    }
    get resetZoom() {
        return this._resetZoom;
    }
    get fullZoom() {
        return this._fullZoom;
    }
    get disableMouse() {
        return this._disableMouse;
    }
    get enableMouse() {
        return this._enableMouse;
    }
    get timeElapsed() {
        return this._timeElapsed;
    }
    get toggleStatistics() {
        return this._toggleStatistics;
    }
    get customZoom() {
        return this._customZoomKey;
    }
    get toggleSubtitles() {
        return this._toggleSubtitles;
    }
    get toggleHelp() {
        return this._toggleHelp;
    }
    get volumeMouseWheel() {
        return this._volumeMouseWheel;
    }
    get hideZoomInButton() {
        return this._hideZoomInButton;
    }
    get hideZoomOutButton() {
        return this._hideZoomOutButton;
    }
    get hideResetZoomButton() {
        return this._hideResetZoomButton;
    }
    get hideFullZoomButton() {
        return this._hideFullZoomButton;
    }
    get showCustomZoomButton() {
        return this._showCustomZoomButton;
    }
    get customZoomAmount() {
        return this._customZoomAmount;
    }
    get hidePictureInPictureButton() {
        return this._pictureInPictureButton;
    }
    get autoSkipIntro() {
        return this._autoSkipIntro;
    }
    get autoSkipRecap() {
        return this._autoSkipRecap;
    }
    get updateTabTitle() {
        return this._updateTabTitle;
    }
    get hideMobileGames() {
        return this._hideMobileGames;
    }
    get hideOtherGames() {
        return this._hideOtherGames;
    }
    static get optionKeys() {
        return new UserOptionsModel("+", "-", ",", ".", "d", "e", "q", "c", "v", "h");
    }
}
exports["default"] = UserOptionsModel;


/***/ }),
/* 5 */
/***/ ((__unused_webpack_module, exports) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
class ChromeController {
    getSync(obj, func) {
        chrome.storage.sync.get(obj, func);
    }
}
exports["default"] = ChromeController;


/***/ }),
/* 6 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.ActionFactory = void 0;
const StatisticController_1 = __importDefault(__webpack_require__(7));
const Options_1 = __webpack_require__(3);
const ToggleSubtitleAction_1 = __importDefault(__webpack_require__(8));
const ToggleHelpAction_1 = __importDefault(__webpack_require__(9));
class ZoomInAction {
    constructor() {
        this.key = Options_1.options.zoomIn;
    }
    execute(videoController) {
        videoController.addZoom(5);
    }
}
class ZoomOutAction {
    constructor() {
        this.key = Options_1.options.zoomOut;
    }
    execute(videoController) {
        videoController.addZoom(-5);
    }
}
class ResetZoomAction {
    constructor() {
        this.key = Options_1.options.resetZoom;
    }
    execute(videoController) {
        videoController.setZoom(100);
    }
}
class FullZoomAction {
    constructor() {
        this.key = Options_1.options.fullZoom;
    }
    execute(videoController) {
        videoController.setZoom(135, 135);
    }
}
class DisableMouseAction {
    constructor() {
        this.key = Options_1.options.disableMouse;
    }
    execute(videoController) {
        const video = videoController.getHtmlVideo;
        video.requestPointerLock().catch((reason) => {
            console.error("Better Netflix: could not request pointer lock for disabling mouse. Reason: ", reason);
        });
    }
}
class EnableMouseAction {
    constructor() {
        this.key = Options_1.options.enableMouse;
    }
    execute() {
        document.exitPointerLock();
    }
}
class ToggleStatisticsAction {
    constructor() {
        this.key = Options_1.options.toggleStatistics;
    }
    execute(videoController) {
        StatisticController_1.default.toggle(videoController);
    }
}
class CustomZoomAction {
    constructor() {
        this.key = Options_1.options.customZoom;
    }
    execute(videoController) {
        const zoom = 100 + Options_1.options.customZoomAmount * 5;
        videoController.setZoom(zoom, zoom);
    }
}
class PictureInPictureAction {
    execute(videoController) {
        if (document.pictureInPictureElement) {
            document.exitPictureInPicture().catch((reason) => {
                console.error("Better Netflix: could not exit picture in picture. Reason: ", reason);
            });
        }
        else if (document.pictureInPictureEnabled) {
            videoController.getHtmlVideo
                .requestPictureInPicture()
                .catch((reason) => {
                console.error("Better Netflix: could not request picture in picture. Reason: ", reason);
            });
        }
    }
}
class ActionFactory {
    static getAction(actionName) {
        return actionName in this._classDictionary
            ? this._classDictionary[actionName]
            : undefined;
    }
    static get actionNames() {
        return Object.keys(this._classDictionary);
    }
}
exports.ActionFactory = ActionFactory;
ActionFactory._classDictionary = {
    zoomIn: new ZoomInAction(),
    zoomOut: new ZoomOutAction(),
    resetZoom: new ResetZoomAction(),
    fullZoom: new FullZoomAction(),
    disableMouse: new DisableMouseAction(),
    enableMouse: new EnableMouseAction(),
    toggleStatistics: new ToggleStatisticsAction(),
    customZoom: new CustomZoomAction(),
    toggleSubtitles: new ToggleSubtitleAction_1.default(),
    pictureInPicture: new PictureInPictureAction(),
    toggleHelp: new ToggleHelpAction_1.default(),
};


/***/ }),
/* 7 */
/***/ ((__unused_webpack_module, exports) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
class StatisticController {
    static initialize() {
        if (this._statisticParent !== undefined)
            return;
        this._fps = document.createElement("div");
        this._resolution = document.createElement("div");
        this._statisticParent = document.createElement("div");
        this._statisticParent.classList.add("statistics", "hidden");
        this._statisticParent.appendChild(this._fps);
        this._statisticParent.appendChild(this._resolution);
        this._video.parentElement.appendChild(this._statisticParent);
    }
    static toggle(videoController) {
        if (videoController !== undefined && videoController !== null) {
            if (videoController.getHtmlVideo !== undefined &&
                videoController.getHtmlVideo !== null) {
                this._video = videoController.getHtmlVideo;
            }
        }
        this.toggleUi();
        if (this._statisticParent.classList.contains("hidden"))
            this.disable();
        else
            this.enable();
    }
    static toggleUi() {
        this.initialize();
        this._statisticParent.classList.toggle("hidden");
    }
    static enable() {
        const updateVideoStats = (function (_this) {
            let currentFrames;
            let prevFrames = _this._video.getVideoPlaybackQuality().totalVideoFrames;
            return function () {
                const props = _this._video.getVideoPlaybackQuality();
                currentFrames = props.totalVideoFrames;
                _this._fps.textContent =
                    "FPS: " +
                        (currentFrames - prevFrames) +
                        " (Dropped: " +
                        props.droppedVideoFrames +
                        ")";
                prevFrames = currentFrames;
                _this._resolution.textContent =
                    "Resolution: " +
                        _this._video.videoWidth +
                        "x" +
                        _this._video.videoHeight;
            };
        })(this);
        this._interval = setInterval(() => {
            updateVideoStats();
        }, 1000);
        this._checkDomInterval = setInterval(() => {
            this.stopIfElementIsNotInDom();
        }, 5000);
    }
    static stopIfElementIsNotInDom() {
        if (!document.querySelector(".statistics")) {
            this.disable();
            this._statisticParent = undefined;
        }
    }
    static disable() {
        clearInterval(this._interval);
        clearInterval(this._checkDomInterval);
    }
}
exports["default"] = StatisticController;


/***/ }),
/* 8 */
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const Options_1 = __webpack_require__(3);
class ToggleSubtitleAction {
    constructor() {
        this.key = Options_1.options.toggleSubtitles;
        this.subtitleButtonSelector = "div.watch-video--bottom-controls-container > div > div > div:nth-child(3) > div > div:nth-child(3) > div:nth-child(8) > button > div";
        this.subtitlesSelector = "div.show > div > div > div:nth-child(2) > ul > li";
        this.subtitleTextSelector = "div > div";
        this.textSubtitlesOff = ["off", "aus"];
    }
    execute(videoController) {
        let subtitleButton = document.querySelector(this.subtitleButtonSelector);
        if (!subtitleButton) {
            videoController.getHtmlVideo.click();
            this.waitForSubtitleMenu();
            subtitleButton = document.querySelector(this.subtitleButtonSelector);
        }
        subtitleButton.click();
        let retries = 10;
        const selectSubtitleInterval = setInterval(() => {
            const successfullySelectedSubtitle = this.selectSubtitle();
            if (!successfullySelectedSubtitle && retries > 0) {
                retries -= 1;
                return;
            }
            clearInterval(selectSubtitleInterval);
            videoController.getHtmlVideo.click();
            videoController.getHtmlVideo.focus();
        }, 300);
    }
    waitForSubtitleMenu() {
        let retries = 20;
        const interval = setInterval(() => {
            const subtitleButton = document.querySelector(this.subtitleButtonSelector);
            if (!subtitleButton && retries > 0) {
                retries -= 1;
                return;
            }
            clearInterval(interval);
        }, 300);
    }
    selectSubtitle() {
        const subtitles = document.querySelectorAll(this.subtitlesSelector);
        if (subtitles.length <= 1) {
            return false;
        }
        const subtitleTexts = Array.from(document.querySelectorAll(`${this.subtitlesSelector} > ${this.subtitleTextSelector}`));
        if (subtitles[0].dataset.uia.includes("selected")) {
            let index = subtitleTexts.findIndex((element) => element.textContent.toLowerCase().startsWith("englis"));
            if (index === 0) {
                index = subtitleTexts.findIndex((element) => this.textSubtitlesOff.includes(element.textContent.toLowerCase()));
            }
            index = index < 1 ? 1 : index;
            subtitleTexts[index].click();
        }
        else {
            subtitleTexts[0].click();
        }
        return true;
    }
}
exports["default"] = ToggleSubtitleAction;


/***/ }),
/* 9 */
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const Options_1 = __webpack_require__(3);
class ToggleHelpAction {
    constructor() {
        this.key = Options_1.options.toggleHelp;
        this.isOpen = false;
        this.shortcuts = {
            h: "Show or hide this help message",
            "+": "Zoom in",
            "-": "Zoom out",
            ",": "16:9 (reset to default Netflix zoom)",
            ".": "21:9",
            c: "Custom zoom (zoom amount can be set in extension options)",
            d: "Disable mouse (prevent mouse movements from showing Netflix player controls)",
            e: "Enable mouse (also works with escape key)",
            q: "Toggle video statistics: FPS (frames per second) and resolution",
            v: "Toggle english subtitles (only Netflix in english or german is supported)",
        };
    }
    execute(videoController) {
        if (!videoController.getHtmlVideo) {
            this.isOpen = false;
            return;
        }
        if (this.isOpen) {
            this.isOpen = false;
            const helpElement = document.querySelector(".bn_help_container");
            if (helpElement) {
                videoController.getHtmlVideo.parentElement.removeChild(helpElement);
                return;
            }
        }
        const container = document.createElement("div");
        container.classList.add("bn_help_container");
        for (const [shortcut, description] of Object.entries(this.shortcuts)) {
            container.appendChild(this.createShortcutElement(shortcut, description));
        }
        videoController.getHtmlVideo.parentElement.appendChild(container);
        this.isOpen = true;
    }
    createShortcutElement(shortcut, description) {
        const shortcutContainer = document.createElement("div");
        shortcutContainer.classList.add("bn_shortcut_container");
        const shortcutElement = document.createElement("span");
        shortcutElement.classList.add("bn_shortcut");
        shortcutElement.textContent = shortcut;
        const descriptionElement = document.createElement("span");
        descriptionElement.textContent = description;
        shortcutContainer.appendChild(shortcutElement);
        shortcutContainer.appendChild(descriptionElement);
        return shortcutContainer;
    }
}
exports["default"] = ToggleHelpAction;


/***/ }),
/* 10 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const UiButtonController_1 = __importDefault(__webpack_require__(11));
class UiController {
    createUi(videoController) {
        const netflixButtons = this.getNetflixButtonParent();
        if (!netflixButtons || document.querySelector(".uiContainer"))
            return;
        const uiContainer = new UiButtonController_1.default().initButtons(videoController);
        netflixButtons.insertBefore(uiContainer.element, netflixButtons.children[2]);
    }
    updateTitle() {
        const videoTitle = this.getVideoTitle();
        if (!videoTitle)
            return;
        const titleChildren = videoTitle.childNodes;
        if (!titleChildren || titleChildren.length === 0)
            return;
        const title = Array.from(titleChildren)
            .map((child) => child.textContent)
            .join(" ");
        document.title = title;
    }
    hideMobileGames() {
        const element = document.querySelector(".mobile-games-row");
        if (element && !element.classList.contains("hidden")) {
            element.classList.add("hidden");
        }
        const bilboardElement = document.querySelector(".billboard-row-games");
        if (bilboardElement) {
            bilboardElement.classList.add("hidden");
            const video = bilboardElement.querySelector("video");
            if (video) {
                video.pause();
                video.onplay = () => video.pause();
            }
        }
    }
    hideOtherGames() {
        const element = document.querySelector('[data-list-context="configbased_cloudpersonalizedgames"]');
        if (element && !element.classList.contains("hidden")) {
            element.classList.add("hidden");
        }
    }
    getNetflixButtonParent() {
        return document.querySelector("div.watch-video--bottom-controls-container > div > div > div > div > div:nth-child(3) > div");
    }
    getVideoTitle() {
        return document.querySelector("div.watch-video--bottom-controls-container > div > div > div:nth-child(3) > div > div:nth-child(2) > div:nth-child(2) > div");
    }
}
exports["default"] = UiController;


/***/ }),
/* 11 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const ButtonElement_1 = __importDefault(__webpack_require__(12));
const ContainerElement_1 = __importDefault(__webpack_require__(14));
const Options_1 = __webpack_require__(3);
var ButtonType;
(function (ButtonType) {
    ButtonType[ButtonType["ZoomIn"] = 1] = "ZoomIn";
    ButtonType[ButtonType["ZoomOut"] = 2] = "ZoomOut";
    ButtonType[ButtonType["ResetZoom"] = 3] = "ResetZoom";
    ButtonType[ButtonType["FullZoom"] = 4] = "FullZoom";
    ButtonType[ButtonType["CustomZoom"] = 5] = "CustomZoom";
    ButtonType[ButtonType["PictureInPicture"] = 6] = "PictureInPicture";
})(ButtonType || (ButtonType = {}));
class Button {
    constructor(buttonType, text, title, actionName = "", largeButton = false) {
        this.buttonType = buttonType;
        this.text = text;
        this.title = title;
        this.actionName = actionName;
        this.isLargeButton = largeButton;
        this.hiddenByUser = this.getOptionByButtonType();
    }
    getOptionByButtonType() {
        switch (this.buttonType) {
            case ButtonType.ZoomIn:
                return Options_1.options.hideZoomInButton;
            case ButtonType.ZoomOut:
                return Options_1.options.hideZoomOutButton;
            case ButtonType.ResetZoom:
                return Options_1.options.hideResetZoomButton;
            case ButtonType.FullZoom:
                return Options_1.options.hideFullZoomButton;
            case ButtonType.CustomZoom:
                return !Options_1.options.showCustomZoomButton;
            case ButtonType.PictureInPicture:
                return (document.pictureInPictureEnabled === undefined ||
                    !document.pictureInPictureEnabled ||
                    Options_1.options.hidePictureInPictureButton);
        }
    }
    createButtonElement(videoController) {
        if (this.hiddenByUser || this.actionName === "")
            return;
        const button = new ButtonElement_1.default(this.text, this.title, this.isLargeButton);
        button.addButtonClickListener(videoController, this.actionName);
        return button;
    }
}
class UiButtonController {
    initButtons(videoController) {
        const buttons = [];
        buttons.push(this.createButton(videoController, ButtonType.ZoomIn, "+", "Zoom in (Key: +)", "zoomIn"));
        buttons.push(this.createButton(videoController, ButtonType.ZoomOut, "-", "Zoom out (Key: -)", "zoomOut"));
        buttons.push(this.createButton(videoController, ButtonType.ResetZoom, "16:9", "Reset zoom (Key: ,)", "resetZoom", true));
        buttons.push(this.createButton(videoController, ButtonType.FullZoom, "21:9", "Zoom to 21:9 (Key: .)", "fullZoom", true));
        buttons.push(this.createButton(videoController, ButtonType.CustomZoom, "C", "Custom zoom (Key: c)", "customZoom"));
        buttons.push(this.createButton(videoController, ButtonType.PictureInPicture, "◲", "Picture in Picture", "pictureInPicture"));
        return new ContainerElement_1.default(...buttons.filter((button) => button !== undefined));
    }
    createButton(videoController, buttonType, text, title, actionName, largeButton = false) {
        const button = new Button(buttonType, text, title, actionName, largeButton);
        return button.createButtonElement(videoController);
    }
}
exports["default"] = UiButtonController;


/***/ }),
/* 12 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const ActionController_1 = __webpack_require__(6);
const UiElement_1 = __importDefault(__webpack_require__(13));
class ButtonElement extends UiElement_1.default {
    constructor(text, title, largeButton = false) {
        super();
        this._element = document.createElement("div");
        this.addClasses("uiContainer");
        this.addButton(text, title, largeButton);
    }
    addButton(text, title, largeButton) {
        const button = document.createElement("button");
        button.textContent = text;
        button.classList.add("uiButtons");
        button.title = title;
        if (largeButton)
            button.classList.add("largeUiButtons");
        this._element.appendChild(button);
    }
    addButtonClickListener(videoController, actionName) {
        this._element.addEventListener("click", (event) => {
            event.stopPropagation();
            const action = ActionController_1.ActionFactory.getAction(actionName);
            if (action) {
                action.execute(videoController);
            }
        }, false);
    }
}
exports["default"] = ButtonElement;


/***/ }),
/* 13 */
/***/ ((__unused_webpack_module, exports) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
class UiElement {
    get element() {
        return this._element;
    }
    get parent() {
        return this._element.parentElement;
    }
    addClasses(...classes) {
        this._element.classList.add(...classes);
    }
    removeClasses(...classes) {
        this._element.classList.remove(...classes);
    }
    containsAnyClass(...classes) {
        return classes.some((c) => this._element.classList.contains(c));
    }
    hide() {
        if (!this.containsAnyClass("hidden"))
            this.addClasses("hidden");
    }
    show() {
        if (this.containsAnyClass("hidden"))
            this.removeClasses("hidden");
    }
    addChildren(...children) {
        children.forEach((child) => this._element.appendChild(child.element));
    }
    addHtmlChildren(...children) {
        children.forEach((child) => this._element.appendChild(child));
    }
    addEventListener(event, listener) {
        this._element.addEventListener(event, listener, false);
    }
}
exports["default"] = UiElement;


/***/ }),
/* 14 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const UiElement_1 = __importDefault(__webpack_require__(13));
class ContainerElement extends UiElement_1.default {
    constructor(...children) {
        super();
        this._element = document.createElement("div");
        this.addClasses("uiContainer");
        this.addChildren(...children);
    }
}
exports["default"] = ContainerElement;


/***/ }),
/* 15 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const TimeModel_1 = __importDefault(__webpack_require__(16));
const Options_1 = __webpack_require__(3);
class TimeUiController {
    constructor() {
        this.timeRemainingSelector = "[data-uia=controls-time-remaining]";
        this._timeModel = new TimeModel_1.default();
    }
    initTime(video) {
        if (!Options_1.options.timeElapsed ||
            document.querySelector("time.elapsedTime") ||
            !video) {
            return;
        }
        const timeRemaining = document.querySelector(this.timeRemainingSelector);
        if (timeRemaining) {
            this._video = video;
            this.initElapsedTime(timeRemaining.parentElement);
        }
    }
    initElapsedTime(parent) {
        this._htmlTime = document.createElement("time");
        this._htmlTime.classList.add("elapsedTime");
        this.updateTime();
        parent.style.display = "block";
        parent.prepend(document.createElement("hr"));
        parent.prepend(this._htmlTime);
        this._video.addEventListener("timeupdate", () => {
            this.updateTime();
        }, false);
    }
    updateTime() {
        if (this._video !== undefined) {
            this._timeModel.setCurrentTime(this._video.currentTime);
            this._htmlTime.textContent = this._timeModel.toString();
        }
    }
}
exports["default"] = TimeUiController;


/***/ }),
/* 16 */
/***/ ((__unused_webpack_module, exports) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
class TimeModel {
    get hours() {
        return this._hours;
    }
    get minutes() {
        return this._minutes;
    }
    get seconds() {
        return this._seconds;
    }
    setCurrentTime(currentSeconds) {
        this._hours = Math.floor(currentSeconds / 60 / 60);
        this._minutes = Math.floor(currentSeconds / 60);
        this._seconds = Math.floor(currentSeconds - this._minutes * 60);
        this._minutes -= this._hours * 60;
    }
    toString() {
        return ((this._hours > 0
            ? this._hours + ":" + this.addLeadingZero(this._minutes)
            : this._minutes) +
            ":" +
            this.addLeadingZero(this._seconds));
    }
    addLeadingZero(number) {
        return ((number + "").length < 2 ? "0" : "") + number;
    }
}
exports["default"] = TimeModel;


/***/ }),
/* 17 */
/***/ ((__unused_webpack_module, exports) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.randomVideo = randomVideo;
const btnClass = "bn_btn";
function randomVideo() {
    if (location.href !== "https://www.netflix.com/browse/my-list" ||
        document.querySelector(`.${btnClass}`)) {
        return;
    }
    const button = document.createElement("button");
    button.textContent = "Pick random video";
    button.classList.add(btnClass);
    button.addEventListener("click", () => {
        const allVideos = document.querySelectorAll(".rowContainer .slider-item");
        if (allVideos.length <= 0)
            return;
        const randomContainer = allVideos[Math.floor(Math.random() * allVideos.length + 1) - 1];
        const randomVideo = randomContainer.querySelector("a");
        randomVideo.scrollIntoView({ behavior: "smooth", block: "center" });
        randomContainer.classList.add("bn_border");
    });
    const container = document.createElement("div");
    container.appendChild(button);
    document.querySelector(".sub-header-wrapper").appendChild(container);
}


/***/ }),
/* 18 */
/***/ ((__unused_webpack_module, exports) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const titleSelector = "div.about-header > h3 > strong";
const buttonParentSelector = "div.previewModal--detailsMetadata-left > div > div";
const btnClass = "bn_imdb_btn";
class ImdbController {
    constructor() {
        this.interval = undefined;
    }
    init() {
        this.interval = setInterval(() => {
            if (ImdbController.addImdbButton()) {
                clearInterval(this.interval);
                this.interval = undefined;
            }
        }, 500);
    }
    static addImdbButton() {
        if (!(location.href.includes("jbv=") ||
            location.href.includes("/title/")) ||
            document.querySelector(`.${btnClass}`)) {
            return false;
        }
        const buttonParentElement = document.querySelector(buttonParentSelector);
        if (!buttonParentElement)
            return false;
        const titleElement = document.querySelector(titleSelector);
        if (!titleElement)
            return false;
        const title = encodeURIComponent(titleElement.textContent);
        const button = document.createElement("button");
        button.textContent = "IMDb";
        button.classList.add(btnClass);
        button.addEventListener("click", () => window.open(`https://www.imdb.com/find?q=${title}`, "_blank"));
        buttonParentElement.insertBefore(button, buttonParentElement.firstChild);
        return true;
    }
}
exports["default"] = ImdbController;


/***/ })
/******/ 	]);
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module is referenced by other modules so it can't be inlined
/******/ 	var __webpack_exports__ = __webpack_require__(0);
/******/ 	
/******/ })()
;