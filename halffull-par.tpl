<!DOCTYPE html>
<html lang="en">

<head>

<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="/static/raphael/raphael-min.js"></script>
<script src="/static/jqueryui/jquery.ui.touch-punch.min.js"></script>

<style>
#slider	.ui-slider-range { background: #729fcf; }
#slider .ui-slider-handle { border-color: #B5C1E8; }
</style>

<title>How much is half full?</title>

</head>

<body>
   
     
   <div class = "container">
  
   <div class = "row-fluid">
   <div class = "span8 offset2">
    <h1><p class = "text-center">Click and drag the blue area so that it fills <u>half</u> the shape.</p></h1>
    </div>
    </div>
    <div class = "row-fluid">
    <div class = "span12">
     <div id="display" style = "width:800px; margin-left:auto; margin-right:auto; margin-top: 20px;margin-bottom:20px; float: none; ">
        
    </div>
    </div>
    </div>
    <div class = "row-fluid">
    <div id="colorSlider" style = "width:800px; height:200px; opacity:0; margin-left:auto; margin-right:auto; margin-top: -220px; float: none; "></div>
    </div>
    </div>
    <div class = "container">
    <div class = "row-fluid" >
    <p class = "text-center"><button type = "submit" id = "submitButton" class = "btn btn-primary" style = "color:#FFFFFF; background:#004DBF"><h1>Submit</h1></button></p>
    </div>
    </div>

    </div>
</body>


<script>
var paper = new Raphael(document.getElementById('display'), 900, 200);
var parPath = f(0,200,400,200-evalParabola(400),800,0,0.5)

var bkParabola = paper.path(parPath).attr({fill:"#B5C1E8", stroke:0});
var colorPath = f(0,200,100,200-evalParabola(100),200,200 - evalParabola(200),0.5)

var colorParabola = paper.path(colorPath).attr({fill:"#004DBF",stroke:0});
$(function() {
		$( "#colorSlider").slider({
			orientation: "horizontal",
			//range: "min",
			max: 800,
			value: 100,
			slide: showValue,
			change: showValue
		});
		$( "#colorSlider" ).slider( "value", 50 );
	
	});	

window.onload = function () {
   	function surveyArray(rectangle, trapezoid, triangle, parabola){
   	this.rectangle=rectangle;
	this.trapezoid=trapezoid;
	this.triangle=triangle;
	this.parabola = parabola;
	};
	
	$("#submitButton").click(function(){
		var sliderValue = $( "#colorSlider" ).slider( "value" );
		localStorage.setItem("parabola", 100*sliderValue/800);
		 
		 rectangle = localStorage.getItem("rectangle");
		 trapezoid = localStorage.getItem("trapezoid");
		 triangle = localStorage.getItem("triangle");
		 parabola = localStorage.getItem("parabola");
		 results = new surveyArray(rectangle,trapezoid,triangle,parabola); 
		 data = JSON.stringify(results);
		 var request = new XMLHttpRequest();
  		 request.open("POST", 'http://apps.evanweinberg.org/ajax/');
  		 request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');

  		  // send the collected data as JSON
 		 request.send(data);

  		  request.onloadend = function () {
  		 document.location="/halffull/1P/";
  		};

		 	
	
	
	
	})
    
    
};
function showValue(){
var sliderValue = $( "#colorSlider" ).slider( "value" );
var newPath = f(0,200,(0.5*sliderValue),200 - evalParabola(0.5*sliderValue),sliderValue,200 - evalParabola(sliderValue),0.5)


colorParabola.attr({path:newPath});



}

function f(x0,y0,xc,yc,x2,y2,t){

	x1 = t^2*xc - 2*t*(1-t)*x0 - x2*(1-t)^2;
	y1 = t^2*yc - 2*t*(1-t)*y0 - y2*(1 - t)^2;  //700 200 L 0 200 z' ;
	
	parPath = 'M ' + x0 + ' ' + y0 + ' Q ' + x1 + ' ' + y1 + ' ' + x2 + ' ' + y2 + ' L '+ x2 + ' ' + y0 + ' L ' + x0 + ' ' + y0 + ' z' 
	return parPath

}

function evalParabola(x){
	value =  (x * x * 3 / 11000 + 105*x/3300);
	//alert(value);
	return value

}


</script>
   
