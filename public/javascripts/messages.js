// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function css_browser_selector() {

  var h = document.documentElement;
  var c = detect_browser() + ' ' + detect_system();

  h.className += ' ' + c;

  return c;
};

function detect_system() {
  var ua = navigator.userAgent.toLowerCase();

  var is = function(t) {
    return ua.indexOf(t) > -1;
  }

  var system;

  if ( is('j2me') ) {
    system = 'mobile';
  }
  else if ( is('iphone') ) {
    system = 'iphone';
  }
  else if ( is('ipod') ) {
    system = 'ipod';
  }
  else if ( is('mac') ) {
    system = 'mac';
  }
  else if ( is('darwin') ) {
    system = 'mac';
  }
  else if ( is('webtv') ) {
    system = 'webtv';
  }
  else if ( is('win') ) {
    system = 'win';
  }
  else if ( is('freebsd') ) {
    system = 'freebsd';
  }
  else if ( is('x11')||is('linux') ) {
    system = 'linux';
  }
  else {
    system = 'js';
  }

  return system;
}

function detect_browser() {
  var ua = navigator.userAgent.toLowerCase();

  var is = function(t) {
    return ua.indexOf(t) > -1;
  }

  var g = 'gecko', w = 'webkit', s = 'safari', o ='opera';

  var browser;

  if ( !(/opera|webtv/i.test(ua)) && /msie\s(\d)/.test(ua) ) {
    browser = 'ie ie' + RegExp.$1;
  }
  else if ( is('firefox/2') ) {
    browser = g + ' ff2';
  }
  else if ( is('firefox/3.5') ) {
    browser = g + ' ff3 ff3_5';
  }
  else if ( is('firefox/3') ) {
    browser = g + ' ff3';
  }
  else if ( is('gecko/') ) {
    browser = g;
  }
  else if ( is('opera') && /version\/(\d+)/.test(ua) ) {
    browser = o + ' ' + o + RegExp.$1;
  }
  else if ( is('opera') && /opera(\s|\/)(\d+)/.test(ua) ) {
    browser = o + ' ' + o + RegExp.$2;
  }
  else if ( is('opera') ) {
    browser = o;
  }
  else if ( is('konqueror') ) {
    browser = 'konqueror';
  }
  else if ( is('chrome') ) {
    browser = w + ' chrome';
  }
  else if ( is('iron') ) {
    browser = w + ' iron';
  }
  else if ( is('applewebkit/') && /version\/(\d+)/.test(ua)) {
    browser = w + ' ' + s + ' ' + s + RegExp.$1;
  }
  else if ( is('applewebkit/') ) {
    browser = w + ' ' + s;
  }
  else if ( is('mozilla/') ) {
    browser = g;
  }

  return browser;
}

css_browser_selector();


function toggle_content(msg_id) {
  $('tr#content_of_' + msg_id).toggle();
  $('img#show_' + msg_id).toggle();
  $('img#hide_' + msg_id).toggle();
  return false;
}
