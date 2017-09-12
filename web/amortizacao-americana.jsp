<%-- 
    Document   : amortizacao-americana
    Created on : 12/09/2017, 11:40:29
    Author     : Artur
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Classes.edicaoNumeros"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização americana</title>
    </head>
    <body>
        <h1>Cálculo de amortização americana</h1>
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
            <label>Valor financiado:</label><br/>
            <input type="text" name="txt_valor" id="txt_valor" required/><br/><br/>
            <label>Número de Meses:</label><br/>
            <input type="text" name="txt_meses" id="txt_meses" required/><br/><br/>
            <label>Taxa de Juros (%):</label><br/>
            <input type="text" name="txt_juros" id="txt_juros" required/><br/><br/><br/>
            <input type="submit" value="Calcular" name="btn_calcular" id="btn_calcular"/><br/><br/>
        </form>
        <%
            if (valorFinanciado > 0 && juros > 0 && meses > 0 && aux == 1) {
                valorJuros = valorFinanciado*(juros/100);
        %>
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
    </body>
</html>
