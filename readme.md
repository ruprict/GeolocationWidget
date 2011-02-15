# Geolocation Widget for ArcGIS Flex Viewer #

## Installation and Such ##

### Overview ###
The goal of this widget is to find the user's location and mark it on the map.  The widget attempts to use the HTML 5 Geolocation API, if it's available, and fallsback to the MaxMind javascript API (http://www.maxmind.com/app/javascript_city) if not.  The location is marked, and the user can zoom to that spot.

As an example of why someone would use this, I have added the ability to query a single Feature Service polygon layer.  You can specify the URL of this feature service, or just leave it blank if you do not want this function.  

### Approach ###
This widget is likely architected much differently than other widgets you've seen.  Good or bad, I decided to user the RobotLegs MVCS micro-architecture to create this widget.  My reasons are myriad (I like Robotlegs, it makes my stuff testable, I wanted to see if I could do it, etc.) and I'll likely blog about them in the coming days, so I won't bore you here (too late).  The consequences of this decision, unfortunately, make this widget's installation a bit move involved.  The gain is a cleaner separation of view and business logic, in my opinion, as well as seeing one way to test your widgets.  In other words, I like to think of this as a "teaching widget", and some of the things you'll (hopefully) learn are:

* How to use Robotlegs
* How to unit test your widgets using FlexUnit
* How to use ASMock to mock external concerns in your unit tests.
* How to use the HTML5 Geolocation API
* How to communicate between your Flex Widgets and javascript
* How to use the MaxMind API to fallback when HTML5 isn't an option (thank very much, IE)

You could very easily pull out the guts of this widget an make it just like all the ESRI widgets, architecturally speaking.  However, before you do, I would suggest you look at how this one is done, learn from it, and (even better) make it better (or tell me what I did wrong)

### Installation ###
As I said, the install of this widget is a bit more involved.  It's not TOO bad, but being comfortble building your FlexViewer from source is a prerequisite.  The installation instructions presume you are using FlashBuilder.

1. Download the ArcGIS [Flex Viewer 2.2 source] (http://www.arcgis.com/home/item.html?id=3f6a0bfee48949a88df50bf7686ec72a)
2. Extract the ArcGIS Flex Viewer source to a directory (we'll use c:\flexviewer in these instructions)
3. Extract the Geolocation widget zip archive to the root directory of your project (c:\flexviewer).  The code and libs should extract to their proper locations.  The folders are:
* compiled - The compiled widget
* src - Contains the widgets, com, and org source directories.
* assets 
* libs - the third party dependencies
4. Import the Flex Viewer project into Flash Builder.  Make sure you are using the Flex 4 SDK.
5. Modify the index.mxml (in the default package).  Add the following to the Declarations:
    <fx:Declarations>
        <esi:ApplicationContext contextView="{this}"/>
    </fx:Declarations>
You will also need to add the namespace to your Application tag:
    xmlns:esi="com.esi.*"

This is the context for Robotlegs.
6. Modify the html-template/index.template.html.  Add the following to the end of the body tag:
        <!-- GeoIP lookup from Maxmind.com -->
        <script language="JavaScript" src="http://j.maxmind.com/app/geoip.js"></script>
        <script type="text/javascript" src="geolocation.js"></script>
This includes the Maxmind jsapi and the javascript file used to find leverage the HTML Geolocation API.
7. Configure the widget.  Place this code in config.xml
    <!-- Image from harwen.net Drifting images -->
    <widget label="Geolocation" left="390" top="400"
        icon="assets/images/Network-Update.png" preload="open"
        config="widgets/Geolocation/GeolocationWidget.xml"
        url="widgets/Geolocation/GeolocationWidget.swf"/>
8. Add the Geolocation widget as a Flex Module to the Flex Viewer project.  In Flash Builder, right click on the FlexViewer project and select "Properties"  Select "Flex Modules", then Add, and navigate to GeolocationWidget.mxml.
9. Build the Viewer.

### Code and Libraries Included in the Archive ###
The following SWCs are included in the libs dir:

* [AS3Commons libs (reflect, lang, logging)] (http://www.as3commons.org/) 
* [ Robotlegs 1.4.0 ] (http://robotlegs.org)
* [ FlexUnit 4.0.0.2 ] (http://opensource.adobe.com/wiki/display/flexunit/FlexUnit) (This is actually included with Flash Builder 4, but I like to explicitly include it.)
* [ Hamcrest 1.0.2  ] (https://github.com/drewbourne/hamcrest-as3)

The following third party code is added to the code directory:

* [ Robotlogs Modular Utility ] (https://github.com/joelhooks/robotlegs-utilities-Modular)
* [Robotlegs Oil] (http://github.com/darscan/robotlegs-extensions-Oil)

### Issues ###
* This uses IP Geolocation, so accuracy is going to be either OK or way off.
* There is no way to refresh the location.  I may add this later.









