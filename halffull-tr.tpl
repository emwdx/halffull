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
    <p class = "text-center"><a href = "/halffull/4/"><button type = "submit" id = "submitButton" class = "btn btn-primary" style = "color:#FFFFFF; background:#004DBF"><h1>Submit</h1></button></a></p>
    </div>
    </div>

    </div>
</body>

<script>
var paper = new Raphael(document.getElementById('display'), 900, 200);
var bkTriangle = paper.path('M 0 200 L 800 200 L 800 10 z').attr({fill:"#B5C1E8", stroke:0});

var colorTriangle = paper.path('M 0 100 L 0 200 L 0 10 z').attr({fill:"#004DBF",stroke:0});
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
   	
   		$("#submitButton").click(function(){
		var sliderValue = $( "#colorSlider" ).slider( "value" );
		localStorage.setItem("triangle", 100*sliderValue/800);
		
		
	
	
	
	});
    
};
function showValue(){
var sliderValue = $( "#colorSlider" ).slider( "value" );
var newPath = 'M 0 200 L ' + (sliderValue) + ' 200 L ' + (sliderValue) + ' ' + (200-190*sliderValue/800) + ' z';


colorTriangle.attr({path:newPath});



}

</script>
   
