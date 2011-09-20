// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

// window backgoundImage and barImage.
var window1 = Ti.UI.createWindow({
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

var label = Ti.UI.createLabel({
	text:'Repeated Background Image',
	width:'auto',
	height:'auto',
	textAlign:'center',
	color:'white'
});

window1.add(label);
var tab1 = Ti.UI.createTab({
	window:window1,
	title:'window'
});

// tableViewRow backgroundImage
var window2 = Ti.UI.createWindow({
	title:'Row Background'
});

var tableView = Ti.UI.createTableView({
	repeatedBackgroundImage:'dgrey023.gif'
});

var tableViewRow = Ti.UI.createTableViewRow({
});
tableView.setData([tableViewRow]);

window2.add(tableView);

var tab2 = Ti.UI.createTab({
	window:window2,
	title:'table'
});


var tabGroup = Ti.UI.createTabGroup();
tabGroup.addTab(tab1);
tabGroup.addTab(tab2);
tabGroup.open();