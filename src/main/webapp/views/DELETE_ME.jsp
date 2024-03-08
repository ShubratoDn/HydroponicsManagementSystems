    
<!DOCTYPE html>
<html>
<head>
<title>Invoice</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">

<!-- Google font-->
<link href="https://fonts.googleapis.com/css?family=Ubuntu:400,500,700"
	rel="stylesheet">
	
<!-- Required Fremwork -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/plugins/bootstrap/css/bootstrap.min.css">

<!-- Style.css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/main.css">

<!-- Responsive.css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/responsive.css">


</head>

<body style="background-color: white" >
	<section class="min-h-80vh" style="background-color: white">				
		<div class="content">		                
               <div class="row">
                   <div class="col-md-12">
                       
                           <table class="table table-borderless invoice-info-table">
                           		<tr>
                           			<td>
                           				<div class="company-info">
	                                       <img src="${pageContext.request.contextPath}/assets/images/favicon.png" class="inv-logo" alt="" style="width: 60px">
	                                       <ul class="list-unstyled">
	                                           <li class="font-bold"><b>LeafLab</b></li>
	                                           <li>Hydroponics Management System </li>
	                                           <li>Enayetpur, Sirajganj, Bangladesh</li>		                                            
	                                       </ul>
	                                   </div>
                           			</td>                           			
                           			<td>
                           				<div class="invoice-info">
	                                       <div class="invoice-details">
	                                           <h3 class="text-uppercase">Invoice #INV-001</h3>
	                                            <ul class="list-unstyled">
		                                        <li>Date: <span>2014-01-3</span></li>
		                                        <li>Due date: <span>2012-2-1</span></li>
		                                    </ul>
	                                       </div>
	                                   </div>
                           			</td>
                           		</tr>
                           		
                           		                           		
                           		
                           		<tr>                           			
                           			<td>
                           				<div>
									
											<h5>Invoice to:</h5>
											 <ul class="list-unstyled">
			                                    <li>
			                                        <h5><strong>Shurato Debnath</strong></h5>
			                                    </li>
			                                    <li><span>Gopinathpur, Enayetpur, Sirajganj</span></li>
			                                    <li>01759458961</li>
			                                    <li><a href="#">Shubratodn44985@gmail.com</a></li>
			                                </ul>
										
	                                   </div>
                           			</td>
                           			<td>
	                           			<div class="invoices-view">
											<span class="text-muted">Payment Details:</span>
											 <ul class="list-unstyled invoice-payment-details">
		                                        <li>
		                                            <h5>Total Due: TK. <span class="text-right">1000</span></h5>
		                                        </li>
		                                        <li>Status: Unpaid</li>
		                                    </ul>
										</div>
                           			</td>
                           		
                           		</tr>
                           		
                           </table> 
                           
                           <br>
                           
                                                         
                               <div class="table-responsive">
                                   <table class="table table-striped table-hover">
                                       <thead>
                                           <tr>
                                               <th>#</th>
                                               <th>ID</th>
                                               <th>ITEM</th>
                                               <th>DESCRIPTION</th>
                                               <th>UNIT COST</th>
                                               <th>QUANTITY</th>
                                               <th>TOTAL</th>
                                           </tr>
                                       </thead>
                                       <tbody>		                                        
                                       		                                            
                                       </tbody>
                                   </table>
                               </div>
                               <div>
                                   <div class="row invoice-payment">
                                       <div class="col-sm-7">
                                       </div>
                                       <div class="col-sm-5">
                                           <div class="m-b-20">
                                               <h6>Total due</h6>
                                               <div class="table-responsive no-border">
                                                   <table class="table mb-0">
                                                       <tbody>		                                                           
                                                           <tr>
                                                               <th>Total:</th>
                                                               <td class="text-right text-primary">
                                                                   <h5>Tk. </h5>
															</td>
															<td></td>																		
                                                           </tr>
                                                       </tbody>
                                                   </table>
                                               </div>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="invoice-info p-l-20 p-r-20">
                                       <h5>Other information</h5>
                                       <p class="text-muted" style="background-color: white;">This is other information</p>
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>
	    
	</section>	

</body>

</html>




