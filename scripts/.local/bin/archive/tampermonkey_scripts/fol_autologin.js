// ==UserScript==
// @name         FOL Auto-Login
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Automatic FOL Login
// @author       Pritesh Tupe
// @match        https://login.fanshawec.ca/idp/profile/SAML2/Redirect/SSO*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=fanshawec.ca
// @grant        none
// ==/UserScript==

(function () {
  "use strict";

  setTimeout(() => {
    document.getElementById("username").value = "p_tupe";
    document.getElementById("password").value = "";
    document.getElementsByName("_eventId_proceed")[0].click();
  }, 5000);
})();
