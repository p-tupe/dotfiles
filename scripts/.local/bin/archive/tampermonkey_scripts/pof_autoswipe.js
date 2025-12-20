// ==UserScript==
// @name         Plenty of Fish AutoLike
// @description  Auto Like Bot for PoF
// @namespace    Plenty of Fish
// @match        https://www.pof.com/meetme/
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @version      1.0
// @grant        none
// ==/UserScript==

setInterval(() => {
    let likeBtn = document.getElementById("meetmevotebutton-yes")
    if (likeBtn) likeBtn.click()
}, 1000)
