;(function () {
    "use strict"

    const volumeMouseWheel = document.getElementById("volumeMouseWheel")
    const hideButtons = {
        zoomIn: document.querySelector("#hide-zoom-in"),
        zoomOut: document.querySelector("#hide-zoom-out"),
        resetZoom: document.querySelector("#hide-reset-zoom"),
        fullZoom: document.querySelector("#hide-full-zoom"),
        pictureInPicture: document.querySelector("#hide-picture-in-picture"),
    }
    const customZoom = {
        checkbox: document.getElementById("customZoom"),
        amountInput: document.getElementById("customZoomAmount"),
    }
    const autoSkipIntro = document.getElementById("autoSkipIntro")
    const autoSkipRecap = document.getElementById("autoSkipRecap")
    const elapsedTime = document.getElementById("elapsedTime")
    const updateTabTitle = document.getElementById("updateTabTitle")
    const hideMobileGames = document.getElementById("hideMobileGames")
    const hideOtherGames = document.getElementById("hideOtherGames")

    const defaults = {
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
    }

    function restoreSavedOptions() {
        chrome.storage.sync.get(defaults, setValuesOfAllPreferences)
    }

    function setValuesOfAllPreferences(items) {
        volumeMouseWheel.checked = items.volumeMouseWheel

        hideButtons.zoomIn.checked = items.hideZoomInButton
        hideButtons.zoomOut.checked = items.hideZoomOutButton
        hideButtons.resetZoom.checked = items.hideResetZoomButton
        hideButtons.fullZoom.checked = items.hideFullZoomButton
        hideButtons.pictureInPicture.checked = items.hidePictureInPictureButton

        customZoom.checkbox.checked = items.showCustomZoomButton
        customZoom.amountInput.value = items.customZoomAmount || 0

        autoSkipIntro.checked = items.autoSkip
        autoSkipRecap.checked = items.autoSkipRecap
        elapsedTime.checked = items.elapsedTime
        updateTabTitle.checked = items.updateTabTitle
        hideMobileGames.checked = items.hideMobileGames
        hideOtherGames.checked = items.hideOtherGames
    }

    function init() {
        initAutoSave()

        document
            .getElementById("reset")
            .addEventListener("click", resetOptions, false)
    }

    function initAutoSave() {
        volumeMouseWheel.addEventListener(
            "change",
            (event) => save({ volumeMouseWheel: event.target.checked }),
            false,
        )

        hideButtons.zoomIn.addEventListener(
            "change",
            (event) => save({ hideZoomInButton: event.target.checked }),
            false,
        )
        hideButtons.zoomOut.addEventListener(
            "change",
            (event) => save({ hideZoomOutButton: event.target.checked }),
            false,
        )
        hideButtons.resetZoom.addEventListener(
            "change",
            (event) => save({ hideResetZoomButton: event.target.checked }),
            false,
        )
        hideButtons.fullZoom.addEventListener(
            "change",
            (event) => save({ hideFullZoomButton: event.target.checked }),
            false,
        )
        hideButtons.pictureInPicture.addEventListener(
            "change",
            (event) =>
                save({ hidePictureInPictureButton: event.target.checked }),
            false,
        )

        customZoom.checkbox.addEventListener(
            "change",
            (event) => save({ showCustomZoomButton: event.target.checked }),
            false,
        )
        customZoom.amountInput.addEventListener(
            "change",
            (event) => {
                const value = parseInt(event.target.value)
                if (value && value > -1) {
                    save({ customZoomAmount: value })
                }
            },
            false,
        )

        autoSkipIntro.addEventListener(
            "change",
            (event) => save({ autoSkip: event.target.checked }),
            false,
        )

        autoSkipRecap.addEventListener(
            "change",
            (event) => save({ autoSkipRecap: event.target.checked }),
            false,
        )

        elapsedTime.addEventListener(
            "change",
            (event) => save({ elapsedTime: event.target.checked }),
            false,
        )

        updateTabTitle.addEventListener(
            "change",
            (event) => save({ updateTabTitle: event.target.checked }),
            false,
        )

        hideMobileGames.addEventListener(
            "change",
            (event) => save({ hideMobileGames: event.target.checked }),
            false,
        )
        hideOtherGames.addEventListener(
            "change",
            (event) => save({ hideOtherGames: event.target.checked }),
            false,
        )
    }

    function resetOptions() {
        setValuesOfAllPreferences(defaults)
        save(defaults)
    }

    function save(obj) {
        chrome.storage.sync.set(obj)
    }

    window.addEventListener(
        "DOMContentLoaded",
        () => {
            restoreSavedOptions()
            init()
        },
        false,
    )
})()
