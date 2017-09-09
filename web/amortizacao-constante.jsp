<%-- 
    Document   : amortizacao-constante
    Created on : 09/09/2017, 11:21:54
    Author     : Artur
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização constante</title>
    </head>
    <body>
        <h1>Cálculo de amortização constante</h1>
        <%
            double valorFinanciado = 0;
            int meses = 0;
            double juros = 0;
            double amortizacao = 0;
            double valorJuros = 0;
            double acumulaParcela = 0, acumulaJuros = 0, acumulaAmortizacao = 0;
            try {
                valorFinanciado = Double.parseDouble(request.getParameter("txt_valor"));
                meses = Integer.parseInt(request.getParameter("txt_meses"));
                juros = Double.parseDouble(request.getParameter("txt_juros"));
            } 
            catch(Exception ex) {
                if (request.getParameter("txt_valor") != null && request.getParameter("txt_meses") != null && request.getParameter("txt_juros") != null) {
        %>
        <script>
            alert("Parâmetros inválidos");
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
            if (valorFinanciado > 0 && juros > 0 && meses > 0) {
                amortizacao = valorFinanciado/meses;
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
                    valorJuros = valorFinanciado*(juros/100);
                    valorFinanciado-=amortizacao;
        %>
            <tr>
                <td><%=i%></td>
                <td><%=amortizacao+valorJuros%></td>
                <td><%=amortizacao%></td>
                <td><%=valorJuros%></td>
                <td><%=valorFinanciado%></td>
            </tr>
        <%
                    acumulaParcela+=amortizacao+valorJuros;
                    acumulaJuros+=valorJuros;
                    acumulaAmortizacao+=amortizacao;
                }
        %>
            <tr>
                <td>Total</td>
                <td><%=acumulaParcela%></td>
                <td><%=acumulaAmortizacao%></td>
                <td><%=acumulaJuros%></td>
                <td></td>
            </tr>
        <%
            }
        %>
        </table>
    </body>
</html>
