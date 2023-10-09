<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="historique.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
UserEJB u = null;
String acte=null;
String lien=null;
String rep=null;
String idUser=null;
%>
<%
try
{

acte=request.getParameter("acte");
//System.out.println("ACTE="+acte);
lien=(String)session.getAttribute("lien");
u=(UserEJB)session.getAttribute("u");
idUser=request.getParameter("idUser");
//System.out.println("idUser="+idUser);
if (acte.compareTo("update")==0)
{
    
   rep=u.updateUtilisateurs(idUser,request.getParameter("loginuser"),request.getParameter("pwduser"),request.getParameter("nomuser"),request.getParameter("adruser"),request.getParameter("teluser"),request.getParameter("idrole"));
  %>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-fiche.jsp&refuser=<%=rep%>"); </script>
<%
}
if (acte.compareTo("insert")==0){
rep=u.createUtilisateurs(request.getParameter("loginuser"),request.getParameter("pwduser"),request.getParameter("nomuser"),request.getParameter("adruser"),request.getParameter("teluser"),request.getParameter("idrole"));
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-liste.jsp&refuser=<%=rep%>"); </script>
<%
}
if (acte.compareTo("delete")==0)
{
//rep=u.deleteUtilisateur(request.getParameter("id"));
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-liste.jsp"); </script>
<%
}
if (acte.compareToIgnoreCase ("desactiver")==0)
{
 u.desactiveUtilisateur(idUser);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-fiche.jsp&refuser=<%=idUser%>"); </script>
<%
}
else if (acte.compareToIgnoreCase ("activer")==0)
{
 u.activeUtilisateur(idUser);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-fiche.jsp&refuser=<%=idUser%>"); </script>
<%
}
}
catch (Exception e)
{
    e.printStackTrace();
    %>
<script language="JavaScript"> alert("<%=e.getMessage()%>");history.back(); </script>
<%
return;
}
%>


