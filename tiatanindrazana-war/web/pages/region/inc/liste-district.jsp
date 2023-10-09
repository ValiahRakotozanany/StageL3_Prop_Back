<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="antenne.*"%>
<%
    String id = request.getParameter("idregion");
    District district=new District();
    String lien = (String) session.getValue("lien");
    district.setNomTable("District");
    District[] detail= (District[]) CGenUtil.rechercher(district , null, null, " and idregion = '" + id+ "'");
    
%>
    <div class="row">
       <div class="col-md-12">
           <div class="box-body">
               <table class="table table-striped table-bordered table-condensed table-responsive tree">
                    <thead>
                        <tr>
                            <th style="background-color:#bed1dd;">ID</th>
                            <th style="background-color:#bed1dd;">District</th>
                        </tr>
                       </thead>
                    <tbody>
                          <%if(detail==null || detail.length==0){%>
                          <tr>
                               <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                           </tr>
                         <%} else{
                               for(District item : detail){%> 
                           <tr class="treegrid-1 treegrid-expanded">
                               <td><a href="<%=lien%>?but=district/district-fiche.jsp&id=<%=item.getId()%>"><%=Utilitaire.champNull(item.getId())%></a></td>
                               <td><%=Utilitaire.champNull(item.getNom())%></td>
                           </tr>
                           <%}}%>
                    </tbody>
               </table>
           </div>
       </div>
    </div>