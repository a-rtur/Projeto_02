package Classes;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;
/**
 *
 * @author Artur
 */
public class edicaoNumeros {
    public static String formatarVariavel(double valor) {
            DecimalFormat df;
            df = new DecimalFormat("##,###,###,##0.00", new DecimalFormatSymbols(new Locale("pt", "BR")));
            df.setMinimumFractionDigits(2);
            df.setParseBigDecimal(true);
            if (valor < 1) {
                return df.format(0);
            }
            else {
                return df.format(valor);
            }
    }

    public static double aceitaVirgula(String valor) {
        double retorno;
        valor = valor.replace(',', '.'); 
        retorno = Double.parseDouble(valor);
        return retorno;
    }
}
