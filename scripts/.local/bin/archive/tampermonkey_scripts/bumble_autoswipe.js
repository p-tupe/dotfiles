// ==UserScript==
// @name         Bumble Auto Swipe
// @description  Auto Swiper for Bumble
// @namespace    Bumble
// @match        https://bumble.com/app
// @icon         https://www.google.com/s2/favicons?domain=bumble.com
// @version      1.0
// @grant        none
// ==/UserScript==

setInterval(() => {
  const likeBtn = document.getElementsByClassName("encounters-action--like");

  if (!likeBtn || !likeBtn[0]) return;

  const evObj = document.createEvent("Events");
  evObj.initEvent("click", true, false);
  likeBtn[0].dispatchEvent(evObj);
}, 1000);
