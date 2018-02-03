/* eslint-disable */

/* ================================== *
 * Configuration                      *
 * ================================== */
slate.config('orederScreensLeftToRight', true);

/* ==================================
 * Variables *
 * ================================== */
var edgeSpacing = 2, // Spacing from edgdes of screen
    middleSpacing = 2, // Spacing between windows
    sizeDiff = edgeSpacing * 2 + middleSpacing;

/* Left & right halves */
var leftHalf = slate.op('move', {
    x: 'screenOriginX + ' + edgeSpacing,
    y: 'screenOriginY + ' + edgeSpacing,
    width: '(screenSizeX - ' + sizeDiff + ')/2',
    height: 'screenSizeY - ' + sizeDiff
});
var rightHalf = leftHalf.dup({
    x: 'screenOriginX + screenSizeX/2 + ' + edgeSpacing,
});

var center = slate.op('move', {
    x: 'screenOriginX + ' + edgeSpacing,
    y: 'screenOriginY + ' + edgeSpacing,
    width: 'screenSizeX - ' + edgeSpacing * 2,
    height: 'screenSizeY - ' + edgeSpacing * 2
});
var centerSmaller = slate.op('move', {
    x: 'screenOriginX + screenSizeX * 0.15',
    y: 'screenOriginY + screenSizeY * 0.15',
    width: 'screenSizeX * 0.7',
    height: 'screenSizeY * 0.7'
});

/* Top & bottom */
var topHalf = slate.op('move', {
    x: 'screenOriginX + ' + edgeSpacing,
    y: 'screenOriginY + ' + edgeSpacing,
    width: 'screenSizeX - ' + sizeDiff,
    height: '(screenSizeY - ' + sizeDiff + ')/2'
});
var bottomHalf = topHalf.dup({
    y: 'screenOriginY + screenSizeY/2 + ' + edgeSpacing
});

/* ==================================
 * Window manipulation *
 * ================================== */

/* Basic window moving (top, right, bottom, left) by halves */
slate.bind('h:ctrl', leftHalf);
slate.bind('l:ctrl', rightHalf);
slate.bind('k:ctrl', topHalf);
slate.bind('j:ctrl', bottomHalf);

/* Move window to screen */
slate.bind('h:ctrl,shift', function (win) {
    var currentId = slate.screen().id(),
        next = --currentId < 0 ? slate.screenCount() - 1 : currentId;

    win.doOperation(center.dup({
        screen: next
    }));
});
slate.bind('l:ctrl,shift', function (win) {
    var currentId = slate.screen().id(),
        next = ++currentId < slate.screenCount() - 1 ? 0 : currentId;

    win.doOperation(center.dup({
        screen: next
    }));
});

/* Center current window with full size */
slate.bind('space:ctrl', center);
/* Center window with 60%w & 50%h */
slate.bind('space:ctrl,shift', centerSmaller);

/* Focus control */
slate.bind('f:ctrl,alt', slate.op('hint'));
slate.bind('h:ctrl,alt', slate.op('focus', {direction: 'left'}));
slate.bind('l:ctrl,alt', slate.op('focus', {direction: 'right'}));
slate.bind('j:ctrl,alt', slate.op('focus', {direction: 'down'}));
slate.bind('k:ctrl,alt', slate.op('focus', {direction: 'up'}));
slate.bind('b:ctrl,alt', slate.op('focus', {direction: 'behind'}));

/* Predefined focus for most used apps */
slate.bind('1:ctrl', slate.op('focus', {app: 'iTerm2'}));
slate.bind('2:ctrl', slate.op('focus', {app: 'Firefox'}));
