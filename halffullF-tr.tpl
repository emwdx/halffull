<!DOCTYPE html>
<html lang="en">

<head>

<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">

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
   <div class = "span6 offset3">
    <h1><p class = "text-center">What percentage of the shape here is colored blue?</p></h1>
    </div>
    </div>
    <div class = "row-fluid">
    <div id="colorSlider" style = "width:800px;   margin-left:auto; margin-right:auto; margin-top:20px; margin-bottom: 20px; float: none; "></div>
   
    </div>
    <div class = "row-fluid">
    <div class = "span12">
     <div id = "percentDisplay" style = "width:200px; margin-left:auto; margin-right:auto; margin-top: 10px;margin-bottom:10px; float: none; ">
   <h1><p class = "text-center" style = "color:#004DBF; font-size:48px;" id = "percent"></p></h1>
   </div>
      <div id="display" style = "width:800px; margin-left:auto; margin-right:auto; margin-bottom:10px; float: none; ">
        
    </div>
    </div>
    </div>
    
    
    <div class = "container">
    <div class = "row-fluid" >
    <p class = "text-center"><a href = "#"><button type = "submit" id = "submitButton" class = "btn btn-primary" style = "color:#FFFFFF; background:#004DBF"><h1>Submit your answer.</h1></button></a></p>
    </div>
    </div>
  
</body>

<script>

var triangleArea = (1/2)*800*200;
var paper = new Raphael(document.getElementById('display'), 900, 200);
var bkTriangle = paper.path('M 0 200 L 800 200 L 800 10 z').attr({fill:"#B5C1E8", stroke:0});

var colorTriangle = paper.path('M 0 200 L 693 200 L 693 35.4 z').attr({fill:"#004DBF",stroke:0});

window.onload = function () {
			$("#colorSlider").slider({
			orientation: "horizontal",
			//range: "min",
			max: 800,
			value: 693,
			slide: showValue,
			change: showValue,
			create: startValue,
						
		});
   		startValue();
    
    function MyGuess(guess){
    this.myGuess = guess;
    
    
    }
    $("#submitButton").click(function(){
		var sliderValue = $( "#colorSlider" ).slider( "value" );
		var myGuess = new MyGuess(100*sliderValue/800);
		 
		 
		 data = JSON.stringify(myGuess);
		 
		 var request = new XMLHttpRequest();
  		 request.open("POST", '/myValue/');
  		 request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');

  		  // send the collected data as JSON
 		 request.send(data);

  		  request.onloadend = function () {
  		 alert("Thank you for your submission! Stay tuned to http://evanweinberg.com for a discussion of the results.")
  		 document.location="http://www.evanweinberg.com";
  		 
  		};

		 	
	
	
	
	})
};

function showValue(){
var sliderValue = $( "#colorSlider" ).slider( "value" );

var percent = sliderValue/800*100
var divP = document.getElementById('percent')
divP.innerHTML=Math.round(percent) + '%';




}
function startValue(){

var sliderValue = $( "#colorSlider" ).slider( "value" );


var percent = sliderValue/800*100
var divP = document.getElementById('percent')
divP.innerHTML=Math.round(percent) + '%';

}

</script>

