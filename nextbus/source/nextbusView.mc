using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
var route =  new busRoute();
class nextbusView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

	
    // Update the view
    function onUpdate(dc) {
    	if (route.name == null){
    		var view = View.findDrawableById("direction");
        	view.setText("Loading");
    	} else {
    		var view = View.findDrawableById("route");
        	view.setText(route.name);
        	view = View.findDrawableById("direction");
        	view.setText(route.direction);
        	for (var x = 0; x<3; x+=1){
        		view = View.findDrawableById("next"+x);
        		if(route.next[x].toNumber() <= 3){
        			view.setColor(Gfx.COLOR_RED);
        		}
        		view.setText(route.next[x]);
        	}
    	}
    	View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
