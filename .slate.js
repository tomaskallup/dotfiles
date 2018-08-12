/* eslint-disable */

/* ================================== *
 * Configuration                      *
 * ================================== */
slate.config('orederScreensLeftToRight', true);
slate.config('windowHintsShowIcons', true);

/* ==================================
 * Variables *
 * ================================== */
var edgeSpacing = 4, // Spacing from edgdes of screen
    middleSpacing = 2, // Spacing between windows
    baseSizeDiff = edgeSpacing * 2,
    sizeDiff = baseSizeDiff + middleSpacing;

/* Left & right halves */
var leftHalf = slate.op('move', {
    x: 'screenOriginX + ' + edgeSpacing,
    y: 'screenOriginY + ' + edgeSpacing,
    width: 'screenSizeX/2 - ' + sizeDiff/2,
    height: 'screenSizeY - ' + baseSizeDiff
});
var rightHalf = leftHalf.dup({
    x: 'screenOriginX + screenSizeX/2 + ' + middleSpacing,
});

/* Center with edge spacing */
var center = slate.op('move', {
    x: 'screenOriginX + ' + edgeSpacing,
    y: 'screenOriginY + ' + edgeSpacing,
    width: 'screenSizeX - ' + edgeSpacing * 2,
    height: 'screenSizeY - ' + edgeSpacing * 2
});

/* Center with 70% width & height */
var centerSmaller = slate.op('move', {
    x: 'screenOriginX + screenSizeX * 0.15',
    y: 'screenOriginY + screenSizeY * 0.15',
    width: 'screenSizeX * 0.7',
    height: 'screenSizeY * 0.7'
});

/* Center with 40% width & 35% height */
var centerTiny = slate.op('move', {
    x: 'screenOriginX + screenSizeX * 0.30',
    y: 'screenOriginY + screenSizeY * 0.375',
    width: 'screenSizeX * 0.4',
    height: 'screenSizeY * 0.35'
});

/* Top & bottom */
var topHalf = slate.op('move', {
    x: 'screenOriginX + ' + edgeSpacing,
    y: 'screenOriginY + ' + edgeSpacing,
    width: 'screenSizeX - ' + baseSizeDiff,
    height: 'screenSizeY/2 - ' + sizeDiff/2
});
var bottomHalf = topHalf.dup({
    y: 'screenOriginY + screenSizeY/2 + ' + edgeSpacing
});

/* Screen move */
var screenMove = slate.op('move', {
    x: 'screenOriginX + ' + edgeSpacing,
    y: 'screenOriginY + ' + edgeSpacing,
    width: 'screenSizeX - ' - (edgeSpacing * 2),
    height: 'screenSizeY - ' - (edgeSpacing * 2)
});

/* ==================================
 * Slate related binding *
 * ================================== */
slate.bind('r:ctrl,alt', slate.op('relaunch'));
slate.bind('u:ctrl,alt', slate.op('undo'));

/* ==================================
 * Window manipulation *
 * ================================== */

/* Basic window moving (top, right, bottom, left) by halves */
slate.bind('h:ctrl', leftHalf);
slate.bind('l:ctrl', rightHalf);
slate.bind('k:ctrl', topHalf);
slate.bind('j:ctrl', bottomHalf);

/* Move window to previous screen */
slate.bind('h:ctrl,shift', function (win) {
    var currentScreen = slate.screen(),
        currentId = currentScreen.id(),
        next = --currentId < slate.screenCount() - 1 ? 0 : currentId,
        targetScreen = slate.screenForRef(''+next),
        targetRect = targetScreen.rect(),
        currentRect = currentScreen.rect(),
        winPos = win.topLeft(),
        size = win.size();

    var pos = {
        x: targetRect.x + winPos.x - currentRect.x,
        y: targetRect.y + winPos.y - currentRect.y,
    };

    win.move({
        x: '' + pos.x,
        y: '' + pos.y,
        width: '' + size.width,
        height: '' + size.height,
        screen: '' + next
    });
});

/* Move window to next screen */
slate.bind('l:ctrl,shift', function (win) {
    var currentScreen = slate.screen(),
        currentId = currentScreen.id(),
        next = ++currentId > slate.screenCount() - 1 ? 0 : currentId,
        targetScreen = slate.screenForRef(''+next),
        targetRect = targetScreen.rect(),
        currentRect = currentScreen.rect(),
        winPos = win.topLeft(),
        size = win.size();

    var pos = {
        x: targetRect.x + winPos.x - currentRect.x,
        y: targetRect.y + winPos.y - currentRect.y,
    };

    win.move({
        x: '' + pos.x,
        y: '' + pos.y,
        width: '' + size.width,
        height: '' + size.height,
        screen: '' + next
    });
});

/* Hide window (move out of screen bounds) */
slate.bind('m:ctrl,shift', function (win) {
    var currentScreen = slate.screen(),
        screenRect = currentScreen.rect();

    var pos = {
        x: screenRect.x,
        y: screenRect.y + screenRect.height - 1
    };

    win.move(pos);
});

/* Unhide window (move back to screen bounds) */
slate.bind('n:ctrl,shift', function () {
    var currentScreen = slate.screen(),
        screenRect = currentScreen.rect();

    var pos = {
        x: screenRect.x,
        y: screenRect.y + screenRect.height - 1
    };

    var targetWindow = slate.windowUnderPoint(pos);

    if (targetWindow) {
        targetWindow.doOperation(centerTiny); // Could be more dynamic to preserve position & size
    }
});

/* Center current window with full size */
slate.bind('space:ctrl', slate.op('chain', {
    operations: [
        center,
        centerSmaller,
        centerTiny
    ]
}));
slate.bind('space:ctrl,shift', centerSmaller);
slate.bind('space:ctrl,alt,shift', centerTiny);

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

/* ==================================
 * Events *
 * ================================== */
slate.on('windowOpened', function(event, win) {
    if (win.app().name() === 'iTerm2') {
        win.doOperation(centerTiny);
    }
});
