// ==UserScript==
// @name         OKCupid AutoLike
// @description  Auto Liker for OKCupid
// @namespace    OKCupid
// @match        https://www.okcupid.com/discover
// @version      1.0
// @grant       none
// ==/UserScript==

(function () {
  "use strict";
  setInterval(() => {
    let likeBtn = document.getElementsByClassName("like");
    if (likeBtn && likeBtn[0]) likeBtn[0].click();
  }, 1000);
})();
