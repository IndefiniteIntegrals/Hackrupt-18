<?php
$gender = $_POST['gender'];
$laim = $_POST['laim'];
$tin = $_POST['tin'];
$category = $_POST['category'];
$religion = $_POST['religion'];
$dob = $_POST['dob'];
$pincode = $_POST['pincode'];
$mstatus = $_POST['mstatus'];
$noyacr = $_POST['noyacr'];
$cri = $_POST['cri'];
$rent = $_POST['rent'];
$nod = $_POST['nod'];
$quali = $_POST['quali'];
$cscore = $_POST['cscore'];
$rstatus = $_POST['rstatus'];
$occu = $_POST['occu'];
$saolip = $_POST['saolip'];
$sal = $_POST['sal'];
$eap = $_POST['eap'];
$noyice = $_POST['noyice'];
$ami = $_POST['ami'];
$gmi = $_POST['gmi'];
$nmi = $_POST['nmi'];
$pvalue = $_POST['pvalue'];
$mvvalue = $_POST['mvvalue'];
$fd = $_POST['fd'];
$ppf = $_POST['ppf'];
$pf = $_POST['pf'];
$investments = $_POST['investments'];
$url = "http://192.168.78.45:7700/api/v1/web?Gender={$gender}&Dob={$dob}&PIN={$pincode}&Curr_res_yr={$noyacr}&Curr_res={$cri}&Rent={$rent}&Deps={$nod}&Marital={$mstatus}&Qualification={$quali}&Credit_score={$cscore}&Religion={$religion}&Category={$category}&Res_stat={$rstatus}&Occupation={$occu}&Salaried={$sal}&Avg_monthly_exp={$ami}&Prop={$pvalue}&Veh={$mvvalue}&FD={$fd}&PPF={$ppf}&PF={$pf}&Investments={$investments}&SLIP={$saolip}&Amt={$saolip}&Tenor={$tin}&Emp_pin={$eap}&Curr_emp_yr={$noyice}&Net_monthly_in={$nmi}&Gross_monthly_in={$gmi}";
$seconds = "500";
set_time_limit($seconds);
$out = file_get_contents($url);
$jsondecode = json_decode($out,true);
$out2 =  "There is {$jsondecode['prediction']} percent chance that the person will repay loan." ;
?>
  <!DOCTYPE html>
  <html>
    <head>
      <!--Import Google Icon Font-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css"  media="screen,projection"/>
	  <link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/4.0.1/dropzone.css">
	  	  <link type="text/css" rel="stylesheet" href="style.css">
	  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body>
	 <main>
  <nav class="red lighten-3">
    <div class="nav-wrapper container">
      <a href="#!" class="brand-logo">RAMP</a>
      <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
      <ul class="right hide-on-med-and-down">
	  <li><a href="index.html">HOME</a></li>
        <li><a href="about.html">ABOUT</a></li>
        <li><a href="team.html">TEAM</a></li>
      </ul>
      <ul class="side-nav" id="mobile-demo">
	  <li><a href="index.html">HOME</a></li>
        <li><a href="about.html">ABOUT</a></li>
        <li><a href="team.html">TEAM</a></li>
      </ul>
    </div>
  </nav>
	 <div class="section" id="banner-color">
  <div class="container">
    <div class="row">
      <div class="col s12 m9">
        <h1 class="header center-on-small-only" id="head-color">Predictor</h1>
      </div>
    </div>
  </div>
</div>
<div>
 <div>
 	 <div class="section" id="banner-color">
  <div class="container">
  <div class="card-panel">
      <span class="blue-text text-darken-2"><?php echo $out2; ?></span>
    </div>
            
 </main>	
			
			<!--Import jQuery before materialize.js-->
      <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/4.2.0/min/dropzone.min.js"></script>
	<script type='text/javascript' src='https://visual.blobcity.com/javascripts/api/viz_v1.js'></script>
<script type="text/javascript" >
	Dropzone.options.imageUpload = {
        maxFilesize:40,
        acceptedFiles: ".csv"
    };
	(function($){
	$(function(){

		$('.button-collapse').sideNav();
		$('select').material_select();

	}); // end of document ready
})(jQuery); // end of jQuery name space
     
</script>
</script>
    </body>
  </html>

