// ==UserScript==
// @name         HDFC Enable Copy-Paste
// @namespace    sebas.tian
// @version      1.0.0
// @description  Re-enables copy/paste/select/right-click on HDFC sites (netbanking + retail). Strips oncopy/onpaste/oncontextmenu/onselectstart handlers, neutralizes JS-assigned ones, unblocks Ctrl+C/V/X/A.
// @author       Sebas Tian
// @match        https://*.hdfcbank.com/*
// @match        https://hdfcbank.com/*
// @match        https://netbanking.hdfcbank.com/*
// @run-at       document-start
// @grant        none
// ==/UserScript==

(function() {
  'use strict';

  var blockedAttrs = ['oncopy', 'oncut', 'onpaste', 'oncontextmenu', 'onselectstart', 'ondragstart', 'ondrop', 'onbeforecopy'];
  var blockedEvents = ['copy', 'cut', 'paste', 'contextmenu', 'selectstart', 'dragstart', 'drop', 'beforecopy'];

  function strip(el) {
    for (var i = 0; i < blockedAttrs.length; i++) {
      try { el.removeAttribute(blockedAttrs[i]); } catch (e) { }
    }
  }

  function stripAll(root) {
    strip(root);
    var all = root.querySelectorAll ? root.querySelectorAll('*') : [];
    for (var i = 0; i < all.length; i++) strip(all[i]);
  }

  // 1. Strip inline handler attributes now (document-start, so early) and forever (MutationObserver).
  stripAll(document);
  var mo = new MutationObserver(function(muts) {
    for (var i = 0; i < muts.length; i++) {
      var m = muts[i];
      if (m.type === 'attributes' && blockedAttrs.indexOf(m.attributeName) !== -1) {
        strip(m.target);
      } else if (m.type === 'childList') {
        for (var j = 0; j < m.addedNodes.length; j++) {
          var n = m.addedNodes[j];
          if (n.nodeType === 1) stripAll(n);
        }
      }
    }
  });
  mo.observe(document, { subtree: true, childList: true, attributes: true, attributeFilter: blockedAttrs });

  // 2. Neutralize JS-assigned handlers (el.oncopy = ... becomes a no-op).
  for (var i = 0; i < blockedAttrs.length; i++) {
    (function(attr) {
      try {
        Object.defineProperty(HTMLElement.prototype, attr, { set: function() { }, configurable: true });
      } catch (e) { }
    })(blockedAttrs[i]);
  }

  // 3. Capture-phase shield: our listener runs before the page's own handlers on the same node,
  //    stopPropagation keeps the event from reaching element-level blockers.
  for (var i = 0; i < blockedEvents.length; i++) {
    (function(evt) {
      document.addEventListener(evt, function(e) { e.stopPropagation(); }, true);
    })(blockedEvents[i]);
  }

  // 4. Let Ctrl/Cmd+C/V/X/A/S through even if a keydown handler tries to kill it.
  document.addEventListener('keydown', function(e) {
    if ((e.ctrlKey || e.metaKey) && ['c', 'v', 'x', 'a', 's'].indexOf(e.key.toLowerCase()) !== -1) {
      e.stopPropagation();
    }
  }, true);

  // 5. Re-apply to the document body once it exists (some pages build fields later).
  if (document.body) { stripAll(document.body); }
  document.addEventListener('DOMContentLoaded', function() { stripAll(document); });
})();
