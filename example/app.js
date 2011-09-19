// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

// open a single window with repeated-backgound image.
var window = Ti.UI.createWindow({
	repeatedBarImage:'dgrey023.gif',
	repeatedBackgroundImage:'128-128.jpg',
	title:'Repeated Bar Image',
    orientationModes: [
        Ti.UI.LANDSCAPE_LEFT,
        Ti.UI.LANDSCAPE_RIGHT,
        Ti.UI.PORTRAIT,
        Ti.UI.UPSIDE_PORTRAIT
    ]
});

Ti.Gesture.addEventListener('orientationchange', function(e) {
//    window.repeatedBarImage = null;
//    window.repeatedBarImage = 'dgrey023.gif';
});

var label = Ti.UI.createLabel({
	text:'Repeated Background Image',
	width:'auto',
	height:'auto',
	textAlign:'center',
	color:'white'
});

window.add(label);

var tab = Ti.UI.createTab({
	window:window
});

var tabGroup = Ti.UI.createTabGroup();
tabGroup.addTab(tab);
tabGroup.open();