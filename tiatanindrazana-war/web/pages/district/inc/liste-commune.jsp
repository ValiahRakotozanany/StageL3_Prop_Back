<%@page import="map.CommuneLibComplet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="antenne.*"%>
<%
    String id = request.getParameter("iddistrict");
    CommuneLibComplet commune=new CommuneLibComplet();
    String lien = (String) session.getValue("lien");
    commune.setNomTable("v_commune_lib_complet");
    CommuneLibComplet[] detail= (CommuneLibComplet[]) CGenUtil.rechercher(commune , null, null, " and iddistrict = '" + id+ "'");
    
%>
    <div class="row">
       <div class="col-md-12">
           <div class="box-body">
               <table class="table table-striped table-bordered table-condensed table-responsive tree">
                    <thead>
                        <tr>
                            <th style="background-color:#bed1dd;">ID</th>
                            <th style="background-color:#bed1dd;">Libelle</th>
                        </tr>
                       </thead>
                    <tbody>
                          <%if(detail==null || detail.length==0){%>
                          <tr>
                               <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                           </tr>
                         <%} else{
                               for(CommuneLibComplet item : detail){%> 
                           <tr class="treegrid-1 treegrid-expanded">
                               <td><a href="<%=lien%>?but=commune/commune-fiche.jsp&id=<%=item.getId()%>"><%=Utilitaire.champNull(item.getId())%></a></td>
                               <td><%=Utilitaire.champNull(item.getNom())%></td>
                           </tr>
                           <%}}%>
                    </tbody>
               </table>
           </div>
       </div>
    </div>