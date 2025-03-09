// ==UserScript==
// @name         Autoswipe Match.com
// @description  Auto swiper for match.com
// @namespace    Match
// @match        https://www.match.com/home
// @version      1.0
// @grant        none
// ==/UserScript==

setInterval(() => {
  let btns = document.getElementsByTagName("button");

  if (!btns) return;

  let nextBtn;

  for (let btn of btns) {
    if (btn.innerHTML.includes("like")) {
      nextBtn = btn;
      break;
    }

    if (btn.innerHTML.includes("Skip")) {
      nextBtn = btn;
    }
  }

  nextBtn.click();
}, 1000);
