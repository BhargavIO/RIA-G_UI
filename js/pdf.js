function pdfToHTML(){
	var pdf=new jsPDF('p','pt','letter');
	source=$('body')[0];
	var imgData="Glaucoma.jpg"
	pdf.addImage(imgData, 'JPG', 15, 40, 180, 180);

	specialElementHandlers={'#bypassme':function(element,renderer){
		return true
	}
}
margins={
	top: 50,
	left: 60,
	width: 1245
};
pdf.fromHTML(
	source
	, margins.left
	,margins.top

	,{
		'width':margins.width
		,'elementHandlers':specialElementHandlers
	},
	function (dispose){
		pdf.save('Report.pdf');
	}
	)
}