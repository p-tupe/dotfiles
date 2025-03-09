// ==UserScript==
// @name         Tinder Auto Swipe
// @description  Auto Swiper for Tinder
// @namespace    Tinder
// @match        https://tinder.com/app/recs
// @require      http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js
// @version      1.0
// @grant        none
// ==/UserScript==

setInterval(() => {
  let btns = document.getElementsByClassName("button");

  if (!btns) return;

  for (let btn of btns) {
    if (btn.innerHTML.includes("background-like")) btn.click();
  }
}, 1000);
