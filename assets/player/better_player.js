// ==UserScript==
// @name         better_player
// @description  Update the video player to be more mobile user friendly.
// @version      1.0.0
// @author       holy_crusader_py
// @match        https://www.fusevideo.io/e/*
// @run-at       document-body
// @grant        none
// ==/UserScript==


window.addEventListener("load", async () => {
    console.log("nekodroid_data:better_player");
    var controllBar = document.querySelector(".jw-controlbar.jw-reset");
    var sliderContainer = document.querySelector(".jw-slider-container.jw-reset");
    var buttonContainer = document.querySelector(".jw-reset.jw-button-container");

    // Control Bar
    controllBar.style.gap = "10px";
    controllBar.style.marginBottom = "10px";

    // Slider Container
    sliderContainer.style.height = "10px";

    var sliderDot = document.querySelector(".jw-knob.jw-reset");
    sliderDot.style.height = "18px";
    sliderDot.style.width = "18px";

    // Button Container
    buttonContainer.childNodes.forEach(button => {
        button.style.width = "50px";
        button.style.height = "50px";

        var svg = button.querySelectorAll("svg");
        svg.forEach(svgElem => {
            svgElem.style.width = "38px";
            svgElem.style.height = "38px";
        });
    });

    document.querySelectorAll(".jw-icon.jw-icon-inline.jw-button-color.jw-reset.jw-icon-fullscreen").forEach(fullscreenBtn => {
        fullscreenBtn.remove();
    });
});
