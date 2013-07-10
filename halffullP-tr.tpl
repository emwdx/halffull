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
   <div class = "span12">
    <h1><p class = "text-center">Here are your results together with everyone else. <br> Click and drag the blue area to see how close you were.</p></h1>
    </div>
    </div>
    <div class = "row-fluid">
    <div class = "span12">
     <div id = "percentDisplay" style = "width:200px; margin-left:auto; margin-right:auto; margin-top: 30px;margin-bottom:30px; float: none; ">
   <h1><p class = "text-center" style = "color:#004DBF; font-size:48px;" id = "percent"></p></h1>
   </div>
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
    <p class = "text-center"><a href = "/halffull/4P/"><button type = "submit" id = "submitButton" class = "btn btn-primary" style = "color:#FFFFFF; background:#004DBF"><h1>Next</h1></button></a></p>
    
</body>

<script>

var triangleArea = (1/2)*800*190;
var paper = new Raphael(document.getElementById('display'), 900, 220);
var bkTriangle = paper.path('M 0 200 L 800 200 L 800 10 z').attr({fill:"#B5C1E8", stroke:0});

var colorTriangle = paper.path('M 0 100 L 0 200 L 0 10 z').attr({fill:"#004DBF",stroke:0});
$(function() {
		$( "#colorSlider").slider({
			orientation: "horizontal",
			//range: "min",
			max: 800,
			value: 100,
			slide: showValue,
			create: startValue
			
		});
		
		$( "#colorSlider" ).slider( "value", 50 );
	
	});	

window.onload = function () {
   		//drawYourValue();
/*   		$("#submitButton").click(function(){
		var sliderValue = $( "#colorSlider" ).slider( "value" );
		localStorage.setItem("triangle", 100*sliderValue/800);
		
		
	
	
	
	});*/
    
};
function processData(response){
		
		
		for (var i = 0;i<response.length;i++){
		var responsePosition = response[i][2]*8;
		
		paper.path('M ' + String(responsePosition)+ ' 200 L ' + String(responsePosition) + ' 10 z').attr({stroke:"#FFFFFF", 'opacity':String(5/response.length),'stroke-width':'3'});
		
		};
		drawYourValue();
		
}
function showValue(){
var sliderValue = $( "#colorSlider" ).slider( "value" );
var newPath = 'M 0 200 L ' + (sliderValue) + ' 200 L ' + (sliderValue) + ' ' + (200-190*sliderValue/800) + ' z';

var percent = 0.5*sliderValue*(190*sliderValue/800)*100/triangleArea;
var divP = document.getElementById('percent')
divP.innerHTML=Math.round(percent) + '%';


colorTriangle.attr({path:newPath});



}
function startValue(){

var sliderValue = $( "#colorSlider" ).slider( "value" );
var newPath = 'M 0 200 L ' + (sliderValue) + ' 200 L ' + (sliderValue) + ' ' + (200-190*sliderValue/800) + ' z';
colorTriangle.attr({path:newPath});

var percent = 0.5*sliderValue*(190*sliderValue/800)*100/triangleArea;
var divP = document.getElementById('percent')
divP.innerHTML=Math.round(percent) + '%';

}
function drawYourValue(){
myRect = localStorage.getItem("triangle")*8;
myLine = paper.path('M ' + myRect+' 200 L ' + myRect + ' 10 z').attr({stroke:"#FFFFFF",'stroke-dasharray':"-",'stroke-width':'4'});
myText = paper.text(myRect,210,"You").attr({'font-size':"20",fill:"#B5C1E8"});		


}
</script>
<script src="/halffull/data/?callback=processData"></script>
