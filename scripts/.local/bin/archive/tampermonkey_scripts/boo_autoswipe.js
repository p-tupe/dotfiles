// ==UserScript==
// @name         Boo.world Auto Swipe
// @description  Auto Swiper for Boo
// @namespace    Boo
// @match        https://boo.world/match
// @icon         https://www.google.com/s2/favicons?sz=64&domain=boo.world
// @version      1.0
// @grant        none
// ==/UserScript==

(function () {
  "use strict";
  setInterval(() => document.querySelector("div.w-16:nth-child(3)").click(), 1000);
})();
