// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

// window backgoundImage and barImage.
var window = Ti.UI.createWindow({
	repeatedBarImage:'dgrey023.gif',
	repeatedBackgroundImage:'bg_pattern.png',
	title:'Repeated Bar Image',
    orientationModes: [
        Ti.UI.LANDSCAPE_LEFT,
        Ti.UI.LANDSCAPE_RIGHT,
        Ti.UI.PORTRAIT,
        Ti.UI.UPSIDE_PORTRAIT
    ]
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
	window:window,
	title:'window'
});

var tabGroup = Ti.UI.createTabGroup();
tabGroup.addTab(tab);
tabGroup.open();