/* eslint-disable */

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

/* Center current window */
slate.bind('space:ctrl', slate.op('move', {
    x: 'screenOriginX + ' + edgeSpacing,
    y: 'screenOriginY + ' + edgeSpacing,
    width: 'screenSizeX - ' + edgeSpacing * 2,
    height: 'screenSizeY - ' + edgeSpacing * 2
}));

/* Focus control */
slate.bind('f:ctrl', slate.op('hint'));
slate.bind('h:ctrl,alt', slate.op('focus', {direction: 'left'}));
slate.bind('l:ctrl,alt', slate.op('focus', {direction: 'right'}));
slate.bind('j:ctrl,alt', slate.op('focus', {direction: 'down'}));
slate.bind('k:ctrl,alt', slate.op('focus', {direction: 'up'}));
