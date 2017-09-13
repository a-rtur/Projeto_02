<%-- 
    Document   : amortizacao-americana
    Created on : 12/09/2017, 11:40:29
    Author     : Artur
    Modified on: 12/09/2017, 02:30:14
    Modified by: Muca
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Classes.edicaoNumeros"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="res/css/amortizacao.css"/>
        <title>Amortização americana</title>
        
    </head>
    
    <body>
        <div id="tudo">
            <div id="conteudo">
                <%@include file="WEB-INF/jspf/menu.jspf" %>
                <h1>Cálculo de amortização americana</h1>
                <p id="explicacao">O Sistema Americano de Amortização é um tipo de quitação de empréstimo que favorece aqueles que desejam pagar o valor principal através de uma única parcela, porém os juros devem ser pagos periodicamente ou, dependendo do contrato firmado entre as partes, os juros são capitalizados e pagos junto ao valor principal. [SILVA, Marcos Noé Pedro da., 2017]</p>
                <%
                    edicaoNumeros en = new edicaoNumeros();
                    double valorFinanciado = 0;
                    int meses = 0;
                    double juros = 0;
                    double amortizacao = 0;
                    double valorJuros = 0;
                    double acumulaParcela = 0, acumulaJuros = 0, acumulaAmortizacao = 0;
                    int aux = 0;
                    try {
                        valorFinanciado = en.aceitaVirgula(request.getParameter("txt_valor"));
                        meses = Integer.parseInt(request.getParameter("txt_meses"));
                        juros = en.aceitaVirgula(request.getParameter("txt_juros"));
                        aux = 1;
                    } 
                    catch(Exception ex) {
                        if (request.getParameter("txt_valor") != null && request.getParameter("txt_meses") != null && request.getParameter("txt_juros") != null) {
                            aux = 0;
                %>
                <script>
                    alert("Parâmetros inválidos.");
                </script>
                <%
                        }
                    }
                %>
                <form>
                    <label>Digite o valor financiado:</label>
                    <input type="number" step="0.01" name="txt_valor" id="txt_valor" required/><br/><br/>
                    <label>Digite o número de Meses:</label>
                    <input type="number" name="txt_meses" id="txt_meses" required/><br/><br/>
                    <label>Digite a taxa de Juros (%):</label><br/>
                    <input type="number" step="0.01" min="0" max="100" name="txt_juros" id="txt_juros" required/><br/><br/>
                    <input type="submit" value="Calcular" name="btn_calcular" id="btn_calcular"/>
                </form>
                <%
                    if (valorFinanciado > 0 && juros > 0 && meses > 0 && aux == 1) {
                        valorJuros = valorFinanciado*(juros/100);
                %>
                <hr/>
                <h1>Resultado do cálculo:</h1>
                <table border="1">
                    <tr>
                        <th>#</th>
                        <th>Parcelas</th>
                        <th>Amortizações</th>
                        <th>Juros</th>
                        <th>Saldo Devedor</th>
                    </tr>  
                    <%
                        for (int i = 1; i <= meses; i++) {
                        if (i != meses) {
                    %>
                    <tr>
                        <td><%=i%></td>
                        <td>R$ <%=en.formatarVariavel(amortizacao+valorJuros)%></td>
                    <td>R$ <%=en.formatarVariavel(amortizacao)%></td>
                        <td>R$ <%=en.formatarVariavel(valorJuros)%></td>
                        <td>R$ <%=en.formatarVariavel(valorFinanciado)%></td>
                    </tr>
                    <%
                        acumulaParcela+=amortizacao+valorJuros;
                        acumulaJuros+=valorJuros;
                        acumulaAmortizacao+=amortizacao;
                        }
                        else {
                    %>
                    <tr>
                        <td><%=i%></td>
                        <td>R$ <%=en.formatarVariavel(valorFinanciado+valorJuros)%></td>
                        <td>R$ <%=en.formatarVariavel(valorFinanciado)%></td>
                        <td>R$ <%=en.formatarVariavel(valorJuros)%></td>
                        <td>R$ <%=en.formatarVariavel(0)%></td>
                    </tr>
                    <%
                        acumulaParcela+=valorFinanciado+valorJuros;
                        acumulaJuros+=valorJuros;
                        acumulaAmortizacao+=valorFinanciado;
                        }
                    }
                    %>
                    <tr>
                        <td>Total</td>
                        <td>R$ <%=en.formatarVariavel(acumulaParcela)%></td>
                        <td>R$ <%=en.formatarVariavel(acumulaAmortizacao)%></td>
                        <td>R$ <%=en.formatarVariavel(acumulaJuros)%></td>
                        <td></td>
                    </tr>
                    <%
                        }
                        else if ((valorFinanciado <= 0 || juros <= 0 || meses <= 0) && aux == 1)  {
                    %>
                    <script>
                        alert("Não digite zero, ou números negativos.");
                    </script>    
                    <%
                        }
                    %>
                </table>
            </div>
            <%@include file="WEB-INF/jspf/footer.jspf" %>
        </div>
    </body>
</html>
