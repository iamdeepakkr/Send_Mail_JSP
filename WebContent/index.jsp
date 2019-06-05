<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mail Send Demo</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"> 
</head>
<body onLoad="displayResult()">
<div class="container mt-5">
   <div class="card card-body">
        	<div class="row justify-content-center">
        		<div class="col-lg-6 col-md-6 col-sm-12">
        		   <div>
        		   <h2 class="text-center font-italic">Send Mail From Here</h2>
        		   <hr>
        		   </div>
        		   <%!
        		      public static class SMTPAuthenticator extends Authenticator{
        		          public PasswordAuthentication getPasswordAuthentication()
        		          {
        		             return new PasswordAuthentication("xyz","aaaa@12345");
        		          }
        		      }
        		    %>
        		    <%
        		       int result=0;
        		       if(request.getParameter("send") != null)
        		       {
        		         String d_uname = "xyz";
        		         String d_password = "aaaa@12345";
        		         String d_host = "smtp.gmail.com";
        		         int d_port = 465;
        		         
        		         String m_to = new String();
        		         String m_from = "xyz@gmail.com";
        		         String m_subject = new String();
        		         String m_text = new String();
        		         
        		         if(request.getParameter("to") != null)
        		         {
        		            m_to = request.getParameter("to");
        		         }
        		         
        		         if(request.getParameter("subject") != null)
        		         {
        		            m_subject = request.getParameter("subject");
        		         }
        		         
        		         if(request.getParameter("message") != null)
        		         {
        		            m_text = "<h4>dear sir/ma'am</h4><br>";
        		            m_text = m_text.concat(request.getParameter("message")+"<br>");
        		            m_text = m_text.concat("<h5>Thanks&Regard</h5>");
        		            m_text = m_text.concat("<h6>BabyCareSystem</h6>");
        		         }
        		         
        		         // create a properties object
        		         Properties props = new Properties();
        		         //create an SMTPAuthenticator object
        		         SMTPAuthenticator auth = new SMTPAuthenticator();
        		         //create a mail session object
        		         Session ses = Session.getInstance(props, auth);
        		         
        		         //create a MIME style email message object
        		         MimeMessage msg = new MimeMessage (ses);
        		         msg.setContent(m_text, "text/html");
        		         msg.setSubject(m_subject);
        		         msg.setFrom(new InternetAddress(m_from));
        		         msg.addRecipient(Message.RecipientType.TO, new InternetAddress(m_to));
        		         
        		         try{
        		         
        		            Transport transport = ses.getTransport("smtps");
        		            
        		            transport.connect(d_host, d_port, d_uname, d_password);
        		            
        		            transport.sendMessage(msg, msg.getAllRecipients());
        		            
        		            transport.close();
        		            
        		            result = 1;
        		            
        		         }catch(Exception e)
        		         {
        		             out.println(e);
        		         }
        		       }
        		     %>
        		   
        			<form name="myForm" action="index.jsp" method="POST">
        				<div class="form-group">
        					<div class="input-group input-group-lg">
        						<input type="text" name="to" class="form-control" placeholder="Enter the email ID"required>
        					</div>
        				</div>
        				<div class="form-group">
        					<div class="input-group input-group-lg">
        						<input type="text" name="subject" class="form-control" placeholder="Enter the subject"required>
        					</div>
        				</div>
        				<div class="form-group">
        					<div class="input-group input-group-lg">
        						<textarea rows="5" cols="55" name="message" class="form-control" placeholder="Enter the message here...." required></textarea>
        					</div>
        				</div>
        				<div class="input-group input-group-lg">
        				    <input type="hidden" name="hidden" value="<%= result %>">
        				    <input type="submit" name="send" value="Send" class="btn btn-primary m-2">
        				    <input type="reset" name="clear" value="Clear" class="btn btn-warning m-2">    
        				</div>
        			</form>
        		</div>
        	</div>
      </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
       function displayResult(){
          if(document.myForm.hidden.value === "1")
          {
            alert("Mail send Successfully!!!!!");
          }
       }
</script>
</body>
</html>