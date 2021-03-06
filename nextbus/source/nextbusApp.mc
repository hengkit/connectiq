using Toybox.Application as App;
using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;

class nextbusApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	var agency = "sf-muni";
    	var service = "L";
    	var stop = "6615";
        var url = "http://webservices.nextbus.com/service/publicJSONFeed?command=predictions&useShortTitles=true&a="+agency+"&r="+service+"&s="+stop;
    	Comm.makeWebRequest(url, {}, {}, method(:onResponse));
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new nextbusView() ];
    }
	function onResponse(responseCode, data) {
		if(responseCode == 200) {
			route.name = data["predictions"]["routeTitle"];
			//check the size of direction
			System.println(data["predictions"]["direction"].size());
			if(data["predictions"]["direction"]["title"].toString().find("Outbound") != null) {
				route.direction = "Outbound";
			} else {
				route.direction = "Inbound";
			}
			var limit = 3;
			if (data["predictions"]["direction"]["prediction"].size() < limit){
				limit = data["predictions"]["direction"][0]["prediction"].size();
			}
			for (var x =0; x<limit; x+=1){
				if(data["predictions"]["direction"]["prediction"][x]["minutes"] != null){
					route.next[x] = data["predictions"]["direction"]["prediction"][x]["minutes"];
				}
			}
			Ui.requestUpdate();
			
		}
	}
}