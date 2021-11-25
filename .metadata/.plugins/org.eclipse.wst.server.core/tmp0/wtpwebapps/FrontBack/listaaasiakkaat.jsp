<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="css/tyyli.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>teht�v�4</title>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="6" class="oikealle"><span id="uusiAsiakas">Lis�� asiakas</span></th>
		</tr>
		<tr>
			<th colspan="3">Hakusana:</th>
			<th colspan="2"><input type="text" id="hakusana"></th>
			<th><input type="button" value="HAE" id="hakunappi"></th>
		</tr>
		<tr>
			<th>Asiakasnumero</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>
			<th>Poista</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	})
	
	haeAsiakkaat();
	
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	
	$(document.body).on("keydown", function(event){
		if(event.which==13){
			haeAsiakkaat();
		}
	});
	
	$("#hakusana").focus();
	
});

function haeAsiakkaat(){	
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), 
		type:"GET", 
		dataType:"json", 
		success:function(result){//Funktio palauttaa tiedot json-objektina		
			$.each(result.asiakkaat, function(i, field){  
	        	var htmlStr;
	        	htmlStr+="<tr id='rivi_"+field.asiakasID+"'>";
	        	htmlStr+="<td>"+field.asiakasID+"</td>";
	        	htmlStr+="<td>"+field.etunimi+"</td>";
	        	htmlStr+="<td>"+field.sukunimi+"</td>";
	        	htmlStr+="<td>"+field.puhelin+"</td>";  
	        	htmlStr+="<td>"+field.sposti+"</td>";
	        	htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakasID+"')>Poista</span></td>";
	        	htmlStr+="</tr>";
	        	$("#listaus tbody").append(htmlStr);
	        });
		}
	});
};

function poista(asiakasID){
	if(confirm("Poista asiakas " + asiakasID + "?")){
		$.ajax({url:"asiakkaat/"+asiakasID, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto ep�onnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+asiakasID).css("background-color", "red"); //V�rj�t��n poistetun asiakkaan rivi
	        	alert("Asiakkaan " + asiakasID +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
};

</script>
</body>
</html>